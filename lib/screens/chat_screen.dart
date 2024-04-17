import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.context});
  final BuildContext context;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   actions: <Widget>[
      //     // const Icon(Icons.message_outlined),
      //     // const SizedBox(width: 10,),
      //     IconButton(
      //       icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
      //       onPressed: () {
      //         service.ThemeService().switchTheme();
      //       },
      //     ),
      //   ],
      // ),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {},
            leading: CircleAvatar(
              foregroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
              backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.redClr,
              child: Text('GC', style: theme.TextThemes.headlineSmall(context)),
            ),
            title: Text('General Chat'),
            subtitle: Text('Talk about anything and everything'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}