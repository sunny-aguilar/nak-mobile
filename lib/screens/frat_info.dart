import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;

class FratInfo extends StatelessWidget {
  const FratInfo({super.key});

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
      body: const FratInfoBody(),
    );
  }
}

class FratInfoBody extends StatelessWidget {
  const FratInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Hello World'),
        ],
      ),
    );
  }
}