import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/form_fields.dart' as form;
import 'package:nak_app/components/buttons.dart' as buttons;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // new blog section
              const Icon(Icons.edit_note, size: 50,),
              const SizedBox(height: 20,),
              Text('New Blog', textAlign: TextAlign.center, style: theme.TextThemes.loginTitle(context),),
              const SizedBox(height: 10,),

              // blog title textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: form.FormField(ctrl: _titleCtrl, label: 'Blog Title', vText: 'Please enter the title.',),
              ),
              const SizedBox(height: 20,),

              // Text textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: form.FormField(ctrl: _bodyCtrl, label: 'Blog Text', vText: 'Please enter the blog text.',),
              ),
              const SizedBox(height: 25,),

              // preview blog button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.create_rounded), Text(' Preview Blog')],),
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
                      Navigator.pushNamed(context, '/previewBlog');
                    }
                  },
                ),
              ),
              const SizedBox(height: 25,),


            ],
          ),
        ),
      ),
    );
  }
}