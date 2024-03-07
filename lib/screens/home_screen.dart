import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
// import 'package:url_launcher/url_launcher.dart';
import '../components/drawer.dart' as drawer;
import 'package:nak_app/components/featured_stories.dart' as featured;
// import '../components/carousel.dart';
// import '../components/cards.dart';

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
            icon: Get.isDarkMode ? const Icon(Icons.nightlight_outlined) : const Icon(Icons.wb_sunny_outlined),
            onPressed: () {
              // print('Dark Theme Button Clicked');
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      drawer: const drawer.DrawerComponent(),
      body: const featured.HomeScreenChildren(),
    );
  }
}