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


  Future<List<double>> getGraphCount() async {
    _instance = FirebaseFirestore.instance;
    QuerySnapshot directoryCollection = await _instance!.collection('directory').get();

    // hold list of chapters
    Map<String, dynamic> data = {};

    for (final chapter in directoryCollection.docs) {
      Map<String, dynamic> bros = chapter.data() as Map<String, dynamic>;
      String chapterName = bros['chapter'];
      int broCount = bros['brother'].length;
      String chapterNumber = bros['chapterNumber'].toString();

      // add info into data
      data[chapterNumber] = (chapterName: chapterName, broCount: broCount);
    }

    List<double> graphCount = [];
    data.forEach((key, val) {
      var count = val.broCount.toDouble();
      graphCount.add(count);
    });

    return cleanData(data);
  }


  List<double> cleanData(Map data) {
    List<double> graphCount = [];


    data.forEach((key, val) {
      graphCount.add(val.broCount.toDouble());
    });
    // print('GraphCount: $graphCount');
    // print('Type: ${graphCount[0].runtimeType}');
    return graphCount;

  }


  Future<({int broCount, int chapterCount, List<double> graphData})> getDirectoryData() async {
    ({int broCount, int chapterCount, List<double> graphData}) record = (broCount: await getBroCount(), chapterCount: await getChapterCount(), graphData: await getGraphCount());
    return record;
  }


  Future<Map> broData() async {
    _instance = FirebaseFirestore.instance;
    QuerySnapshot directoryCollection = await _instance!.collection('directory').get();
    Map<String, dynamic> data = {};
    for (final chapter in directoryCollection.docs) {
      Map<String, dynamic> bros = chapter.data() as Map<String, dynamic>;
      String chapterNumber = bros['chapterNumber'].toString();
      data[chapterNumber] = bros;
      String chapterName = bros['chapter'];
      int broCount = bros['brother'].length;
      Map brothers = bros['brother'];
      String chapNum = bros['chapterNumber'].toString();
      String greek = bros['greekLtr'];
      String chapterID = bros['chapterID'];
      // print('DC data: $chapterID');

      // add info into data
      data[chapterNumber] = (
        chapterName: chapterName,
        broCount: broCount,
        chapNum: chapNum,
        bros: brothers,
        greek: greek,
        chapterID: chapterID
      );
    }
    return data;
  }


  Future<Map> chapterDataMap(String chapterID) async {
    _instance = FirebaseFirestore.instance;
    final directoryCollection = _instance!.collection('directory');
    DocumentSnapshot snapshot = await directoryCollection.doc(chapterID).get();
    // print('Snapshot: ${snapshot.data()}');
    Map<dynamic, dynamic> data = snapshot.data() as Map;
    return data;
  }


  // use to replace broData() eventually
  Future<Map> broDataMap() async {
    _instance = FirebaseFirestore.instance;
    QuerySnapshot directoryCollection = await _instance!.collection('directory').get();
    Map<String, dynamic> data = {};
    for (final chapter in directoryCollection.docs) {
      Map<String, dynamic> bros = chapter.data() as Map<String, dynamic>;
      print('brosMap: $bros');
    }
    return data;
  }


  void addBrother(Map data, String chapterID) async {
    final ref = FirebaseFirestore.instance.collection('directory').doc(chapterID);
    String lineNumber = data['lineNumber'];

    // create a map to send
    Map<String, dynamic> dataToSend = {
        'brother': {
          lineNumber: {
          'name': data['name'],
          'className': data['className'],
          'lineNumber': data['lineNumber'],
        }
      }
    };

    // add the data to Firestore
    await ref.set(dataToSend, SetOptions(merge: true));
  }


  void editBrother(Map broData, String chapterID) async {
    _instance = FirebaseFirestore.instance;
    String broNum = broData['lineNumber'];
    final data = {
      'brother.$broNum.name': broData['name'],
      'brother.$broNum.className': broData['className'],
      'brother.$broNum.lineNumber': broData['lineNumber'],
    };

    final ref = _instance!.collection('directory').doc(chapterID);
    await ref.update(data);
  }
}