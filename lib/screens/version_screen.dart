import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class VersionScreen extends StatelessWidget {
  const VersionScreen({super.key});

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('88', style: theme.TextThemes.versionYear(context)),
              const SizedBox(height: 160,),
              Container(
                height: 46,
                width: 100,
                decoration: BoxDecoration(
                  color: theme.lightGrey,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(child: Text('0.1.14', style: theme.TextThemes.versionNum(context),)),
              ),
              const SizedBox(height: 20,),
              Text('NU ALPHA', style: theme.TextThemes.versionHeadline(context),),
              Text('KAPPA', style: theme.TextThemes.versionHeadline(context),),
              Text('FRATERNITY', style: theme.TextThemes.versionHeadline(context),),
              const SizedBox(height: 16,),
              Text('Mind.Culture.Pride.', style: theme.TextThemes.versionSlogan(context),),
              const SizedBox(height: 26,),
              Text('Created by: Sandro Aguilar, ID #33', style: theme.TextThemes.versionDesign(context),),
            ],
          ),
        ),
      ),
    );
  }
}