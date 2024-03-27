import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
// final userUID = auth.currentUser!.uid;

// userReference = db.collection('users');                <-- gets the collection
// query = userReference.doc(userUID).get();              <-- gets the documents in each collection (async method)

class UserService {
  FirebaseFirestore? _instance;

  Future<Map> getData() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    await Future.delayed(const Duration(milliseconds: 500));
    return snapshot.data() as Map;
  }
}


class AuthCheck {
  FirebaseFirestore? _instance;

  Future<Map> checkAuth() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    // add query to DB to get user's document & check if they are an admi
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    return snapshot.data() as Map;
  }

  Future<bool> isAdmin() async {
    bool isAdmin = false;
    Map<dynamic, dynamic> userData = await checkAuth();
    isAdmin = userData['isAdmin'];
    return isAdmin;
  }
}
