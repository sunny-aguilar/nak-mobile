import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/db/db_chat.dart' as db;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.context});
  final BuildContext context;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  Center _circularProgress() {
    return const Center(
      child: SizedBox(
        height: 75, width: 75,
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
          Container(
            height: 5,
            decoration: const BoxDecoration(
              color: theme.azureClr
            ),
          ),
          ListTile(
            onTap: () {
              // check if user has chat permissions
              // canChat == true, blue bar or orange bar

              FutureBuilder(
                future: db.Chat().canChat(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) { _circularProgress(); }
                  else if (snapshot.data == null) { _circularProgress(); }
                  else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 1500),
                        content: Text('Verifying user chat rights...'),
                      ),
                    );

                    Navigator.pushNamed(
                      context,
                      '/gchat'
                    );
                  }
                  return _circularProgress();
                }
              );


              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return FutureBuilder(
                      future: db.Chat().canChat(),
                      builder: (BuildContext context, snapshot) {
                        if (!snapshot.hasData) { _circularProgress(); }
                        else if (snapshot.data == null) { _circularProgress(); }
                        else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasError) {

                          bool canChat = true;
                          print('Bool val: ${snapshot.data.docs}');
                          if (canChat) {
                            print('User can chat');
                          }

                        }
                        return _circularProgress();
                      }
                    );
                  }
                ),
              );

              // navigate to chat screen
              // Navigator.pushNamed(
              //   context,
              //   '/gchat'
              // );
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