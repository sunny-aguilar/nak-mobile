import 'package:cloud_firestore/cloud_firestore.dart';

class Directory {
  FirebaseFirestore? _instance;

  void getChaptersTest() async {
    _instance = FirebaseFirestore.instance;
    await _instance!.collection('directory').get().then((event){
      for (var doc in event.docs) {
        print('Doc ID: ${doc.id} => ${doc.data()}');
      }
    });
  }

  Future<List> getChapters() async {
    _instance = FirebaseFirestore.instance;
    final chaptersRef = _instance!.collection('directory');
    final query = await chaptersRef.get();
    return query.docs;
  }

  // void getOneChapter
  Future<Map<String, dynamic>> getChapter() async {
    _instance = FirebaseFirestore.instance;
    final chapterRef = _instance!.collection('directory');
    DocumentSnapshot snapshot = await chapterRef.doc('01.alpha').get();
    return snapshot.data as Map<String, dynamic>;
  }
}