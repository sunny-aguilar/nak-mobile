import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


class UserRights {
  UserRights({required this.uid});
  final String uid;
  FirebaseFirestore? _instance;

  Future<bool> blogRightsStatus() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    final user = await userRef.get();
    return user.data()?['rights']['blog'];
  }

  Future<void> addBlogRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    await userRef.update({'rights.blog': true});
  }

  Future<void> removeBlogRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    await userRef.update({'rights.blog': false});
  }
}
