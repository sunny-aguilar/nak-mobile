import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chat {
  FirebaseFirestore? _instance;

  Future<Map> getUsers() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    return snapshot.data() as Map;
  }

  Future<bool> canChat() async {
    Map<dynamic, dynamic> userData = await getUsers();
    return userData['rights']['chat'];
  }
}











