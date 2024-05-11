import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat {
  FirebaseFirestore? _instance;

  Future<Map> getUser() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    return snapshot.data() as Map;
  }

  Future<bool> canChat() async {
    Map<dynamic, dynamic> userData = await getUser();
    return userData['rights']['chat'];
  }

  String getUserName() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser?.displayName ?? '';
    }
    return '';
  }
}

class ChatSettings {
  FirebaseFirestore? _instance;

  Future<Map<dynamic, dynamic>> totalChats(String chatDoc) async {
    _instance = FirebaseFirestore.instance;
    CollectionReference chatRefs = _instance!.collection('chat');
    DocumentSnapshot snapshot = await chatRefs.doc(chatDoc).get();
    return snapshot.data() as Map;
  }

  Future<void> resetChat() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference chatRefs = _instance!.collection('chat');
    
  }
}










