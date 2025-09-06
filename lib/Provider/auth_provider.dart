import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_application/Provider/favProvider.dart';
import 'package:ecomerce_application/Provider/homepage_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authentication_Provider extends ChangeNotifier {
  String? name;
  String? phoneNO;
  String? address;
  String? password;
  String? email;
  String? confirmPass;
  bool isSignUp = false;

  bool obsecureTextPass = false;
  bool obsecureTextCon = false;

  togglePassIcon() {
    obsecureTextPass = !obsecureTextPass;
    notifyListeners();
  }

  toggleConfirmPassIcon() {
    obsecureTextCon = !obsecureTextCon;
    notifyListeners();
  }

  toggleSignUp() {
    isSignUp = !isSignUp;

    notifyListeners();
  }

  bool isLoading = false;

  toggleLoding() {
    isLoading = !isLoading;
    notifyListeners();
  }

  signIn({
    required String email,
    required String password,
    required context,
  }) async {
    toggleLoding();
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        toggleLoding();
      } on FirebaseAuthException catch (e) {
        toggleLoding();

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.code)));
      }
    } else {
      toggleLoding();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter all the required credentials"),
        ),
      );
    }
  }

  signUp({
    required String email,
    required String password,
    required String name,
    required String phoneNo,
    required String address,
    required String confirmPass,
    required context,
  }) async {
    if (name.isNotEmpty &&
        password.isNotEmpty &&
        phoneNo.isNotEmpty &&
        address.isNotEmpty &&
        email.isNotEmpty &&
        confirmPass.isNotEmpty) {
      try {
        toggleLoding();
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(email.toString())
            .set({
          "email": email,
          "password": password,
          "name": name,
          "address": address,
          "Phone No": phoneNo,
        });
        toggleLoding();
      } on FirebaseAuthException catch (e) {
        toggleLoding();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.code)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please write all the required credentials correctly"),
        ),
      );
    }
  }

  clearCredentials() {
    name = null;
    phoneNO = null;
    address = null;
    password = null;
    email = null;
    confirmPass = null;
  }

  ///SocialButton Custom Widget Function Based
  Widget socialButton({required imgPath, required context}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.06,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.13,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(blurRadius: 5, spreadRadius: 0.5, offset: Offset(1, 2)),
          ],
        ),
        child: Image.asset(imgPath),
      ),
    );
  }

  signOut(BuildContext context) async {
    Provider.of<HomePage_Provider>(context, listen: false).currentIndex = 0;
    Provider.of<FavProvider>(context, listen: false).favItemsNames.clear();
    clearCredentials();
    await FirebaseAuth.instance.signOut();
  }
}