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

  Future<int> getBroCount() async {
    _instance = FirebaseFirestore.instance;
    QuerySnapshot directoryCollection = await _instance!.collection('directory').get();
    // print('${directoryCollection.docs[0].data()}');
    int broCount = 0;
    for (final c in directoryCollection.docs) {
      // print('Chapter: ${c.data()}');
      Map<String, dynamic> totalBrothers = {};
      totalBrothers = c.data() as Map<String, dynamic>;
      // print('**************************************');
      // print('Size: ${snapshot.data()}');
      // print('Chapter info: ${totalBrothers['chapter']}');
      // print('Chapter line: ${totalBrothers['chapterNumber']}');
      // print('Chapter bros: ${totalBrothers['brother']}');
      // print('Bro Count: ${totalBrothers['brother'].length}');
      broCount += totalBrothers['brother'].length as int;
    }
      // print('Total bro Count: $broCount');

    // This gets the number of bros at each chapter
    // final chapterRef = _instance!.collection('directory');
    // DocumentSnapshot snapshot = await chapterRef.doc('00.founding').get();
    // print('SS: ${snapshot.data()}');
    // Map<String, dynamic> chapter = {};
    // chapter = snapshot.data() as Map<String, dynamic>;
    // print('ss: ${chapter['brother'].length}');

    return broCount;
  }

  Future<({int broCount, int chapterCount})> getDirectoryData() async {
    ({int broCount, int chapterCount}) record = (broCount: await getBroCount(),chapterCount: await getChapterCount());
    return record;
  }

  void getChapterBroCount() async {
    _instance = FirebaseFirestore.instance;
    final chapterRef = _instance!.collection('directory');
    QuerySnapshot directoryCollection = await _instance!.collection('directory').get();
    for (final chapter in directoryCollection.docs) {
      // print('Chart: ${chapter.data()}');
      // get chapter & bro data
      Map<String, dynamic> bros = chapter.data() as Map<String, dynamic>;
      print('Chart: Chapter: ${bros['chapter']} - total: ${bros['brother'].length}');
      String chapterName = bros['chapter'];
      int broCount = bros['brother'].length;
    }
  }

  void addChapter() async {}
  void addBrother() async {}
}