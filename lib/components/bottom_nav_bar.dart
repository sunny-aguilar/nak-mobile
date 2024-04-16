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

  final menuItemList =[
    const MenuItem(Icons.home, 'Home'),
    const MenuItem(Icons.message_outlined, 'Msg')
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.redClr,
      unselectedItemColor: theme.lightGrey,
      selectedItemColor: theme.primaryClr,
      currentIndex: index,
      onTap: (val) {
        setState(() {
          index = val;
        });
      },
      items: menuItemList.map(
        (MenuItem menuItem) => BottomNavigationBarItem(
          backgroundColor: theme.azureClr,
          icon: Icon(menuItem.iconData),
          label: menuItem.text,
        )).toList(),
      );
    // );
  }
}

class MenuItem {
  const MenuItem(this.iconData, this.text);
  final IconData iconData;
  final String text;
}