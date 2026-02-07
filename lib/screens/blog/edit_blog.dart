import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
// import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/db/db_blog.dart' as db_blog;
import 'package:nak_app/db/db_storage.dart' as db_storage;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;

class BlogList extends StatefulWidget {
  const BlogList({super.key});
  @override
  State<BlogList> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<BlogList> {
  List blogList = [];

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

  Future<void> _handleRefresh() async { setState(() {}); }

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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: theme.redClr,
        backgroundColor: theme.charcoalClr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  Text('Select a blog to edit', style: theme.TextThemes.headlineSmall(context),),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
            FutureBuilder(
              future: db_blog.Blog().getAllBlogs(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

                if (!snapshot.hasData) { return _circularProgress(); }
                else if (snapshot.data == null) { _circularProgress(); }
                else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

                  int count = snapshot.data!.length;
                  final blog = snapshot.data!;

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return EditBlog(
                                  title: blog[index]['title'],
                                  body: blog[index]['body'],
                                  docID: blog[index]['docID'],
                                  url: blog[index]['url'],
                                );
                              }
                            ),
                          );

                        },
                        // leading: Text(blog[index]['date']),
                        leading: const Icon(Icons.book_outlined),
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
          ],
        ),
      ),

    );
  }
}

class EditBlog extends StatefulWidget {
  const EditBlog({super.key,
    required this.title,
    required this.body,
    required this.docID,
    required this.url}
  );
  final String title;
  final String body;
  final String docID;
  final String url;
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
    _bodyCtl = TextEditingController(text: widget.body);
  }

  @override
  void dispose() {
    _titleCtl.dispose();
    _bodyCtl.dispose();
    super.dispose();
  }

  String parseURL(String url) {
    // String temp = 'https://firebasestorage.googleapis.com/v0/b/nak-app-a899e.appspot.com/o/blog%2Fblog_1713235082696.jpeg?alt=media&token=126858df-6cfa-4d87-a71a-64607e042268';
    String  parsedURL = '';
    print('URL: $url');
    List splitted = url.split('?');
    parsedURL = splitted[0];
    print('parsedURL: $parsedURL');
    splitted = parsedURL.split('..');
    parsedURL = splitted[1];
    print('splitted: $parsedURL');
    return parsedURL.trim();
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


                // title
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30,),


                // form submit button
                TextButton(
                  style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
                  child: const Text('Submit Edits'),
                  onPressed: () {

                    // update blog
                    db_blog.Blog().updateBlogEntry(widget.docID, _titleCtl.text.trim(), _bodyCtl.text.trim());
                    Navigator.pop(context);

                    // show snackbar
                    if (_editBlogFormKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Submitting the edits...'),),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12,),


                // form delete button
                TextButton(
                  style: buttons.buttonStyleRed(context),
                  child: const Text('Delete Blog'),
                  onPressed: () {

                    // modal dialog to delete blog
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text('The blog entry will be deleted. This action cannot be undone.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {

                                // parse the URL
                                // print('url: ${widget.url}');
                                String parsedURL = parseURL(widget.url);

                                // delete the blog image
                                db_storage.Storage().deleteAsset('..$parsedURL');

                                // delete the blog entry
                                db_blog.Blog().deleteBlogEntry(widget.docID);

                                // show snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Deleting blog entry...'),),
                                );

                                // navigate back to the blog list
                                Navigator.pop(context);
                                Navigator.pop(context);

                              },
                              style: buttons.buttonStyleRed(context),
                              child: const Text('Delete'),
                            ),
                            const SizedBox(height: 10.0,),
                            TextButton(
                              onPressed: () { Navigator.pop(context, 'cancel'); },
                              style: buttons.buttonStyleLightTheme(context),
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      }
                    );

                  },
                ),
                 const SizedBox(height: 40,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}