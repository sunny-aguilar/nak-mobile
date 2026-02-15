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

  double _fabOpacity = 1.0;

  void scrollDown() {
    if (_scrollController.hasClients) {
      final max = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        max,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          final max = _scrollController.position.maxScrollExtent;
          _scrollController.animateTo(
            max,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    widget.formKey[widget.formKeyName] = GlobalKey<FormState>();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    final isAtBottom = position.pixels >= position.maxScrollExtent - 200; // 50px threshold

    final targetOpacity = isAtBottom ? 0.0 : 1.0;
    if (_fabOpacity != targetOpacity) {
      setState(() {
        _fabOpacity = targetOpacity;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _chatCtrl.dispose();
    super.dispose();
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
    // scroll down after frame to ensure list updated
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollDown());
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
            child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) { return _circularProgress(); }
                if (!snapshot.hasData) { return _circularProgress(); }

                if (snapshot.hasData) {
                  try {
                    int chatLength = snapshot.data.docs.toList()[widget.roomNumber]['active'].length;
                    List chatList = snapshot.data.docs.toList()[widget.roomNumber]['active'];

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      controller: _scrollController,
                      reverse: false,
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
                    );

                  } catch (e) {
                    return ListView(
                      children: const <Widget>[
                        ListTile(
                          title: Text('No chat messages yet...'),
                        ),
                      ],
                    );
                  }
                }
                return _circularProgress();
              }
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
                          height: 44,
                          child: Form(
                            key: widget.formKey[widget.formKeyName],
                            child: TextFormField(
                              maxLines: 1,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.abc),
                                hintText: 'Message',
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
                      padding: const EdgeInsets.only(left: 8.0, right: 18.0),
                      child: GlowingActionButton(icon: Icons.send, onPressed: buttonStuff),
                    ),
                  ],
                ),
                const SizedBox(height: 0,),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _fabOpacity,
        duration: const Duration(milliseconds: 300),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50.0, right: 0.0),
          child: FloatingActionButton.small(
            onPressed: _fabOpacity > 0.5 ? scrollDown : null,
            backgroundColor: theme.charcoalClr,
            shape: const CircleBorder(),
            child: const Icon(Icons.keyboard_arrow_down_rounded, color: theme.primaryClr, size: 40,),
          ),
        ),
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
              width: 40,
              height: 40,
              child: Icon(
                Icons.send,
                size: 24,
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