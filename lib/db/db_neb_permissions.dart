import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class UpdateUserPermissions {
  UpdateUserPermissions({required this.uid});
  final String uid;
  FirebaseFirestore? _instance;

  /* NEB Status * * * * * * * * * * * * * * * * * */
  Future<bool> nebStatus() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    final user = await userRef.get();
    return user.data()?['isNEB'];
  }

  Future<void> isNEB() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    await userRef.update({'isNEB': true});
  }

  Future<void> notNEB() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    await userRef.update({'isNEB': false});
  }

  /* Admin Status * * * * * * * * * * * * * * * * */
  Future<bool> adminStatus() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    final user = await userRef.get();
    bool adminStatus = user.data()!['isAdmin'].contains('admin');
    return adminStatus;
  }

  Future<void> isAdmin() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayUnion(['admin'])
    });
  }

  Future<void> notAdmin() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayRemove(['admin'])
    });
  }

  /* Super Admin Status * * * * * * * * * * * * * */
  Future<bool> superAdminStatus() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    final user = await userRef.get();
    bool superAdminStatus = await user.data()!['isAdmin'].contains('superAdmin');
    return superAdminStatus;
  }

  Future<void> isSuperAdmin() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayUnion(['superAdmin'])
    });
  }

  Future<void> notSuperAdmin() async {
    _instance = FirebaseFirestore.instance;
    final userRef = _instance!.collection('users').doc(uid);
    userRef.update({
      'isAdmin': FieldValue.arrayRemove(['superAdmin'])
    });
  }

}