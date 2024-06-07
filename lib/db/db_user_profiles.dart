import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class UpdateUsers {
  FirebaseFirestore? _instance;

  Future<void> updateDisplayName(String firstName, String lastName) async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user?.updateDisplayName('$firstName $lastName');
        updateDbUsername(firstName, lastName);
      } catch (e) {
        print('Error updating user profile name');
      }
    }
  }

  Future<void> updateDbUsername(String firstName, String lastName) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userUID = auth.currentUser!.uid;

    _instance = FirebaseFirestore.instance;
    _instance!.collection('users').doc(userUID).set({
      'firstName': firstName,
      'lastName': lastName,
    });

  }
}