import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

class ChatMaintenance extends StatelessWidget {
  const ChatMaintenance({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () => service.ThemeService().switchTheme(),
          ),
        ],
      ),
      body: const ChatMaintenanceBody(),
    );
  }
}

class ChatMaintenanceBody extends StatefulWidget {
  const ChatMaintenanceBody({super.key});
  @override
  State<ChatMaintenanceBody> createState() => _ChatMaintenanceBodyState();
}

class _ChatMaintenanceBodyState extends State<ChatMaintenanceBody> {

  // TODO: create variables to hold the new chat list that should update every cycle (3-5 days?)
  String chatListName = '';

  // TODO: create a function to change the chat list name every 72 hours
  void setNewChatListName() {
    DateTime start = DateTime(2024, 05, 01);
    DateTime end = DateTime(2024, 05, 02);
    Duration duration = end.difference(start);
    print('Diff: ${duration.inHours}');
  }

  // TODO: there should be a function here to create a new list every 72 hours

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Chat Maintenance Body'),
          // TODO: add functions to add a new chat list
          // chatListName = utils.Dates().getDate();
          Text('Create New List'),
        ],
      ),
    );
  }
}