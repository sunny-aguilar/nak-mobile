import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
// final userUID = auth.currentUser!.uid;

// userReference = db.collection('users');
// query = userReference.doc(userUID).get();

class UserService {
  FirebaseFirestore? _instance;

  Future<Map> getUsersFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    await Future.delayed(const Duration(milliseconds: 500));
    return snapshot.data() as Map;
  }
}

