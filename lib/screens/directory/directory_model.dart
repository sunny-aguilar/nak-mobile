import 'package:cloud_firestore/cloud_firestore.dart';

class Directory {
  FirebaseFirestore? _instance;

  void getChapters() async {
    _instance = FirebaseFirestore.instance;
    await _instance!.collection('directory').get().then((event){
      for (var doc in event.docs) {
        print('Doc ID: ${doc.id} => ${doc.data()}');
      }
    });

    // final chapters = _instance!.collection('directory');
    // final query = await chapters.get();
    // return query.docs;
  }
}