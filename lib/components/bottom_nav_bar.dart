import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (val) {
        setState(() {
          index = val;
        });
      },
      indicatorColor: Get.isDarkMode ? theme.carbonClr : theme.redClr,
      selectedIndex: index,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home'
        ),
        NavigationDestination(
          icon: Icon(Icons.message_outlined),
          label: 'Msg'
        ),
      ],

    );
  }
}

