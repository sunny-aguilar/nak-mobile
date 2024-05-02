import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/widget_export.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

class GeneralChatRoom extends StatefulWidget {
  const GeneralChatRoom({super.key});
  @override
  State<GeneralChatRoom> createState() => _GeneralChatRoomState();
}

class _GeneralChatRoomState extends State<GeneralChatRoom> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('chat').snapshots();

  // form key
  final _chatKey = GlobalKey<FormState>();

  // text controllers
  final TextEditingController _chatCtrl = TextEditingController();

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

      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) { return _circularProgress(); }

                if (!snapshot.hasData) { return _circularProgress(); }

                if (snapshot.hasData) {
                  int chatLength = snapshot.data.docs.toList()[0]['gc']['01'].length;
                  List chatters = snapshot.data.docs.toList()[0]['gc']['01'];

                  return  Column(
                    children: <Widget>[
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal:  20.0),
                        shrinkWrap: true,
                        itemCount: chatLength,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(chatters[index]),
                          );
                        }
                      ),
                      const SizedBox(height: 20,),
                    ],
                  );
                }
                return _circularProgress();
              }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 60,
                width: 300,
                child: Form(
                  key: _chatKey,
                  child: TextFormField(
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: 'Type something...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: theme.redClr),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: theme.redClr),
                      ),
                    ),
                    controller: _chatCtrl,
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  // get reference
                  final ref = FirebaseFirestore.instance.collection('chat').doc('general_chat');

                  // create chat data to send
                  ref.update(
                    {'gc.01': FieldValue.arrayUnion([_chatCtrl.text.trim()])}
                  );

                  // clear text controoler
                  _chatCtrl.clear();
                },
                icon: const Icon(Icons.send, size: 50,),
              ),

            ],
          ),
        ],
      ),
    );
  }
}