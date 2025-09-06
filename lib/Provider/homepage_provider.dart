import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../Pages/accountPage.dart';
import '../Pages/cartPage.dart';
import '../Pages/favPage.dart';
import '../Pages/homePage.dart';

class HomePage_Provider extends ChangeNotifier{
  HomePage_Provider(){
    loadDocs();
    FlutterNativeSplash.remove();

  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? filteredItems = [];
  String querry = "";
  String currentCategory = "All";

  upCatIndex(int index) {
    categoryIndex = index;
    if (categoryIndex == 0) {
      currentCategory = "All";
    } else if (categoryIndex == 1) {
      currentCategory = "Mobile";
    } else if (categoryIndex == 2) {
      currentCategory = "Laptop";
    } else if (categoryIndex == 3) {
      currentCategory = "Smart Watch";
    }

    notifyListeners();
  }

  ///This function change the currentIndex of bottom Nav
  int currentIndex = 0;

  onChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List posters = [
    "assets/posters/poster1.png",
    "assets/posters/poster2.png",
    "assets/posters/poster3.png",
  ];

  List catIcons = [
    "assets/icons/all3.jpg",
    "assets/icons/mobile.png",
    "assets/icons/laptop.png",
    "assets/icons/buds.png",
    "assets/icons/smart watch.png",
  ];
  int categoryIndex = 0;

  List<Widget> pages = [
    const Homepage(),
    const Cartpage(),
    const FavPage(),
    const AccountPage(),
  ];

  Future<void> loadDocs() async {

    // Fetch only when there is no data
    if (docs!.isEmpty) {
      final snap = await FirebaseFirestore.instance.collection("Producs").get();
      docs = snap.docs;
      filteredItems = List.from(docs!);
      notifyListeners();
    }
  }

  void filterByCategory(int index) {
    final categories = ["All", "Mobile", "Laptop", "Earphone", "Smart Watch"];

    if (index == 0) {
      // no filter → show all
      filteredItems = List.from(docs!);
    } else {
      filteredItems =
          docs!.where((doc) => doc["category"] == categories[index]).toList();
    }
    notifyListeners();
  }
  /////////////////////////////////////////SearchBar Logic/////////////////////////////////////////////////////////////////////////

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = List.from(docs!);
    } else {
      filteredItems =
          docs!.where((item) {
            return item["name"].toString().toLowerCase().contains(
              query.toLowerCase(),
            );
          }).toList();
    }
    notifyListeners();
  }




}