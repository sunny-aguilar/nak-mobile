import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


class ChapterStatus {
  FirebaseFirestore? _instance;

  Future<Map> getFinancialStatus() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference ref = _instance!.collection('chapters');
    DocumentSnapshot snapshot = await ref.doc().get();
    return snapshot.data() as Map;
  }
}