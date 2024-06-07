import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class UpdateUsers {
  Future updateDisplayName (String username) async {
    if (FirebaseAuth.instance.currentUser != null) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        await user?.updateDisplayName(username);
      } catch (e) {
        print('Error updating user profile name');
      }
    }
  }
}