import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  FirebaseFirestore? _instance;

  Future<bool> canChat() async {
    bool canChat = false;
    _instance = FirebaseFirestore.instance;

    return canChat;
  }
}











