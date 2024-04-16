import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Storage {
  FirebaseStorage? storageRef;

  Future<void> deleteAsset(String url) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference imageRef = storageRef.child('blog/$url');
    try {
      await imageRef.delete();
    }
    on FirebaseException catch (e) {
      // Caught an exception from Firebase
      print('Failed with error: ${e.code}: ${e.message}');
    }
  }
}
