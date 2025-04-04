import 'package:cloud_firestore/cloud_firestore.dart';


class Blog {
  FirebaseFirestore? _instance;

  Future<List> getAllBlogs() async {
    _instance = FirebaseFirestore.instance;
    final blogs = _instance!.collection('blog');
    final query = await blogs.get();
    return query.docs;
  }


  Future<void> updateBlogEntry(String docID,String title, String body) async {
    _instance = FirebaseFirestore.instance;
    final data = {
      'title': title,
      'body': body,
    };
    final reference = _instance!.collection('blog').doc(docID);
    await reference.set(data, SetOptions(merge: true));
  }

  Future<void> deleteBlogEntry(String docID) async {
    _instance = FirebaseFirestore.instance;
    await _instance!.collection('blog').doc(docID).delete();
  }
}


// Class that returns the selfie URL from users who posted blogs
class GetBlogUserSelfie {
  FirebaseFirestore? _instance;

  Future<Map<String, String>> getBlogUserUID() async {
    // get firestore instance
    _instance = FirebaseFirestore.instance;

    // to store Map of UID:URLs
    final Map<String, String> userURL = {};

    // get all blog docs to get userUIDs & use it to get selfie
    // url from users. Returns a map of uid:selfie.
    await _instance!.collection('blog').get().then(
      (querySnapshot) async {
        for (var docSnapshot in querySnapshot.docs) {
          // userUidList.add(docSnapshot['userUID']);
          await _instance!.collection('users').doc(docSnapshot['userUID']).get().then(
            (querySnapshot) {
              userURL[docSnapshot['userUID']] = '${querySnapshot.data()?['selfie']}';
            }
          );
        }
      }
    );

    // returns a map of UID:url
    return userURL;
  }

  // this is a working but less efficient version of the function above
  // Future<Map<String, String>> getBlogUserUIDv1() async {
  //   // get firestore instance
  //   _instance = FirebaseFirestore.instance;

  //   // to store user UIDs
  //   final List<String> userUidList = [];

  //   // to store user URLs
  //   final List<String> userSelfieUrlList = [];

  //   // to store Map of UID:URLs
  //   final Map<String, String> userURL = {};

  //   // get all blog docs & store UIDs in list
  //   await _instance!.collection('blog').get().then(
  //     (querySnapshot) {
  //       for (var docSnapshot in querySnapshot.docs) {
  //         userUidList.add(docSnapshot['userUID']);
  //       }
  //     }
  //   );

  //   // get user URLs from blog doc UIDs and store in list
  //   for (var uid in userUidList) {
  //     await _instance!.collection('users').doc(uid).get().then(
  //       (querySnapshot) {
  //         userSelfieUrlList.add(querySnapshot.data()?['selfie']);
  //         userURL[uid] = '${querySnapshot.data()?['selfie']}';
  //       }
  //     );
  //   }

  //   // returns a map of UID:url
  //   return userURL;
  // }
}