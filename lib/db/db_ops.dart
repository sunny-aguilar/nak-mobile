import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
// final userUID = auth.currentUser!.uid;

// userReference = db.collection('users');
// query = userReference.doc(userUID).get();

class UserService {
  FirebaseFirestore? _instance;

  Future<Map> getUsersFromFirebase() async {
    _instance = FirebaseFirestore.instance;
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = _instance!.collection('users');
    DocumentSnapshot snapshot = await users.doc(userUID).get();
    await Future.delayed(const Duration(milliseconds: 500));
    return snapshot.data() as Map;
  }
}

String makeUser() {
  var x = UserService().getUsersFromFirebase();
  print('x: $x');
  final jsonData = '{ "uid": "randomstring", "firstName": "Sandro", "lastName": "Aguilar", "chapter": "Iota", "lineNumber": "33", "status": "Alumni", "email": "sunny@me.com" }';
  final parsedJson = jsonDecode(jsonData);
  final user = Users.fromJson(parsedJson);
  print('user.firstName: ${user.firstName}');
  return 'RETURNING USER';
}

class Users{
  Users({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.chapter,
    required this.lineNumber,
    required this.status,
    required this.email
  });
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? chapter;
  final String? lineNumber;
  final String? status;
  final String? email;

  factory Users.fromJson(Map<String, dynamic> json) {
    final String uid = json['uid'];
    final String firstName = json['firstName'];
    final String lastName = json['lastName'];
    final String chapter = json['chapter'];
    final String lineNumber = json['lineNumber'];
    final String status = json['status'];
    final String email = json['email'];

    return Users(uid: uid, firstName: firstName, lastName: lastName, chapter: chapter, lineNumber: lineNumber, status: status, email: email);
    // return Users(
    //   uid: json['uid'] as String,
    //   firstName: json['firstname'] as String,
    //   lastName: json['lastName'] as String,
    //   chapter: json['chapter'] as String,
    //   lineNumber: json['lineNumber'] as String,
    //   status: json['status'] as String,
    //   email: json['email'] as String,
    // );
  }

  factory Users.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final String uid = data?['uid'];
    final String firstName = data?['firstName'];
    final String lastName = data?['lastName'];
    final String chapter = data?['chapter'];
    final String lineNumber = data?['lineNumber'];
    final String status = data?['status'];
    final String email = data?['email'];
    return Users(uid: uid, firstName: firstName, lastName: lastName, chapter: chapter, lineNumber: lineNumber, status: status, email: email);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) 'uid': uid,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (chapter != null) 'chapter': chapter,
      if (lineNumber != null) 'lineNumber': lineNumber,
      if (status != null) 'status': status,
      if (email != null) 'email': email,
    };
  }

  // Future<String> getname() async {
  //   final userRef = db.collection('users');
  //   final docSnapshot = await userRef.doc(userUID).get();
  //   if (docSnapshot.exists) {
  //     // DBOps.fromJson(docSnapshot.data());
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     var firstName = data?['firstName'];
  //     var lastName = data?['lastName'];
  //     // print('Name: $firstName $lastName');
  //     print('Data: $data');
  //     return '$firstName $lastName';
  //   }
  //   return '';
  // }
}

class GetUserData extends StatefulWidget {
  const GetUserData({super.key, required this.field});
  final String field;
  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
    // // get auth instance
    // final FirebaseAuth auth = FirebaseAuth.instance;

    // READ OPERATIONS
    // Future<User> getUsers() async {
    //   CollectionReference users = db.collection('users');
    //   DocumentSnapshot snapshot = await users.doc('uToicHpgAofoivUnqzQQxdNII5O2').get();
    //   var data = snapshot.data() as Map;
    //   print('Data: $data');
    //   return Users(data);
    // }

    Future<void> readID() async {
      final userUID = auth.currentUser!.uid;

      // get document with specific doc id
      final userRef = db.collection('users');
      final docSnapshot = await userRef.doc(userUID).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var value = data?['email'];
        print('Value: $value');
      }

      // get document with specific doc id using .then()
      final userDoc = db.collection('users').doc(userUID);
      userDoc.get().then(
        (doc) async {
          print('First Name: ${doc.get('firstName')}');
          print('Last Name: ${doc.get('lastName')}');
          print('Chapter: ${doc.get('chapter')}');
          print('Line #: ${doc.get('lineNumber')}');
          print('Email: ${doc.get('email')}');
          print('Status: ${doc.get('status')}');
        },
        onError: (e) => print("Error completing: $e"),
      );

      // get data by looping through documents with a specific value in a field
      final userQuery = userRef.where('uid', isEqualTo: userUID);
      userQuery.get().then(
        (querySnapshot) {
          print('Successfully completed query');
          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
          }
        }
      );

      // prints document # using Future APi
      final userSnapshot = await db.collection('users').get();
      userSnapshot.docs.forEach((document) {
        print('Document: ${document.reference}');
      });

      // prints document # using Async and Await
      await db.collection('users').get().then(
        (snapshot) => snapshot.docs.forEach((document) {
          print('Document: ${document.reference}');
        })
      );
    }

    /*
      ADD OPERATIONS
    */
    Future<void> addData() async {
      // add data to database
      final cities = db.collection("cities");
      final data1 = <String, dynamic>{
        "name": "San Francisco",
        "state": "CA",
        "country": "USA",
        "capital": false,
        "population": 860000,
        "regions": ["west_coast", "norcal"]
      };
      // add data to database
      cities.doc("SF").set(data1);

      // get reference to cities collection
      final citiesRef = db.collection("cities");

      // Create a query against the collection.
      final query = citiesRef.where("state", isEqualTo: "CA");

      // return all capital cities from query
      final capitalcities = query;

      // execute the query
      capitalcities.get().then(
        (querySnapshot) {
          print('Successfully completed');
          for (var docSnapshot in querySnapshot.docs) {
            print('${docSnapshot.id} => ${docSnapshot.data()}');
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    }

  @override
  Widget build(BuildContext context) {
    readID();
    return const Text('TESTING');
  }
}