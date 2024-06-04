import 'package:cloud_firestore/cloud_firestore.dart';

class RevenueCat {
  FirebaseFirestore? _instance;

  Future<void> recordErrors() {
    _instance = FirebaseFirestore.instance;
    final data = {};
  }
}
