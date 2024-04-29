import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/theme.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

class GeneralChatRoom extends StatefulWidget {
  const GeneralChatRoom({super.key});
  @override
  State<GeneralChatRoom> createState() => _GeneralChatRoomState();
}

class _GeneralChatRoomState extends State<GeneralChatRoom> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('chat').snapshots();

  Center _circularProgress() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:  60.0),
        child: SizedBox(
          height: 50, width: 50,
          child: CircularProgressIndicator(
            strokeWidth: 7,
            color: theme.redClr,
            backgroundColor: theme.bronzeOfficial,
          ),
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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  20.0),
        child: Column(
          children: <Widget>[
            const Text('chat text 1'),
            const SizedBox(height: 20,),
            const Text('chat text 2'),
            StreamBuilder(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) { return _circularProgress(); }

                if (!snapshot.hasData) { return _circularProgress(); }

                if (snapshot.hasData) {
                  print('Data: ${snapshot.data.docs.toList()}');
                  print('Data: ${snapshot.data.docs.toList()[0]['initial']}');
                  final chats = snapshot.data.docs.toList();
                  for (final chat in chats) {
                    print('chat: $chat');
                  }
                  // print('Data: ${snapshot.data.docs.toList()[1]['second']}');
                  return const Text('Data in streambuilder');
                }
                return _circularProgress();
              }
            ),

          ],
        ),
      ),
    );
  }
}