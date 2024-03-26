import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/drawer.dart' as drawer;
import 'package:nak_app/components/featured_stories.dart' as featured;
import 'package:nak_app/ui/theme.dart' as theme;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        foregroundColor: theme.darkGreyClr,
        backgroundColor: theme.redClr,
        child: const Icon(Icons.add),
      ),
    );
  }
}