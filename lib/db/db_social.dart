import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class SocialUsers {
  FirebaseFirestore? _instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    return _instance!.collection('users').doc(userUID).snapshots();
  }
}