import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/widget_export.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/db/db_chat.dart' as db_chat;
import 'package:nak_app/components/utils.dart' as utils;

class ChatRoom extends StatefulWidget {
  const ChatRoom({
    super.key,
    required this.roomTitle,
    required this.dbChatRoomName,
    required this.roomNumber,
    required this.formKey,
    required this.formKeyName,
  });

  final String roomTitle;
  final String dbChatRoomName;
  final int roomNumber;
  final Map<String,dynamic> formKey;
  final String formKeyName;

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('chat').snapshots();

  // text controllers
  final TextEditingController _chatCtrl = TextEditingController();

  // scroll controller
  final ScrollController _scrollController = ScrollController();

  // void scrollDown() {
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: const Duration(milliseconds: 500),
  //     curve: Curves.easeOut,
  //   );
  // }

  @override
  void initState() {
    super.initState();
    widget.formKey[widget.formKeyName] = GlobalKey<FormState>();
  }

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

  void buttonStuff() {
    if (widget.formKey[widget.formKeyName].currentState!.validate()) {
      // get reference
      final ref = FirebaseFirestore.instance.collection('chat').doc(widget.dbChatRoomName);
      final uid = FirebaseAuth.instance.currentUser!.uid;

      // create chat data to be saved
      Map<String, dynamic> chat = {};
      chat['msg'] = _chatCtrl.text.trim();
      chat['uid'] = uid;
      chat['username'] = db_chat.Chat().getUserName();
      chat['timestamp'] = utils.Dates().getDateTime();

      // ref.update({ 'gc.active': FieldValue.arrayUnion([ chat ]) });
      ref.update({ 'active': FieldValue.arrayUnion([ chat ]) });
    }

    // clear text controoler
    _chatCtrl.clear();

    // scroll down
    // scrollDown();
  }

  bool checkIfCurrentUser(String chatUID) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return chatUID == uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.roomTitle, style: theme.TextThemes.headlineMed(context),),
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
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {

                  if (snapshot.data == null) { return _circularProgress(); }

                  if (!snapshot.hasData) { return _circularProgress(); }

                  if (snapshot.hasData) {
                    try {
                      int chatLength = snapshot.data.docs.toList()[widget.roomNumber]['active'].length;
                      List chatList = snapshot.data.docs.toList()[widget.roomNumber]['active'];

                      return  Column(
                        children: <Widget>[
                          ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal:  10.0),
                            shrinkWrap: true,
                            controller: _scrollController,
                            reverse: true,
                            itemCount: chatLength,
                            itemBuilder: (BuildContext context, int index) {
                              bool isCurrentUser = checkIfCurrentUser(chatList[index]['uid']);
                              bool isSystem = chatList[index]['timestamp'] == 'system';
                              return ListTile(
                                title: ChatBubble(
                                  msg: chatList[index]['msg'],
                                  isCurrentUser: isCurrentUser,
                                  isSystem: isSystem,
                                  timestamp: chatList[index]['timestamp'],
                                  username: chatList[index]['username'],
                                ),
                              );
                            }
                          ),
                        ],
                      );

                    }
                    catch (e) {
                      return Column(
                        children: <Widget>[
                          ListView(
                            shrinkWrap: true,
                            children: const <Widget>[
                              ListTile(
                                title: Text('No chat messages yet...'),
                              ),
                            ],
                          ),
                        ]
                      );
                    }

                    // TODO: only delete this once the above try catch block is verified
                    // TODO: to fully work
                    // int chatLength = snapshot.data.docs.toList()[0]['active'].length;
                    // List chatList = snapshot.data.docs.toList()[0]['active'];

                    // return  Column(
                    //   children: <Widget>[
                    //     ListView.builder(
                    //       padding: const EdgeInsets.symmetric(horizontal:  20.0),
                    //       shrinkWrap: true,
                    //       controller: _scrollController,
                    //       reverse: false,
                    //       itemCount: chatLength,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         bool isCurrentUser = checkIfCurrentUser(chatList[index]['uid']);
                    //         return ListTile(
                    //           title: ChatBubble(
                    //             msg: chatList[index]['msg'],
                    //             isCurrentUser: isCurrentUser,
                    //             timestamp: chatList[index]['timestamp'],
                    //             username: chatList[index]['username'],
                    //           ),
                    //         );
                    //       }
                    //     ),
                    //   ],
                    // );
                  }
                  return _circularProgress();
                }
              ),
            ),
          ),
          SafeArea(
            bottom: true,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,),
                        child: SizedBox(
                          height: 74,
                          child: Form(
                            key: widget.formKey[widget.formKeyName],
                            child: TextFormField(
                              maxLines: 1,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.abc),
                                hintText: 'Type something...',
                                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(26.0)),
                                  borderSide: BorderSide(
                                    color: theme.redClr,
                                    width: 2.0,
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(26.0)),
                                  borderSide: BorderSide(
                                    color: theme.redClr,
                                    width: 2.0,
                                  )
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(26.0)),
                                  borderSide: BorderSide(
                                    color: theme.redClr,
                                    width: 2.0,
                                  )
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(26.0)),
                                  borderSide: BorderSide(
                                    color: theme.redClr,
                                    width: 2.0,
                                  )
                                ),
                              ),
                              controller: _chatCtrl,
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'You must enter some text...';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: GlowingActionButton(icon: Icons.send, onPressed: buttonStuff),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: theme.azureClr,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: theme.redClr,
          child: InkWell(
            splashColor: theme.lightRedClr,
            onTap: () { onPressed(); },
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.send,
                size: 26,
                color: theme.primaryClr
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key,
    required this.msg,
    required this.isCurrentUser,
    required this.isSystem,
    required this.username,
    required this.timestamp}
  );

  final String msg;
  final bool isCurrentUser;
  final bool isSystem;
  final String username;
  final String timestamp;

  BorderRadius chatShape() {
    if (isSystem) {
      return const BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    }
    else if (isCurrentUser) {
      return const BorderRadius.only(
        topLeft: Radius.circular(18),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    }
    else if (!isCurrentUser) {
      return const BorderRadius.only(
        topLeft: Radius.circular(18),
        topRight: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    }
    return const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
      bottomLeft: Radius.circular(18),
      bottomRight: Radius.circular(18),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSystem ? Alignment.center : isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isSystem ? CrossAxisAlignment.center : isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(username),
          Container(
            decoration: BoxDecoration(
              borderRadius: chatShape(),
              color:
                Get.isDarkMode
                ? isCurrentUser
                ? theme.redClr : theme.charcoalClr
                : isCurrentUser
                ? theme.redClr : theme.chatGregyClr,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: Text(
                msg,
                style: TextStyle(
                  color:
                    Get.isDarkMode ? theme.primaryClr
                    : isCurrentUser
                    ? theme.primaryClr : theme.darkGreyClr,
                ),
              ),
            ),
          ),
          Text(timestamp, style: theme.TextThemes.chatDate(context),),
        ],
      ),
    );
  }
}