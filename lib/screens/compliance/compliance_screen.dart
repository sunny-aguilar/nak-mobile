import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;


class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 38,
        title: Text('Chapter Compliance', style: theme.TextThemes.headlineSmall20(context),),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10,),
          Stack(
            // first element starts at the bottom of stack
            children: <Widget>[
              Container(color: Colors.grey, height: 280, width: double.infinity,),
              Container(color: Colors.red, height: 180, width: double.infinity,),
              Positioned(
                bottom: 60.0,
                left: 0.0,
                child: Container(
                  height: 140, width: 110,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(18.0), bottomRight: Radius.circular(18.0))
                  ),
                )
              ),
            ],
          ),
          const Text('Chapter compliance is how chapters establish themselves on a yearly basis in order to be recognized by the national fraternity and their university.', textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}