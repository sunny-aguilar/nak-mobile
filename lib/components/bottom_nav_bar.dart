import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.index, required this.updateIndex});
  final int index;
  final Function updateIndex;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(removeBottom: true),
      child: NavigationBar(
        onDestinationSelected: (val) {
          updateIndex(val);
        },
        labelPadding: EdgeInsets.all(0),
        indicatorColor: Get.isDarkMode ? theme.greyUI : theme.offWhiteClr2,
        backgroundColor: Get.isDarkMode ? theme.carbonClr : theme.primaryClr,
        height: 68.0,
        // indicatorShape: RoundedRectangleBorder(
        //   borderRadius: BorderRadiusDirectional.circular(4.0),
        //   side: BorderSide(
        //     width: 2.0,
        //     color: Get.isDarkMode ? theme.primaryClr : theme.redClr,
        //   )
        // ),
        selectedIndex: index,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
            label: ''
          ),
          NavigationDestination(
            // icon: Icon(Icons.home, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
            icon: FaIcon(FontAwesomeIcons.solidAddressBook, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
            label: ''
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.bubble_left_bubble_right_fill, color: Get.isDarkMode ? theme.whiteClr : theme.redClr,),
            label: ''
          ),
        ],
      ),
    );
  }
}

