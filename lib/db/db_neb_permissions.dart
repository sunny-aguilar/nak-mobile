import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class NebRights {
  NebRights({required this.uid});
  final String uid;
  FirebaseFirestore? _instance;

  /* NEB Status * * * * * * * * * * * * * * * * * */
  Future<bool> nebStatus() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    final user = await userRef.get();
    return user.data()?['isNEB'];
  }

  Future<void> addRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    await userRef.update({'isNEB': true});
  }

  Future<void> removeRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    await userRef.update({'isNEB': false});
  }
}


class AdminRights {
  AdminRights({required this.uid});
  final String uid;
  FirebaseFirestore? _instance;

  /* Admin Status * * * * * * * * * * * * * * * * */
  Future<bool> adminStatus() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    final user = await userRef.get();
    bool adminStatus = user.data()!['isAdmin'].contains('admin');
    return adminStatus;
  }

  Future<void> addRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayUnion(['admin'])
    });
  }

  Future<void> removeRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayRemove(['admin'])
    });
  }
}


class SuperAdminRights {
  SuperAdminRights({required this.uid});
  final String uid;
  FirebaseFirestore? _instance;

  /* Super Admin Status * * * * * * * * * * * * * */
  Future<bool> superAdminStatus() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    final user = await userRef.get();
    bool superAdminStatus = await user.data()!['isAdmin'].contains('superAdmin');
    return superAdminStatus;
  }

  Future<void> addRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayUnion(['superAdmin'])
    });
  }

  Future<void> removeRights() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayRemove(['superAdmin'])
    });
  }
}