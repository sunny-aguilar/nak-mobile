import 'package:cloud_firestore/cloud_firestore.dart';

class RevenueCat {
  FirebaseFirestore? _instance;

  Future<void> recordErrors(errorMsg) async {
    _instance = FirebaseFirestore.instance;
    final data = <String, String>{ 'msg': errorMsg };

    _instance!
      .collection('logs')
      .doc('error_logs')
      .set(data, SetOptions(merge:true))
      .onError((e, _) => print('Error writing document: $e')) ;
  }
}
