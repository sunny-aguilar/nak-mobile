import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_chat.dart' as db;
import 'package:nak_app/screens/chats/chat_room_gc.dart';
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
      body: ListView(
        children: <Widget>[
          // Container(
          //   height: 5,
          //   decoration: const BoxDecoration(
          //     color: theme.azureClr,
          //   ),
          // ),
          FutureBuilder(
            future: db.Chat().canChat(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) { _circularProgress(); }
              else if (snapshot.data == null) { _circularProgress(); }
              else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                bool canChat = snapshot.data!;
                chatEnabled = canChat;
                if (canChat) {
                  return Container(
                    height: 5,
                    decoration: const BoxDecoration(color: theme.azureClr,),
                  );
                }
                if (!canChat) {
                  return Container(
                    height: 5,
                    decoration: const BoxDecoration(color: theme.orangeClr,),
                  );
                }

              }
              return _circularProgress();
            }
          ),
          ListTile(
            onTap: () {

              if (chatEnabled) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 1500),
                    content: Text('Authenticating user...')
                  ),
                );
                Navigator.pushNamed(
                  context,
                  '/gchat'
                );
              }
              else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Chat Disabled', textAlign: TextAlign.center,),
                      content: const Text('You\'ve been banned!', textAlign: TextAlign.center,),
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


              // Navigator.pushNamed(context, '/chatRules');

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
        ],
      ),
    );
  }
}