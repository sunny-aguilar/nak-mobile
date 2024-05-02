import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nak_app/ui/widget_export.dart' as theme;
import 'package:nak_app/services/theme_service.dart' as service;

class GcChatRoom extends StatefulWidget {
  const GcChatRoom({super.key});
  @override
  State<GcChatRoom> createState() => _GcChatRoomState();
}

class _GcChatRoomState extends State<GcChatRoom> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection('chat').snapshots();

  // form key
  final _chatKey = GlobalKey<FormState>();

  // text controllers
  final TextEditingController _chatCtrl = TextEditingController();

  // scroll controller
  final ScrollController _scrollController = ScrollController();


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
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: <Widget>[
                const Text('Header'),
                Expanded(
                  child: Container(
                    color: Colors.red,
                  ),
                ),
                SafeArea(
                  bottom: true,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10,),
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
                                      errorBorder: OutlineInputBorder(
                                        // borderRadius: BorderRadius.all(Radius.circular(26.0)),
                                        borderSide: BorderSide(
                                          color: theme.redClr,
                                          width: 2.0,
                                        )
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        // borderRadius: BorderRadius.all(Radius.circular(26.0)),
                                        borderSide: BorderSide(
                                          color: theme.redClr,
                                          width: 2.0,
                                        )
                                      ),
                                    ),
                                    controller: _chatCtrl,
                                    keyboardType: TextInputType.name,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: GlowingActionButton(icon: Icons.send, onPressed: buttonStuff),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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