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
import 'dart:async';

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
  bool _isLoading = false;

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
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12),),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buttons.CameraButton(icon: Icons.camera_alt, func: _pickImageFromCamera,),
                  buttons.CameraButton(icon: Icons.photo_rounded, func: _pickImageFromGallery,),
                ],
              ),
            ),
            const SizedBox(height: 15,),

            // Upload Button
            FilledButton(
              style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
              child: _isLoading ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.primaryClr,
                    ),
                  ),
                  SizedBox(width: 12,),
                  Text('Upload Photo')
                ],
              ) : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.cloud_upload), SizedBox(width: 12,), Text('Upload Photo')],
              ),
              onPressed: () {
                // upload selfie to Firebase Storage & save URL in Firestore
                _isLoading = true;
                setState(() {});

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 3500),
                    content: Text('Uploading photo...')
                  ),
                );

                // upload photo
                _uploadSelfie();

              },
            ),

          ],
        ),
      ),
    );
  }
}