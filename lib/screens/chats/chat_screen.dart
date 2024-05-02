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
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/gchat'
              );
            },
            leading: CircleAvatar(
              foregroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
              backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.redClr,
              child: Text('GC', style: theme.TextThemes.headlineSmall(context)),
            ),
            title: const Text('General Chat'),
            subtitle: const Text('Talk about anything and everything'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/slivers'
              );
            },
            leading: CircleAvatar(
              foregroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
              backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.redClr,
              child: Text('SL', style: theme.TextThemes.headlineSmall(context)),
            ),
            title: const Text('Sliver Chat Room'),
            subtitle: const Text('Sliver Testing Room'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}