import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;


import 'package:flutter/material.dart';

class BroScreen extends StatelessWidget {
  const BroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BROTHERS', style: theme.TextThemes.headlineMedLarge(context),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      drawer: const Drawer(
        backgroundColor: theme.darkGreyClr,
        child: Column(
          children: <Widget>[
            Icon(Icons.person, color: theme.primaryClr, size: 64)
          ],
        ),
      ),
      body: const Placeholder(),
    );
  }
}