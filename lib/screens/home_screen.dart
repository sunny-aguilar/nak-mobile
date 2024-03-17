import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nak_app/screens/login_screen.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import '../components/drawer.dart' as drawer;
import 'package:nak_app/components/featured_stories.dart' as featured;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            // icon: service.ThemeService.getIcon(),
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.nightlight_outlined),
            onPressed: () {
              // print('Dark Theme Button Clicked');
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      drawer: drawer.DrawerComponent(),
      body: const featured.HomeScreenChildren(),
      // body: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return const featured.HomeScreenChildren();
      //     }
      //     else {
      //       return const LoginScreen();
      //       // Navigator.pushNamed(context, '/home');
      //       // return Placeholder();
      //     }
      //   },
      // ),
    );
  }
}