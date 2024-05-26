import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_chat.dart' as db;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/screens/chats/rooms/chat_room.dart' as chat;
import 'package:nak_app/components/revenuecat/constants.dart' as chat;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.context});
  final BuildContext context;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool chatEnabled = false;

  // chat room form keys
  Map<String, dynamic> formKeyMap = {};

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
      body: FutureBuilder<bool>(
        future: db.Chat().canChat(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) { _circularProgress(); }
          else if (snapshot.data == null) { _circularProgress(); }
          else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
            // check if user has chat rights to paint alert
            chatEnabled = snapshot.data!;
            Color chatStatusColor = chatEnabled ? theme.azureClr : theme.orangeClr;
            return ListView(
              children: <Widget>[
                Container(
                  height: 5,
                  decoration: BoxDecoration(color: chatStatusColor,),
                ),

                ChatRoom(
                  chatEnabled: chatEnabled,
                  initials: 'GC',
                  roomNumber: chat.Room.general.index,
                  room: '/gchat',
                  roomTitle: 'General Chat',
                  dbChatRoomName: 'general_chat',
                  desc: 'Talk about anything and everything',
                  formKey: formKeyMap,
                  formKeyName: 'generalChatKey',
                ),

                ChatRoom(
                  chatEnabled: chatEnabled,
                  initials: 'EC',
                  roomNumber: chat.Room.events.index,
                  room: '/echat',
                  roomTitle: 'Fraternity Events',
                  dbChatRoomName: 'events_chat',
                  desc: 'Local and National Events Chat',
                  formKey: formKeyMap,
                  formKeyName: 'eventChatKey',
                ),

                ChatRoom(
                  chatEnabled: chatEnabled,
                  initials: 'AC',
                  roomNumber: chat.Room.alumni.index,
                  room: '/echat', // wont be needed in updated widget
                  roomTitle: 'Alumni Chat',
                  dbChatRoomName: 'alumni_chat',
                  desc: 'Connect with alumni, career advice, and jobs',
                  formKey: formKeyMap,
                  formKeyName: 'alumniChatKey',
                ),

              ],
            );
          }
          return _circularProgress();
        }
      ),
    );
  }
}


class ChatRoom extends StatelessWidget {
  const ChatRoom({
    super.key,
    required this.chatEnabled,
    required this.room,
    required this.initials,
    required this.roomNumber,
    required this.roomTitle,
    required this.dbChatRoomName,
    required this.desc,
    required this.formKey,
    required this.formKeyName,
  });

  final bool chatEnabled;
  final String room;
  final String initials;
  final int roomNumber;
  final String roomTitle;
  final String dbChatRoomName;
  final String desc;
  final Map<String, dynamic> formKey;
  final String formKeyName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (chatEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text('Verifying chat privileges...')
            ),
          );
          // TODO: this navigator has to be updated to push a new general chat room using a material navigator
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => chat.ChatRoom(
                roomTitle: roomTitle,
                dbChatRoomName: dbChatRoomName,
                roomNumber: roomNumber,
                formKey: formKey,
                formKeyName: formKeyName,
              ),
            ),
          );

          // Navigator.pushNamed(
          //   context,
          //   room
          // );
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
      title: Text(roomTitle),
      subtitle: Text(desc),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}