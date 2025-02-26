import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;


class StatusCompliance extends StatefulWidget {
  const StatusCompliance({super.key});
  @override
  State<StatusCompliance> createState() => _StatusComplianceState();
}

class _StatusComplianceState extends State<StatusCompliance> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
            ),
            child: Image.asset(Get.isDarkMode ? 'assets/img/nak_letters_bw.png' : 'assets/img/nak_letters.png',),
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back_ios_new),
            title: const Text('Exit'),
            onTap: () {},
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}


class DrawerChapterCompliance extends StatefulWidget {
  const DrawerChapterCompliance({super.key});
  @override
  State<DrawerChapterCompliance> createState() => _DrawerChapterComplianceState();
}

class _DrawerChapterComplianceState extends State<DrawerChapterCompliance> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
            ),
            child: Image.asset(Get.isDarkMode ? 'assets/img/nak_letters_bw.png' : 'assets/img/nak_letters.png',),
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back_ios_new),
            title: const Text('Exit'),
            onTap: () {},
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}


class DrawerDirectorCompliance extends StatefulWidget {
  const DrawerDirectorCompliance({super.key});
  @override
  State<DrawerDirectorCompliance> createState() => _DrawerDirectorCompliance();
}

class _DrawerDirectorCompliance extends State<DrawerDirectorCompliance> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
            ),
            child: Image.asset(Get.isDarkMode ? 'assets/img/nak_letters_bw.png' : 'assets/img/nak_letters.png',),
          ),
          ListTile(
            title: Text('Director Compliance'),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}