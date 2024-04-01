import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/drawer.dart' as drawer;
import 'package:nak_app/components/featured_stories.dart' as featured;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_ops.dart' as db;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> isAdmin = db.AuthCheck().isAdmin('admin');

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
      drawer: const drawer.DrawerComponent(),
      body: const featured.HomeScreenChildren(),
      // body: FutureBuilder(
      //   future:
      // ),
      floatingActionButton: FutureBuilder<bool>(
        future: isAdmin,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            return ScaffoldType().nonadminUser(context);
          }
          else if (snapshot.hasData) {
            if (snapshot.data == true) {
              return ScaffoldType().adminUser(context);
            }
            else {
              return ScaffoldType().nonadminUser(context);
            }
          }
          else {
            return const SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
            );
          }
        },
      ),
    );
  }
}

// return a floating action button for users who are admins
class ScaffoldType {
  SizedBox nonadminUser(context) {
    return const SizedBox.shrink();
  }

  FloatingActionButton adminUser(context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.pushNamed(context, '/newBlog');
      },
      foregroundColor: theme.primaryClr,
      backgroundColor: theme.redClr,
      label: const Text('Blog'),
      icon: const Icon(Icons.add),
    );
  }
}