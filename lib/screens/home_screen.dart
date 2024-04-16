import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/drawer.dart' as drawer;
import 'package:nak_app/components/featured_stories.dart' as featured;
import 'package:nak_app/db/db_ops.dart' as db;
import 'package:nak_app/components/scaffolds.dart' as scaffolds;
import 'package:nak_app/components/bottom_nav_bar.dart' as nav;
import 'package:nak_app/screens/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> isAdmin = db.AuthCheck().isAdminOrSuperAdmin('superAdmin');

  int index = 0;

  void updateIndex(val) {
    setState(() {
      index = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          // const Icon(Icons.message_outlined),
          // const SizedBox(width: 10,),
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      drawer: const drawer.DrawerComponent(),

      body: <Widget>[
        // bottom nav screens
        const featured.HomeScreenChildren(),
        const ChatScreen()
      ][index],

      bottomNavigationBar: nav.BottomNavBar(index: index, updateIndex: updateIndex,),
      floatingActionButton: FutureBuilder<String>(
        future: isAdmin,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            return scaffolds.ScaffoldType().nonadminUser(context);
          }
          else if (snapshot.hasData) {
            if (snapshot.data == 'superAdmin') {
              //return superAdmin floating action button
              return const scaffolds.SpeedDialButton();
            }
            else if (snapshot.data == 'admin') {
              //return admin floating action button
              return scaffolds.ScaffoldType().adminUser(context);
            }
            else {
              return scaffolds.ScaffoldType().nonadminUser(context);
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