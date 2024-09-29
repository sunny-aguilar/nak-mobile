import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';


class ChapterStatus {
  FirebaseFirestore? _instance;

  Future getFinancialStatus() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference ref = _instance!.collection('chapters');
    QuerySnapshot snapshot = await ref.get();

    // _instance!.collection('chapters').get().then(
    //   (querySnapshot) {
    //     for (var docSnapshot in querySnapshot.docs) {
    //       print('SS: ${docSnapshot.id} => ${docSnapshot.data()}');
    //     }
    //   }
    // );

    return snapshot.docs;
  }

  Future<void> approveFinances(String id) async {
    _instance = FirebaseFirestore.instance;
    final chapterRef = _instance!.collection('chapters').doc(id);
    await chapterRef.update({'financialApproval': true});
  }

  Future<void> revokeFinances(String id) async {
    _instance = FirebaseFirestore.instance;
    final chapterRef = _instance!.collection('chapters').doc(id);
    await chapterRef.update({'financialApproval': false});
  }
}