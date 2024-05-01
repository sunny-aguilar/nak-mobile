import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  FirebaseFirestore? _instance;

  void uploadChat() {
    _instance = FirebaseFirestore.instance;
    final data = {};
  }
}











