import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AccountProvider extends ChangeNotifier{
  Map<String, dynamic>? userDocs = {};
  Stream<DocumentSnapshot<Map<String, dynamic>>>? userStream;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .snapshots();
  }

  getUserDocs(AsyncSnapshot snapshot) async {
    userDocs = snapshot.data?.data();
  }
}