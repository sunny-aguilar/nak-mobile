import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/db/db_chat.dart' as db_chat;
import 'package:nak_app/components/utils.dart' as utils;

class ChatMaintenance extends StatefulWidget {
  const ChatMaintenance({super.key});

  @override
  State<ChatMaintenance> createState() => _ChatMaintenanceState();
}

class _ChatMaintenanceState extends State<ChatMaintenance> {
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

  // TODO: create variables to hold the new chat list that should update every cycle (500 chats?)
  String chatListName = '';

  // chat stat variables
  int totalGcChats = 0;

  // TODO: create a function to change the chat list name every 500 chat messages
  void setNewChatListName() {
    DateTime start = DateTime(2024, 05, 01);
    DateTime end = DateTime(2024, 05, 02);
    Duration duration = end.difference(start);
    print('Diff: ${duration.inHours}');
  }

  // TODO: there should be a function here to create a new list every 500 chat messages
  // copy chat list to a new one
  // delete all chats in '01' chat

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 30, width: 30,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.lightGrey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Chat Room Stats', style: theme.TextThemes.headlineMedLarge(context),),
            const SizedBox(height: 20,),
            Text('General Chat Stats', style: theme.TextThemes.headlineSmall16(context),),
            FutureBuilder(
              future: db_chat.ChatSettings().totalChats('general_chat'),
              builder: (BuildContext context, snapshot) {
                if (!snapshot.hasData) { _circularProgress(); }
                else if (snapshot.data == null) { _circularProgress(); }
                else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

                  List<dynamic> chatList = snapshot.data?['gc']['active'];
                  int totalChats = chatList.length;
                  totalGcChats = totalChats;

                  return ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const GeneraChatOptions(chatRoom: 'general_chat'))
                      );
                    },
                    leading: CircleAvatar(
                      foregroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
                      backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.redClr,
                      child: Text('$totalGcChats', style: theme.TextThemes.headlineSmall(context)),
                    ),
                    title: const Text('Total chat messages'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  );
                }
                return _circularProgress();
              }
            ),
            // TODO: add functions to add a new chat list
            // chatListName = utils.Dates().getDate();
          ],
        ),
      ),
    );
  }
}

class GeneraChatOptions extends StatelessWidget {
  const GeneraChatOptions({super.key, required this.chatRoom});
  final String chatRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Chat Room Stats', style: theme.TextThemes.headlineMedLarge(context),),
            const SizedBox(height: 12,),
            Text('Archive Chat Process', style: theme.TextThemes.headlineSmall16(context),),
            const Text('Chats will be archived using a timestamp. Any archives will be datestamped with a date stamped and saved in an archive.',),
            const SizedBox(height: 12,),
            Text('Chat Room Data:', style: theme.TextThemes.headlineSmall16(context),),
            Text('Chat Room: $chatRoom\nTimestamp: ${utils.Dates().getDateTime()}'),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: () {},
              style: buttons.chatButton(context, theme.redClr),
              child: const Text('Archive Chat', style: TextStyle(color: theme.primaryClr),),
            ),
          ],
        ),
      ),
    );
  }
}