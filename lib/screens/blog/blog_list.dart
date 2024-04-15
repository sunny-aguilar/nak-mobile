import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/services/theme_service.dart' as service;

class EditBlogScreen extends StatefulWidget {
  const EditBlogScreen({super.key});
  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {

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
                  onTap: () {},
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