import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_chat.dart' as db_chat;

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

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
            future: db_chat.ChatSettings().totalChats('general_chat'),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) { _circularProgress(); }
              else if (snapshot.data == null) { _circularProgress(); }
              else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

                List<dynamic> chatList = snapshot.data?['gc']['01'];
                int totalChats = chatList.length;
                print('val: $totalChats');

                return Text('1');
              }
              return _circularProgress();
            }
          ),
          const Text('Chat Maintenance Body'),
          // TODO: add functions to add a new chat list
          // chatListName = utils.Dates().getDate();
          const Text('Create New List'),
        ],
      ),
    );
  }
}