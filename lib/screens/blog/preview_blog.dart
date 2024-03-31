import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nak_app/screens/home_screen.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/cards.dart' as  cards;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/components/screen_args.dart' as screenargs;

class PreviewBlog extends StatefulWidget {
  const PreviewBlog({super.key});
  @override
  State<PreviewBlog> createState() => _PreviewBlogState();
}

class _PreviewBlogState extends State<PreviewBlog> {
  String _imageUrl = '';


  void uploadImages(screenArgs, path) async {
    /* This function uploads images to Firebase Storage */

    // used to create a unique file name
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    // create a reference to root directory
    final storageRef = FirebaseStorage.instance.ref();

    // upload image and save image url in Firebase storage
    Reference imageReference = storageRef.child('/blog');

    // create a ref for the image to be stored (make sure you use unique file name)
    Reference referenceImageToUpload = imageReference.child('blog_$uniqueFileName');

    // store image to firestore
    String filePath = path;
    File file = File(filePath);
    try {
      // upload
      await referenceImageToUpload.putFile(file);

      // get image URL
      _imageUrl = await referenceImageToUpload.getDownloadURL();
      // print('Img URL: $imageUrl');

    } catch (e) {
      // some error occurred
      print('File Upload Error: $e');
    }

    // store data to firestore
    saveBlogtoFirestore(screenArgs);
  }


  void saveBlogtoFirestore(screenArgs) async {
    /* This function saves the blog data to the Firestore */

    // get user name
    final userData = await db.UserService().getData();
    String userName = '${userData['firstName']} ${userData['lastName']}';

    // get user UID | USER ID ALREADY IN userData!!!!!!!!!! No need to this, just use userData['uid']
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userUID = auth.currentUser!.uid;

    // get Firebase instance & reference to collection
    final reference = FirebaseFirestore.instance.collection('blog');

    // create a map to send
    Map<String, String> dataToSend = {
      'name': userName,
      'title': screenArgs.title,
      'url': _imageUrl,
      'body': screenArgs.body,
      'date': screenArgs.date,
      'userUID': userUID,
    };

    // add the data to Firestore
    var docRef = await reference.add(dataToSend);

    // get the doc ID just added to Firestore
    String docID = docRef.id;

    // add ID to map
    dataToSend = {
      'docID': docID,
    };

    // append doc ID (merge = true) to Firestore doc
    await reference.doc(docID).set(dataToSend, SetOptions(merge: true));
  }


  // widget built by Futurebuilder
  Column buildPreview(context, data) {
    // extract the args from the current route
    final args = ModalRoute.of(context)!.settings.arguments as screenargs.BlogArgs;
    String date = DateFormat.yMMMMd('en_US').format(DateTime.now());

    return Column(
      children: <Widget>[

        // show Card with data
        const SizedBox(height: 20),
        cards.LargeGreyPictureCard(
          userImage: '${data['selfie']}',
          userName: '${data['firstName']} ${data['lastName']}',
          storyHeadline: args.title,
          image: args.path,
          date: date,
          storyText: args.body,
        ),
        const SizedBox(height: 25,),

        // preview blog button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextButton(
            style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.arrow_back_ios), Text('Back to Edits')],),
            onPressed: () {
              // process data if form is valid
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 1100),
                  content: Text('Back to edit screen...')
                ),
              );
              // function that will prepare the blog preview
              // - have it take you to another page to show the preview
              // - after preview, either go back and edit or post and route to home page
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 25,),

        // post blog button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextButton(
            style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.send), Text(' Post Blog')],),
            onPressed: () {

              // process data if form is valid
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 1400),
                  content: Text('Submitting blog...')
                ),
              );

              // Future used to upload file to storage
              uploadImages(args, args.path);

              // navigate back home after posting image
              Navigator.of(context, rootNavigator: false).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),
              );

            },
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),

      // Future builder
      body: FutureBuilder(
        future: db.UserService().getData(),
        builder: (BuildContext context, snapshot) {

          // diplay circular indicator while it waits for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  color: theme.redClr
                ),
              ),
            );
          }

          // check if there is an error otherwise display final result
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'An ${snapshot.error} occurred'
                ),
              );
            }
            else if(snapshot.hasData) {
              final data = snapshot.data;
              return buildPreview(context, data);
            }
          }

          // display default value
          return const Center(
            child: SizedBox(
              height: 150,
                width: 150,
              child: CircularProgressIndicator(
                color: theme.azureClr,
              ),
            ),
          );
        }


      ),
    );
  }
}