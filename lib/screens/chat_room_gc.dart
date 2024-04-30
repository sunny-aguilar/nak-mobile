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

  final List<Widget> chatList = [];

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

      body: StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) { return _circularProgress(); }

          if (!snapshot.hasData) { return _circularProgress(); }

          if (snapshot.hasData) {
            // print('.toList(): ${snapshot.data.docs.toList()}');
            final chats = snapshot.data.docs.toList();
            final monday = snapshot.data.docs.toList()[0]['gc'];
            // print('gc: $monday');
            for (final chat in chats) {
              final blurbs = chat['gc'];
              final quotes = blurbs['01'];
              for (final quote in quotes) {
                var item = Text(quote,);
                chatList.add(item);
              }
              print('List: ${chatList}');
            }
            return  Column(
              children: <Widget>[
                ListView(
                  padding: const EdgeInsets.symmetric(horizontal:  20.0),
                  shrinkWrap: true,
                  children: chatList,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Container(
                    //   height: 50,
                    //   width: 100,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(22.0),
                    //     color: theme.azureClr,
                    //   ),
                    // ),
                    SizedBox(
                      height: 60,
                      width: 300,
                      child: TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: theme.azureClr),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: theme.redClr),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.send, size: 50,),
                    ),
                  ],
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