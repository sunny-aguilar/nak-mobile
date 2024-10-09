import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;




class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Profile', style: theme.TextThemes.headlineMedLarge(context),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 50,),
          const Icon(Icons.person, size: 72,),
          const SizedBox(height: 30,),
          Text(
            'Current User',
            textAlign: TextAlign.center,
            style: theme.TextThemes.headlineMedLarge(context).copyWith(color: theme.shawdowClr),
          ),
          const SizedBox(height: 50,),
          const InfoTextBox(text: 'Sandro Aguilar', sectionName: 'Name'),
        ],
      ),
    );
  }
}


class InfoTextBox extends StatelessWidget {
  const InfoTextBox({super.key, required this.text, required this.sectionName});
  final String text;
  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 15, right: 5, bottom: 15),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? theme.graphiteClr : theme.chatGreyClr,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: theme.TextThemes.fontCollegeNN(context, 14).copyWith(color: theme.shawdowClr),),
              IconButton(onPressed: (){}, icon: const Icon(Icons.settings, color: theme.shawdowClr,))
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}