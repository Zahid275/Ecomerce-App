import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> favDocs = [];
  List<String> favItemsNames = [];

  bool isFav = false;

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavStream() {
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("FavItems")
        .snapshots()
        .map((snapshot) {
          favItemsNames =
              snapshot.docs.map((doc) => doc["name"] as String).toList();
          notifyListeners();
          return snapshot;
        });
  }

  ///For adding and deleting items of favourites from item Page
  favToggle(final item, {required selectedColor}) async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    final name = item["name"];

    final alreadyFav = favItemsNames.contains(name);

    // 🔹 Update local state first (instant UI update)
    if (alreadyFav) {
      favItemsNames.remove(name);
    } else {
      favItemsNames.add(name);
    }
    notifyListeners();

    try {
      final favDoc = FirebaseFirestore.instance
          .collection("Users")
          .doc(email)
          .collection("FavItems")
          .doc(name);

      if (alreadyFav) {
        await favDoc.delete();
      } else {
        await favDoc.set({
          "color": selectedColor,
          "specs": item["specs"],
          "name": name,
          "price": item["price"],
          "category": item["category"],
          "imageUrl": item["imageUrl"],
        });
      }
    } catch (e) {
      // 🔹 Rollback if Firestore fails
      if (alreadyFav) {
        favItemsNames.add(name);
      } else {
        favItemsNames.remove(name);
      }
      notifyListeners();
    }
  }

  bool checkFav(final item) {
    if (favItemsNames.contains(item["name"])) {
      isFav = true;
      return isFav;
    } else {
      isFav = false;
      return isFav;
    }
  }

  ///Deleting Fav item
  deleteFav(String item, {required BuildContext context}) async {
    String? email = FirebaseAuth.instance.currentUser!.email;

    favItemsNames.remove(item);

    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(email)
          .collection("FavItems")
          .doc(item)
          .delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not added to Favourites, $e")),
      );
      // rollback if failed
      favItemsNames.remove(item);
    }
  }
}
