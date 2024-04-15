import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;

class BlogList extends StatefulWidget {
  const BlogList({super.key});
  @override
  State<BlogList> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<BlogList> {

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
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
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: FutureBuilder(
        future: db.Blogs().getAllBlogs(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

          if (!snapshot.hasData) { return _circularProgress(); }
          else if (snapshot.data == null) { _circularProgress(); }
          else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

            int count = snapshot.data!.length;
            final blog = snapshot.data!;

            return ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return EditBlog(title: blog[index]['title'], text: blog[index]['body']);
                        }
                      ),
                    );

                  },
                  leading: Text(blog[index]['date']),
                  title: Text(blog[index]['name']),
                  subtitle: Text(blog[index]['title']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              },
            );
          }
          return _circularProgress();
        },
      ),

    );
  }
}

class EditBlog extends StatefulWidget {
  const EditBlog({super.key, required this.title, required this.text});
  final String title;
  final String text;
  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final _editBlogFormKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController _titleCtl = TextEditingController();
  TextEditingController _bodyCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleCtl = TextEditingController(text: widget.title);
    _bodyCtl = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _titleCtl.dispose();
    _bodyCtl.dispose();
    super.dispose();
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
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  8.0,),
          child: Form(
            key: _editBlogFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20,),
                Text('Edit Blog', style: theme.TextThemes.headlineMedLarge(context)),
                const SizedBox(height: 10,),

                // title text input
                Text(widget.title),
                const SizedBox(height: 20,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    helperText: 'Edit the title'
                  ),
                  controller: _titleCtl,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20,),


                // body text input
                TextFormField(
                  maxLines: 16,
                  decoration: const InputDecoration(
                    labelText: 'Blog Text',
                    helperText: 'Edit the text body'
                  ),
                  controller: _bodyCtl,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 30,),


                // form submit button
                TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: const Text('Submit Edits'),
                  onPressed: () {
                    // submitForm(_formData, _nameCtl.text, _emailCtl.text, _natureCtl.text, _urgencyCtl.text, _dateCtl.text, _locationCtl.text, _descCtl.text, _uniCtl.text, _policeCtl.text, _followUpCtl.text);

                    // if (_formKey.currentState!.validate()) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Submitting report...')),
                    //   );
                    //   sendEmail(context, _formData);
                    // }
                  },
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}