import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/form_fields.dart' as form;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/components/screen_args.dart' as args;

class NewBlogScreen extends StatefulWidget {
  const NewBlogScreen({super.key});
  @override
  State<NewBlogScreen> createState() => _NewBlogScreenState();
}

class _NewBlogScreenState extends State<NewBlogScreen> {
  // form key
  final _blogKey = GlobalKey<FormState>();

  // text controllers
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _bodyCtrl = TextEditingController();

  // image picker
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;
  File? file;
  String? path;
  dynamic _pickImageError;


  Future<void> _pickImageFromGallery() async {
    try {
      final image = await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
        path = image.path;
        print('Path in _pickImage: $path');
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
      body: SingleChildScrollView(
        child: Form(
          key: _blogKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[


              // new blog section
              const Icon(Icons.edit_note, size: 50,),
              const SizedBox(height: 20,),
              Text('New Blog', textAlign: TextAlign.center, style: theme.TextThemes.loginTitle(context),),
              const SizedBox(height: 10,),


              // blog title textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: form.SmallFormField(ctrl: _titleCtrl, label: 'Blog Title', vText: 'Please enter the title.',),
              ),
              const SizedBox(height: 20,),


              // Text textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: form.ParagraphFormField(ctrl: _bodyCtrl, label: 'Blog Text', vText: 'Please enter the blog text.',),
              ),
              const SizedBox(height: 25,),


              // image text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text('Select an image for the blog. A default image will be applied if none is selected.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 15,),


              // image container
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr),
                    // color: theme.primaryClr,
                  ),
                  child: path != null ? Image.file(File(path!)) : FadeInImage.assetNetwork(
                    placeholder: 'assets/img/stories/image_loading.gif',
                    placeholderScale: 4,
                    imageScale: 1,
                    image: 'https://firebasestorage.googleapis.com/v0/b/nak-app-a899e.appspot.com/o/add_image.png?alt=media&token=c947477c-ec0e-40a8-808f-1564cc43fd77',
                  ),
                ),
              ),
              const SizedBox(height: 25,),


              // buttons to pick image for blog
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () => _pickImageFromCamera(),
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size.fromHeight(80),
                      side: BorderSide(width: 2, color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      foregroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                    ),
                    child: const Icon(Icons.camera_alt, size: 50),
                  ),
                  const SizedBox(width: 40,),
                  OutlinedButton(
                    onPressed: () => _pickImageFromGallery(),
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size.fromHeight(80),
                      side: BorderSide(width: 2, color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      foregroundColor: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr,
                    ),
                    child: const Icon(Icons.photo_rounded, size: 50),
                  ),
                ],
              ),
              const SizedBox(height: 25,),


              // preview blog button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.create_rounded), Text(' Preview Blog')],
                  ),
                  onPressed: () {
                    if (_blogKey.currentState!.validate()) {
                      // process data if form is valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1400),
                          content: Text('Prepping blog post preview...')
                        ),
                      );


                      // function that will prepare the blog preview
                      // - have it take you to another page to show the preview
                      // - after preview, either go back and edit or post and route to home page
                      // TODO: FIX BUG WHERE USER DOES NOT UPLOAD A PHOTO, ERROR IS CAUSED BY FIRESTORE STORAGE
                      // TODO: FIX line 'path: path ?? 'path/to/img.png',
                      String date = DateFormat.yMMMMd('en_US').format(DateTime.now());
                      Navigator.pushNamed(
                        context,
                        '/previewBlog',
                        arguments: args.BlogArgs(
                          title: _titleCtrl.text.trim(),
                          body: _bodyCtrl.text.trim(),
                          date: date,
                          path: path ?? 'assets/img/stories/default_blog_image.png',
                        ),
                      );


                    }
                  },
                ),
              ),
              const SizedBox(height: 40,),


            ],
          ),
        ),
      ),
    );
  }
}