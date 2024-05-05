import 'package:flutter/material.dart';
import 'package:nak_app/ui/theme.dart' as theme;

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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Chat Rules', style: theme.TextThemes.headlineLarge(context),),
            ListView(
              shrinkWrap: true,
              children: const <Widget>[
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Be friendly. Be polite. Be considerate.'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Do not type in all caps.'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Do not verbally abuse, attack, embarrass, or threaten anyone else in the chat room, no matter what they might say to you'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}