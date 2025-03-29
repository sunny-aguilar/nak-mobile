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

  // Gets all chapter (docs) in collection (directory)
  Future<List> getChapters() async {
    _instance = FirebaseFirestore.instance;
    final chaptersRef = _instance!.collection('directory');
    final query = await chaptersRef.get();
    return query.docs;
  }

  // Gets a chapter (document) within the directory (collection)
  Future<Map> getChapter(String chapter) async {
    _instance = FirebaseFirestore.instance;
    final chapterRef = _instance!.collection('directory');
    DocumentSnapshot snapshot = await chapterRef.doc(chapter).get();
    return snapshot.data() as Map;
  }

  // Gets the chapter count
  Future<int> getChapterCount() async {
    _instance = FirebaseFirestore.instance;
    QuerySnapshot directoryCollection = await _instance!.collection('directory').get();
    int chapterCount = directoryCollection.size;
    return chapterCount;
  }

  void getBroCount() async {
    _instance = FirebaseFirestore.instance;
    QuerySnapshot directoryCollection = await _instance!.collection('directory').get();
    // print('${directoryCollection.docs[0].data()}');
    for (final c in directoryCollection.docs) {
      print('${c.data()}');
      print('Size: ${c.data()}');
    }
    // return broCount;
  }
}