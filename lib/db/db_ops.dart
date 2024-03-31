import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
// final userUID = auth.currentUser!.uid;

// userReference = db.collection('users');                <-- gets the collection
// query = userReference.doc(userUID).get();              <-- gets the documents in each collection (async method)

class UserService {
  FirebaseFirestore? _instance;

  Future<Map> getData() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    await Future.delayed(const Duration(milliseconds: 500));
    return snapshot.data() as Map;
  }
}


// check if a user is an Admin
class AuthCheck {
  FirebaseFirestore? _instance;

  Future<Map> checkAuth() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    // add query to DB to get user's document & check if they are an admi
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    return snapshot.data() as Map;
  }

  Future<bool> isAdmin() async {
    bool isAdmin = false;
    Map<dynamic, dynamic> userData = await checkAuth();
    isAdmin = userData['isAdmin'];
    return isAdmin;
  }
}


// return the blog data
class BlogDB {
  BlogDB({required this.docID});
  FirebaseFirestore? _instance;
  String docID;

  // get blog with specific doct ID
  Future<Map> getBlog() async {
    _instance = FirebaseFirestore.instance;

    final blog = _instance!.collection('blog');
    DocumentSnapshot snapshot = await blog.doc(docID).get();
    // print('Snapshot: ${snapshot.data()}');
    return snapshot.data() as Map<String, dynamic>;
    // blog.get().then(
    //   (DocumentSnapshot doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     print('Doc Data: ${data['userUID']}');
    //     return userID;
    //   },
    // );
  }

  Future<String> getBlogUserImgURL() async {
    String userSelfie = 'https://firebasestorage.googleapis.com/v0/b/nak-app-a899e.appspot.com/o/selfies%2Fprofile.webp?alt=media&token=9a3346e1-069e-4878-aa43-54394a368a5e';

    // get userUID from blog
    final docs = await getBlog();

    print('String: ${docs['userUID']}');
    // print('Blog UID: ${userUID}');

    _instance = FirebaseFirestore.instance;


    return '';
  }
}