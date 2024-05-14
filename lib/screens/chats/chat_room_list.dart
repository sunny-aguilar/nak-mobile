import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_chat.dart' as db;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.context});
  final BuildContext context;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool chatEnabled = false;

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 10, width: 10,
        child: CircularProgressIndicator(
          strokeWidth: 5, color: theme.redClr, backgroundColor: theme.greyClr,
        ),
      ),
    );
  }

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
      body: ListView(
        children: <Widget>[
          FutureBuilder<bool>(
            future: db.Chat().canChat(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) { _circularProgress(); }
              else if (snapshot.data == null) { _circularProgress(); }
              else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                bool canChat = snapshot.data!;
                chatEnabled = canChat;
                Color chatStatusColor = chatEnabled ? theme.azureClr : theme.orangeClr;
                return Container(
                  height: 5,
                  decoration: BoxDecoration(color: chatStatusColor,),
                );
              }
              return _circularProgress();
            }
          ),
          ChatRoom(
            canChat: chatEnabled,
            initials: 'GC',
            room: '/gchat',
            roomName: 'General Chat',
            desc: 'Talk about anything and everything',
          ),
          ChatRoom(
            canChat: chatEnabled,
            initials: 'EC',
            room: '/echat',
            roomName: 'Fraternity Events',
            desc: 'Local and National Events Chat',
          ),
        ],
      ),
    );
  }
}


class ChatRoom extends StatelessWidget {
  const ChatRoom({
    super.key,
    required this.canChat,
    required this.room,
    required this.initials,
    required this.roomName,
    required this.desc
  });

  final bool canChat;
  final String room;
  final String initials;
  final String roomName;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (canChat) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text('Verifying chat privileges...')
            ),
          );
          Navigator.pushNamed(
            context,
            room
          );
        }
        else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Chat Disabled', textAlign: TextAlign.center,),
                content: const Text('Chat privileges are disabled.', textAlign: TextAlign.center,),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'cancel');
                    },
                    style: buttons.buttonStyleRed(context),
                    child: const Text('Ok'),
                  ),
                ],
              );
            }
          );
        }

      },
      leading: CircleAvatar(
        foregroundColor: Get.isDarkMode ? theme.darkGreyClr : theme.primaryClr,
        backgroundColor: Get.isDarkMode ? theme.primaryClr : theme.redClr,
        child: Text(initials, style: theme.TextThemes.headlineSmall(context)),
      ),
      title: Text(roomName),
      subtitle: Text(desc),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}