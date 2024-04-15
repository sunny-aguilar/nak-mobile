import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/services/theme_service.dart' as service;

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
          // print('snapshot data: ${snapshot.data}');
          // int index = snapshot.data;
          // print('len: ${index}');

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
          // print('snapshot data: ${snapshot.data}');
          // print('snapshot conn state: ${snapshot.connectionState}');
          // print('snapshot error: ${snapshot.hasError}');
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20,),
              Text('Edit Blog', style: theme.TextThemes.headlineMedLarge(context)),
              const SizedBox(height: 10,),

              // add text input to edit blog here
              //

              Text(widget.title),
              const SizedBox(height: 10,),
              Text(widget.text),
              const SizedBox(height: 40,),




            ],
          ),
        ),
      ),
    );
  }
}