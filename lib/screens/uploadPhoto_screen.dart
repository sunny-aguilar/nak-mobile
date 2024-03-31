import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});
  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  // pick image variables
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;
  File? file;
  String? path;
  dynamic _pickImageError;

  // get storage variables
  // final _box = GetStorage();
  // final _key = 'imagePath';


  Future<void> _pickImageFromGallery() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
        path = image.path;
        // _box.write(_key, image.path);
        // print('Box: ${_box.read(_key)}');
      });
    } catch (e) {
      setState(() { _pickImageError = e;});
    }
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final image = await _imagePicker.pickImage( source: ImageSource.camera);
      setState(() {
        _image = image;
        file = File(image!.path);
        path = image.path;
        // _box.write(_key, image.path);
      });
    } catch (e) {
      setState(() { _pickImageError = e;});
    }
  }

  Future<void> _uploadSelfie() async {
    String imageUrl = '';

    // used to create a unique file name
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    // create a reference to root directory
    final storageRef = FirebaseStorage.instance.ref();

    // upload image and save image url in Firebase storage
    Reference imageReference = storageRef.child('/selfies');

    // create a ref for the image to be stored (make sure you use unique file name)
    Reference referenceImageToUpload = imageReference.child('selfies_$uniqueFileName');

    // store image to firestore
    String filePath = path!;
    File file = File(filePath);
    try {
      // upload
      await referenceImageToUpload.putFile(file);

      // get image URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
      // print('Img URL: $imageUrl');

    } catch (e) {
      // some error occurred
      print('File Upload Error: $e');
    }

    // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

    // save Selfie URL to user
    final userData = await db.UserService().getData();

    // get a reference to Firestore and the doc
    final reference = FirebaseFirestore.instance.collection('users').doc(userData['uid']);

    // create a map to send
    Map<String, String> dataToSend = {
      'selfie': imageUrl,
    };

    // append the selfie URL to Firestore doc
    await reference.set(dataToSend, SetOptions(merge: true));

    // navigate back to prior screen
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 0.0, bottom: 0.0),
        child: ListView(
          children: <Widget>[

            // Chapter Identification Container
            const SizedBox(height: 20,),
            Container(
              height: 65,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.shawdowClr : theme.pinkClr,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Upload Your Photo',
                      style: theme.TextThemes.idTitle(context),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset('assets/img/nak_letters.png', width: 95,),
                  ),
                ],
              ),
            ),

            // User Photo Container
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.charcoalClr : theme.redOfficial,
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30,),
                  Container(
                    height: 250,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: theme.primaryClr,
                    ),
                    child: path != null ?
                    Image.file(
                      File(path!),
                      fit: BoxFit.cover,
                    ) :
                    Image.asset('assets/img/users/profile.webp'),
                  ),
                ],
              ),
            ),

            // bottom container with buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 120,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.shawdowClr : theme.pinkClr,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buttons.CameraButton(icon: Icons.camera_alt, func: _pickImageFromCamera,),
                  buttons.CameraButton(icon: Icons.photo_rounded, func: _pickImageFromGallery,),
                ],
              ),
            ),

            // Upload Button
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                height: 90,
                decoration: BoxDecoration(
                color: Get.isDarkMode ? theme.shawdowClr : theme.pinkClr,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
                ),
                child: FilledButton(
                  // style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleMinLight(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.primaryClr,
                    maximumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.create_rounded), Text('Upload Photo')],
                  ),
                  onPressed: () async {

                    // upload selfie to Firebase Storage & safe URL in Firestore
                    _uploadSelfie();

                    String _imageUrl = '';

                    // used to create a unique file name
                    // String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                    // // create a reference to root directory
                    // final storageRef = FirebaseStorage.instance.ref();

                    // // upload image and save image url in Firebase storage
                    // Reference imageReference = storageRef.child('/selfies');

                    // // create a ref for the image to be stored (make sure you use unique file name)
                    // Reference referenceImageToUpload = imageReference.child('selfies_$uniqueFileName');

                  //   // store image to firestore
                  //   String filePath = path;
                  //   File file = File(filePath);
                  //   try {
                  //     // upload
                  //     await referenceImageToUpload.putFile(file);

                  //     // get image URL
                  //     _imageUrl = await referenceImageToUpload.getDownloadURL();
                  //     // print('Img URL: $imageUrl');

                  //   } catch (e) {
                  //     // some error occurred
                  //     print('File Upload Error: $e');
                  //   }

                  // // save Selfie URL to user
                  // final userData = await db.UserService().getData();

                  // print('Data: ${userData['firstName']}');
                  // print('UID: ${userData['uid']}');


                  // // get a reference to Firestore and the doc
                  // final reference = FirebaseFirestore.instance.collection('users').doc(userData['uid']);

                  // // create a map to send
                  // Map<String, String> dataToSend = {
                  //   'selfie': _imageUrl,
                  // };

                  // // append the selfie URL to Firestore doc
                  // await reference.set(dataToSend, SetOptions(merge: true));

                  // if (mounted) {
                  //   Navigator.of(context).pop();
                  // }
                    // if (_blogKey.currentState!.validate()) {
                      // process data if form is valid
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     duration: Duration(milliseconds: 1400),
                      //     content: Text('Prepping blog post preview...')
                      //   ),
                      // );


                      // function that will prepare the blog preview
                      // - have it take you to another page to show the preview
                      // - after preview, either go back and edit or post and route to home page
                      // TODO: FIX BUG WHERE USER DOES NOT UPLOAD A PHOTO, ERROR IS CAUSED BY FIRESTORE STORAGE
                      // TODO: FIX line 'path: path ?? 'path/to/img.png',
                      // String date = DateFormat.yMMMMd('en_US').format(DateTime.now());
                      // Navigator.pushNamed(
                      //   context,
                      //   '/previewBlog',
                      //   arguments: args.BlogArgs(
                      //     title: _titleCtrl.text.trim(),
                      //     body: _bodyCtrl.text.trim(),
                      //     date: date,
                      //     path: path ?? 'assets/img/stories/default_blog_image.png',
                      //   ),
                      // );


                    // }
                  },
                ),
              ),

          ],
        ),
      ),
    );
  }
}