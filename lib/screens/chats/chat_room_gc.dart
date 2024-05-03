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

  // scroll controller
  final ScrollController _scrollController = ScrollController();

  // void _scrollToBottom() {
  //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  // }

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
    if (_chatKey.currentState!.validate()) {
      // get reference
      final ref = FirebaseFirestore.instance.collection('chat').doc('general_chat');
      // create chat data to send
      ref.update(
        {'gc.01': FieldValue.arrayUnion([_chatCtrl.text.trim()])}
      );
    }
    // clear text controoler
    _chatCtrl.clear();
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
            child: SingleChildScrollView(
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
                          controller: _scrollController,
                          itemCount: chatLength,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: ChatBubbleRight(msg: chatters[index]),
                            );
                          }
                        ),
                      ],
                    );
                  }
                  return _circularProgress();
                }
              ),
            ),
          ),
          SafeArea(
            bottom: true,
            child: Column(
              children: [
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
                            key: _chatKey,
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

class ChatBubbleLeft extends StatelessWidget {
  const ChatBubbleLeft({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18)
          ),
          color: Get.isDarkMode ? theme.charcoalClr : theme.chatGregyClr,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Text(msg),
        ),
      ),
    );
  }
}

class ChatBubbleRight extends StatelessWidget {
  const ChatBubbleRight({super.key, required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18)
          ),
          color: theme.redClr
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          child: Text(msg, style: const TextStyle(color: theme.primaryClr),),
        ),
      ),
    );
  }
}