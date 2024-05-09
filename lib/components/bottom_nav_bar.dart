import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.index, required this.updateIndex});
  final int index;
  final Function updateIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: (val) {
        updateIndex(val);
      },
      indicatorColor: Get.isDarkMode ? theme.carbonClr : theme.primaryClr,
      backgroundColor: Get.isDarkMode ? theme.carbonClr : theme.primaryClr,
      height: 75.0,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(4.0),
        side: BorderSide(
          width: 2.0,
          color: Get.isDarkMode ? theme.primaryClr : theme.redClr,
        )
      ),
      selectedIndex: index,
      destinations: <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
          label: 'Home'
        ),
        NavigationDestination(
          icon: Icon(CupertinoIcons.bubble_left_bubble_right_fill, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
          label: 'Chat'
        ),
      ],

    );
  }
}

