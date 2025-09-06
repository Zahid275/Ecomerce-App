import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {

  Stream<QuerySnapshot<Map<String, dynamic>>>? cartStream;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cartDocs = [];
  num totalPrice = 0;

  totalPriceCalculate() {
    totalPrice = 0;
    for (int i = 0; i < cartDocs.length; i++) {
      if (cartDocs[i]["price"] != null) {
        totalPrice =
            totalPrice + cartDocs[i]["price"] * cartDocs[i]["quantity"];
      }
    }
    return totalPrice;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCartStream() {
    String email = FirebaseAuth.instance.currentUser!.email.toString();

    return FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("CartItems")
        .snapshots();
  }

  addToCart({required item, required quantity,required selectedColor}) async {
    String email = FirebaseAuth.instance.currentUser!.email.toString();
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("CartItems")
        .doc(item["name"])
        .set({
          "quantity": quantity,
          "color": selectedColor,
          "specs": item["specs"],
          "name": item["name"],
          "price": item["price"],
          "category": item["category"],
          "imageUrl": item["imageUrl"],
        });
  }

  deleterCartItem(int index) async {
    String email = FirebaseAuth.instance.currentUser!.email.toString();
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("CartItems")
        .doc(cartDocs[index].id)
        .delete();
  }
}
