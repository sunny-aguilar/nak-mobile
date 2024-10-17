import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/screens/social/profile_screen.dart' as profile;




class BroScreen extends StatelessWidget {
  const BroScreen({super.key});

  // navigate to profile page
  void goToProfilePage(context) {
    // pop menu drawer
    Navigator.pop(context);
    // go to profile page
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const profile.ProfilePageScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('NAK SPACE', style: theme.TextThemes.headlineMedLarge(context),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: <Widget>[
                Theme(
                  // wrapped DrawerHeder to remove bottom border line
                  data: Theme.of(context).copyWith(
                    dividerTheme: const DividerThemeData(color: Colors.transparent),
                  ),
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                    ),
                    child: Icon(Icons.person, color: Get.isDarkMode ? theme.primaryClr : theme.darkGreyClr, size: 64),
                  ),
                ),
                // home page
                MenuListItem(icon: Icons.home, text: 'H O M E', onTap: ()=> Navigator.pop(context),),
                // user profile
                MenuListItem(icon: Icons.remember_me, text: 'P R O F I L E', onTap: ()=> goToProfilePage(context),),
                // brother list
                MenuListItem(icon: Icons.remember_me, text: 'B R O T H E R S', onTap: ()=> goToProfilePage(context)),
              ],
            ),
            // back to NAK App
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: MenuListItem(icon: Icons.logout_outlined, text: 'N A K   A P P', onTap: ()=> Navigator.pushNamed(context, '/home'),),
            ),
          ],
        ),
      ),
      body: const Placeholder(),
    );
  }
}


class MenuListItem extends StatelessWidget {
  const MenuListItem({super.key, required this.icon, required this.text, required this.onTap});
  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        onTap: onTap,
      ),
    );
  }
}