import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/db/db_chat.dart' as db;
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/components/buttons.dart' as buttons;

class ChatRules extends StatefulWidget {
  const ChatRules({super.key});

  @override
  State<ChatRules> createState() => _ChatRulesState();
}

class _ChatRulesState extends State<ChatRules> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChatRulesBody(),
    );
  }
}

class ChatRulesBody extends StatefulWidget {
  const ChatRulesBody({super.key});
  @override
  State<ChatRulesBody> createState() => _ChatRulesBodyState();
}

class _ChatRulesBodyState extends State<ChatRulesBody> {
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
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
          Text('Chat Rules', style: theme.TextThemes.headlineLarge(context),),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.check_circle),
                title: Text('Be friendly. Be polite. Be considerate.',),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle),
                title: Text('Do not type in all caps.'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle),
                title: Text('Do not verbally abuse, harrass, attack, embarrass, or threaten anyone else in the chat room, no matter what they might say to you'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle),
                title: Text('Do not use obscene, offensive, or sexually explicit language.'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: theme.azureClr),
                title: Text('A blue bar means your chat priviledges are in good standing.',),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: theme.orangeClr),
                title: Text('An orange bar means your chat privileges have been suspended. Contact neb@nakinc.org if you believe this is incorrect.',),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Failure to follow any of these rules will result in you getting banned from chat.', textAlign: TextAlign.center, style: theme.TextThemes.charWarning(context),),
              ),
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () {

                    if (chatEnabled) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1500),
                          content: Text('Authenticating user...')
                        ),
                      );
                      Navigator.pushNamed(
                        context,
                        '/chat'
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
                                  Navigator.pop(context);
                                },
                                style: buttons.buttonStyleRed(context),
                                child: const Text('Dismiss'),
                              ),
                            ],
                          );
                        }
                      );
                    }

                  },
                  style: buttons.chatButton(context),
                  child: const Text('Start Chatting'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}