import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.index, required this.updateIndex});
  final int index;
  final Function updateIndex;
  // int index = 0;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (val) {
        updateIndex(val);
      },
      indicatorColor: Get.isDarkMode ? theme.carbonClr : theme.primaryClr,
      backgroundColor: Get.isDarkMode ? theme.carbonClr : theme.primaryClr,
      shadowColor: theme.carbonClr,
      height: 75.0,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(4.0),
        side: const BorderSide(
          width: 3.0,
          color: theme.redClr,
        )
      ),
      elevation: 4.0,
      selectedIndex: index,
      destinations: <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
          label: 'Home'
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_bubble, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
          label: 'Chat'
        ),
      ],

    );
  }
}

