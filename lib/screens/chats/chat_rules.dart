import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nak_app/services/theme_service.dart' as service;

class ChatRules extends StatefulWidget {
  const ChatRules({super.key});

  @override
  State<ChatRules> createState() => _ChatRulesState();
}

class _ChatRulesState extends State<ChatRules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          // const Icon(Icons.message_outlined),
          // const SizedBox(width: 10,),
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: const ChatRulesBody(),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Chat Rules'),
          ],
        ),
      ),
    );
  }
}