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
// String parameter to check the type of admin
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

  Future<bool> isAdmin(String adminType) async {
    bool isAdmin = false;
    Map<dynamic, dynamic> userData = await checkAuth();
    List adminList = userData['isAdmin'];
    isAdmin = adminList.contains(adminType);
    // isAdmin = userData['isAdmin'].contains('admin');
    return isAdmin;
  }

  Future<String> isAdminOrSuperAdmin(String adminType) async {
    Map<dynamic, dynamic> userData = await checkAuth();
    List adminList = userData['isAdmin'];
    if (adminList.contains(adminType)) {
      return 'superAdmin';
    }
    if (adminList.contains('admin')) {
      return 'admin';
    }
    return '';
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
    return snapshot.data() as Map<String, dynamic>;
  }

  Future<Map> getBlogUser() async {
    // get blog with blog docID
    final docs = await getBlog();

    // get user data from blog UID
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(docs['userUID']).get();
    return snapshot.data() as Map;
  }
}


class GetUsers {
  FirebaseFirestore? _instance;

  Future getAllUsers() async {
    _instance = FirebaseFirestore.instance;
    CollectionReference users = _instance!.collection('users');
    QuerySnapshot snapshot = await users.get();
    return snapshot;
  }
}


class DeactivateUserData {
  FirebaseFirestore? _instance;
  String userUID = FirebaseAuth.instance.currentUser!.uid;

  void deactivate() async {
    // get Firestore instance
    _instance = FirebaseFirestore.instance;

    // get users reference
    final reference = _instance!.collection('users');

    // add bool field "isactive"
    Map<String, bool> dataToSend = {'isactive': false};

    // save field on user's data
    await reference.doc(userUID).set(dataToSend, SetOptions(merge: true));
  }
}


class SignOutUser {
  FirebaseAuth? _instance;

  void signOut() {
    _instance = FirebaseAuth.instance;
    _instance?.signOut();
  }
}


class DeleteAuthUser {
  final user = FirebaseAuth.instance.currentUser;

  void delete() async {
    await user?.delete();
  }

  void deleteSignout() async {
    await user?.delete().then((val) => SignOutUser().signOut());
  }
}

/*
 *
 * Class that returns the selfie URL from users who posted blogs
 *
 */
class GetBlogUserSelfie {
  FirebaseFirestore? _instance;

  Future<Map<String, String>> getBlogUserUID() async {
    // get firestore instance
    _instance = FirebaseFirestore.instance;

    // to store user UIDs
    final List<String> userUidList = [];

    // to store user URLs
    final List<String> userSelfieUrlList = [];

    // to store Map of UID:URLs
    final Map<String, String> userURL = {};

    // get all blog docs & store UIDs in list
    await _instance!.collection('blog').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          userUidList.add(docSnapshot['userUID']);
        }
      }
    );

    // get user URLs from blog doc UIDs and store in list
    for (var uid in userUidList) {
      await _instance!.collection('users').doc(uid).get().then(
        (querySnapshot) {
          userSelfieUrlList.add(querySnapshot.data()?['selfie']);
          userURL[uid] = '${querySnapshot.data()?['selfie']}';
        }
      );
    }

    // returns a map of UID:url
    return userURL;
  }
}