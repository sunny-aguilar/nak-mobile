import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nak_app/components/utils.dart' as utils;

class Chat {
  FirebaseFirestore? _instance;

  Future<Map> getUser() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    return snapshot.data() as Map;
  }

  Future<bool> canChat() async {
    Map<dynamic, dynamic> userData = await getUser();
    return userData['rights']['chat'];
  }

  String getUserName() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser?.displayName ?? '';
    }
    return '';
  }
}

class ChatSettings {
  FirebaseFirestore? _instance;

  Future<Map<dynamic, dynamic>> totalChats(String chatDoc) async {
    _instance = FirebaseFirestore.instance;
    CollectionReference chatRefs = _instance!.collection('chat');
    DocumentSnapshot snapshot = await chatRefs.doc(chatDoc).get();
    return snapshot.data() as Map;
  }

  Future<void> resetChat() async {
    // TODO: implement archive method
    _instance = FirebaseFirestore.instance;
    final docRef = _instance!.collection('chat').doc('general_chat');
    docRef.get().then(
      (DocumentSnapshot doc) {
        // get active chat list
        final data = doc.data() as Map<String, dynamic>;

        // create archive name using datestamp
        final String date = utils.Dates().getDateTime();

        // data to be saved
        final chatData = {date: data['active']};

        // copy active chat list to archive
        docRef.collection('gc_archive').doc('archive_list').set(chatData, SetOptions(merge: true));

        final updates = <String, dynamic>{ 'active': FieldValue.delete(), };
        docRef.update(updates);

        // add blank entry
        addBlankEntry();
      },
      onError: (e) => print('Error getting document: $e'),
    );
    // delete data
    // final updates = <String, dynamic>{ 'active': FieldValue.delete(), };
    // docRef.update(updates);

    // add blank entry
    // addBlankEntry();
  }

  void addBlankEntry() {
    final docRef = FirebaseFirestore.instance.collection('chat').doc('general_chat');

    // create chat data to be saved
    Map<String, dynamic> chat = {};
    chat['msg'] = '';
    chat['uid'] = '';
    chat['username'] = '';
    chat['timestamp'] = '';

    docRef.update({ 'active': FieldValue.arrayUnion([ chat ]) });
  }
}










