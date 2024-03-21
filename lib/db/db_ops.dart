import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final userUID = auth.currentUser!.uid;

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
    return Users(
      uid: json['uid'],
      firstName: json['firstname'],
      lastName: json['lastName'],
      chapter: json['chapter'],
      lineNumber: json['lineNumber'],
      status: json['status'],
      email: json['email'],
    );
  }

  factory Users.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Users(
      uid: data?['uid'],
      firstName: data?['firstname'],
      lastName: data?['lastName'],
      chapter: data?['chapter'],
      lineNumber: data?['lineNumber'],
      status: data?['status'],
      email: data?['email'],
    );
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

  Widget getText() {
    return Text('EMPTY');
  }
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