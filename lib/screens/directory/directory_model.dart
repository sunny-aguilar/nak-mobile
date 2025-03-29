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
    int totalBrothers = 0;
    for (final c in directoryCollection.docs) {
      // print('Chapter: ${c.data()}');
      Map<String, dynamic> broCount = {};
      broCount = c.data() as Map<String, dynamic>;
      print('**************************************');
      // print('Size: ${snapshot.data()}');
      print('Chapter info: ${broCount['chapter']}');
      print('Chapter line: ${broCount['chapterNumber']}');
      print('Chapter bros: ${broCount['brother']}');
      print('Bro Count: ${broCount['brother'].length}');
      totalBrothers += broCount['brother'].length as int;
    }
      print('Total bro Count: $totalBrothers');

    // This gets the number of bros at each chapter
    // final chapterRef = _instance!.collection('directory');
    // DocumentSnapshot snapshot = await chapterRef.doc('00.founding').get();
    // print('SS: ${snapshot.data()}');
    // Map<String, dynamic> chapter = {};
    // chapter = snapshot.data() as Map<String, dynamic>;
    // print('ss: ${chapter['brother'].length}');


    // return broCount;
  }
}