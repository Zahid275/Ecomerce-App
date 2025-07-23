import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_application/Pages/homePage.dart';
import 'package:ecomerce_application/Pages/accountPage.dart';
import 'package:ecomerce_application/Pages/cartPage.dart';
import 'package:ecomerce_application/Pages/favPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class ItemProvider extends ChangeNotifier {
  ItemProvider() {
    getStream();
    getUserStream();
    getFavStream();
    getFavItems();
    getCartStream();
    Timer(const Duration(microseconds: 0), () {
      FlutterNativeSplash.remove();
    });
  }

/////////////////////////////////////////AuthPage Logic//////////////////////////////////////////////////////////////////////////

  String? name;
  String? phoneNO;
  String? address;
  String? password;
  String? email;
  String? confirmPass;
  bool isSignUp = false;


 bool obsecureTextPass = false;
  bool obsecureTextCon = false;

  togglePassIcon(){
    obsecureTextPass = !obsecureTextPass;
    notifyListeners();
  }
  toggleConfirmPassIcon(){
    obsecureTextCon = !obsecureTextCon;
    notifyListeners();
  }


  toggleSignUp() {
    isSignUp = !isSignUp;

    notifyListeners();
  }


  signIn(

      {required String email,
      required String password,
      required context}) async {
    toggleLoding();
    if (email.toString() != "null" && password.toString() != "null") {
      try {
         await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

      toggleLoding();
      } on FirebaseAuthException catch (e){
        toggleLoding();

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.code}")));
      }
    } else {
      toggleLoding();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter all the required credentials")));
    }
  }

  signUp(
      {required String email,
      required String password,
      required String name,
      required String phoneNo,
      required String address,
      required String confirmPass,
      required context}) async {
    if (name.toString() != "null" &&
        password.toString() != "null" &&
        phoneNo.toString() != "null" &&
        address.toString() != "null" &&
        email.toString() != "null" &&
        confirmPass.toString() != "null") {
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
          "Phone No": phoneNo
        });
        toggleLoding();
      } on FirebaseAuthException catch (e) {
        toggleLoding();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(("${e.code}"))));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("Please write all the required credentials correctly")));
    }
  }

  clearCredentials(){

   name= null;
   phoneNO= null;
   address= null;
   password= null;
   email= null;
   confirmPass= null;
  }


  ///SocialButton Custom Widget Function Based
  Widget socialButton({
    required imgPath,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 46,
        width: 46,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(blurRadius: 5, spreadRadius: 0.5, offset: Offset(1, 2))
            ]),
        child: Image.asset(imgPath),
      ),
    );
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

/////////////////////////////////////////HomePage Logic//////////////////////////////////////////////////////////////////////////

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? filteredItems = [];
String querry="";
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
    "assets/posters/poster3.png"
  ];

  List catIcons = [
    "assets/icons/all3.jpg",
    "assets/icons/mobile.png",
    "assets/icons/laptop.png",
    "assets/icons/buds.png",
    "assets/icons/smart watch.png"
  ];
  int categoryIndex = 0;

  List<Widget> pages = [
    const Homepage(),
    const Cartpage(),
    const FavPage(),
     const AccountPage()
  ];

  Stream<QuerySnapshot<Map<String, dynamic>>>? getStream() {
    if (categoryIndex == 0) {
      return FirebaseFirestore.instance.collection("Producs").snapshots();
    } else if (categoryIndex == 1) {
      return FirebaseFirestore.instance
          .collection("Producs")
          .where("category", isEqualTo: "Mobile")
          .snapshots();
    } else if (categoryIndex == 2) {
      return FirebaseFirestore.instance
          .collection("Producs")
          .where("category", isEqualTo: "Laptop")
          .snapshots();
    } else if (categoryIndex == 3) {
      return FirebaseFirestore.instance
          .collection("Producs")
          .where("category", isEqualTo: "Earphone")
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection("Producs")
          .where("category", isEqualTo: "Smart Watch")
          .snapshots();
    }
  }

  getDocs(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    getStream()!.listen((snapshot) {
      docs = snapshot.docs;
      if(querry == ""){
        filteredItems = List.from(docs!);
      }

    });
  }



/////////////////////////////////////////ItemPage Logic///////////////////////////////////////////////////////////////

  String selectedColor = "White";
  int quantity = 1;

  List<Color> colors = [Colors.white, Colors.black, Colors.blue, Colors.yellow];
  List<String> realColors = ["White", "Black", "Blue", "Yellow"];

  List<Color> borderColors = [
    Colors.pink,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  quantityInc() {
    quantity++;
    notifyListeners();
  }

  quantityDec() {
    if (quantity > 1) {
      quantity = quantity - 1;
    }
    notifyListeners();
  }

  ///this is a function for selecting colors of an item
  changeColor({required int index}) {
    if (borderColors[index] == Colors.white) {
      borderColors[index] = Colors.pink;
      for (int i = 0; i < borderColors.length; i++) {
        if (i == index) {
          continue;
        }
        borderColors[i] = Colors.white;
      }
    }
    selectedColor = realColors[index];
    notifyListeners();
  }

  List<Map<String, dynamic>> cartItemList = [];

  num totalPrice = 0;

/////////////////////////////////////////FavouritePage Logic//////////////////////////////////////////////////////////
  List<QueryDocumentSnapshot<Map<String, dynamic>>> favDocs = [];
  Stream<QuerySnapshot<Map<String, dynamic>>>? favStream;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> favItems = [];
  List<String> favItemsNames = [];

  bool isFav = false;

  getFavStream() async {
    String email =   FirebaseAuth.instance.currentUser!.email.toString();

    favStream = FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("FavItems")
        .snapshots();
  }

  getFavDocs(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    favStream!.listen((snapshot) {
      favDocs = snapshot.docs;
    });
    getFavNames();
  }

  getFavItems() async {
    String email =   FirebaseAuth.instance.currentUser!.email.toString();
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("FavItems")
        .get()
        .then((snapshot) {
      favDocs = snapshot.docs;
    });
    getFavNames();
  }

  ///For adding and deleting items of favourites from item Page
  favToggle(final item) async {
    String email = await  FirebaseAuth.instance.currentUser!.email.toString();

    if (favItemsNames.contains(item["name"])) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(email)
          .collection("FavItems")
          .doc(item["name"])
          .delete();

      favItemsNames.remove(item["name"]);
    } else {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(email)
          .collection("FavItems")
          .doc(item["name"])
          .set({
        "color": selectedColor,
        "specs": item["specs"],
        "name": item["name"],
        "price": item["price"],
        "category": item["category"],
        "imageUrl": item["imageUrl"]
      });
      favItemsNames.add(item["name"]);
    }

    notifyListeners();
  }

  getFavNames() {
    favItemsNames = favDocs.map((doc) => doc["name"].toString()).toList();
  }

  checkFav(final item) {

    if (favItemsNames.contains(item["name"])) {
      isFav = true;
      return isFav;
    } else {
      isFav = false;
      return isFav;
    }
  }

  ///Deleting Fav item
  deleteFav(int index) async {
    String email =   FirebaseAuth.instance.currentUser!.email.toString();

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("FavItems")
        .doc(favDocs.toList()[index]["name"])
        .delete();

    notifyListeners();
  }

/////////////////////////////////////////CartPage Logic////////////////////////////////////////////////////////////////////////

  Stream<QuerySnapshot<Map<String, dynamic>>>? cartStream;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> cartDocs = [];

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

  getCartStream() async {
    String email =   FirebaseAuth.instance.currentUser!.email.toString();

    cartStream = FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("CartItems")
        .snapshots();
  }

  getCartDocs(AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    cartStream!.listen((snapshot) {
      cartDocs = snapshot.docs;
    });
  }

  addToCart({required item, required quantity}) async {
    String email =   FirebaseAuth.instance.currentUser!.email.toString();
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
        "imageUrl": item["imageUrl"]
      });
    }



  deleterCartItem(int index) async {
    String email =   FirebaseAuth.instance.currentUser!.email.toString();
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection("CartItems")
        .doc(cartDocs[index].id)
        .delete();
    notifyListeners();
  }

/////////////////////////////////////////SearchBar Logic/////////////////////////////////////////////////////////////////////////

  void filterItems(String query) {
    if(query.isEmpty){
      filteredItems = List.from(docs!);
    }else {
      filteredItems = docs!.where((item) {
        return item["name"].toString().toLowerCase().contains(
            query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  /////////////////////////////////////AccountPage Logic///////////////////////////////////////////////////////

  Map<String, dynamic>? userDocs={};
  Stream<DocumentSnapshot<Map<String, dynamic>>>? userStream;
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream() {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .snapshots();
  }

   getUserDocs(AsyncSnapshot  snapshot)async {
      userDocs =  snapshot.data?.data();
  }


  /////////////////////////////////////Shared Preference ///////////////////////////////////////////////////////






  bool isLoading = false;

  toggleLoding(){
    isLoading = !isLoading;
    notifyListeners();

  }
}





/////DEMO DATA
//
// List<List<Map<String, dynamic>>> itemsInfo = [
//   /// For Mobiles
//   [
//     {
//       "name": "Realme 12",
//       "price": 80000,
//       "specs":
//       "6.5-inch display, 108MP camera, 5000mAh battery, Snapdragon 8 Gen 1",
//       "isFav": false,
//       "imageUrl":"https://res.cloudinary.com/dz6supklb/image/upload/v1737043323/xiaomi_12_czsbyo.jpg",
//       "category":"Mobile"
//
//
//     },
//     {
//       "name": "Samsung Galaxy A55",
//       "price": 80000,
//       "specs": "6.6-inch display, 64MP camera, 5000mAh battery, Exynos 1280",
//       "isFav": false,       "category": "Mobile",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043322/samsung_galaxy_a55_hs4gng.webp",
//     },
//     {
//       "name": "Samsung Galaxy S22 Ultra",
//       "price": 200000,
//       "specs":
//       "6.8-inch display, 108MP camera, 5000mAh battery, Snapdragon 8 Gen 1",
//       "isFav": false,       "category": "Mobile",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043323/samsung_galaxy_s22_ultra_axrbzf.jpg"
//     },
//     {
//       "name": "Samsung Galaxy A54",
//       "price": 70000,
//       "specs": "6.4-inch display, 50MP camera, 5000mAh battery, Exynos 1380",
//       "isFav": false,       "category": "Mobile",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043322/samsung_galaxy_a54_zq6cpo.jpg"
//     },
//     {
//       "name": "Xiaomi Redmi 10C",
//       "price": 29999,
//       "specs":
//       "6.7-inch display, 50MP camera, 5000mAh battery, Snapdragon 680",
//       "isFav": false,       "category": "Mobile",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043324/xiaomi_redmi_10c_htwqst.jpg"
//     },
//     {
//       "name": "Xiaomi Redmi 13 Pro Plus",
//       "price": 50000,
//       "specs":
//       "6.73-inch display, 200MP camera, 5100mAh battery, MediaTek Dimensity 9200+",
//       "isFav": false,       "category": "Mobile",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043327/xiaomi_redmi_13_pro_plus_vjsscs.webp"
//     },
//     {
//       "name": "Xiaomi 12",
//       "price": 30000,
//       "specs":
//       "6.28-inch display, 50MP camera, 4500mAh battery, Snapdragon 8 Gen 1",
//       "isFav": false,       "category": "Mobile",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043325/xiaomi_redmi_12_ultra_uygity.jpg"
//     },
//   ],
//
//   /// For Laptop
//   [
//     {
//       "name": "Acer Aspire 5",
//       "price": 115000,
//       "specs": "15.6-inch display, Intel i5 12th Gen, 8GB RAM, 512GB SSD",
//       "isFav": false,       "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043316/acer_aspire_5_rm2aof.webp"
//     },
//     {
//       "name": "Dell Inspiron 7430",
//       "price": 130000,
//       "specs": "14-inch display, Intel i7 13th Gen, 16GB RAM, 512GB SSD",
//       "isFav": false,      "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043313/dell_inspiron_7430_en2fax.webp"
//     },
//     {
//       "name": "Dell Latitude 15 3540",
//       "price": 100000,
//       "specs": "15.6-inch display, Intel i5 13th Gen, 8GB RAM, 512GB SSD",
//       "isFav": false,       "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043313/dell_latitude_15_3540_ttiack.webp"
//     },
//     {
//       "name": "Dell Latitude 3540",
//       "price": 95000,
//       "specs": "15.6-inch display, Intel i5 12th Gen, 8GB RAM, 256GB SSD",
//       "isFav": false,       "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043313/dell_latitude_3540_e8i1s0.webp"
//     },
//     {
//       "name": "Dell Vostro 3520",
//       "price": 90000,
//       "specs": "15.6-inch display, Intel i5 11th Gen, 8GB RAM, 512GB SSD",
//       "isFav": false,        "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043313/dell_vostro_3520_c4bjhw.webp"
//     },
//     {
//       "name": "HP EliteBook 640",
//       "price": 120000,
//       "specs": "14-inch display, Intel i5 13th Gen, 16GB RAM, 512GB SSD",
//       "isFav": false,      "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043314/hp_elitebook_640_okzfsb.webp"
//     },
//     {
//       "name": "HP 15-FD0334 NIA",
//       "price": 70000,
//       "specs": "15.6-inch display, Intel i3 11th Gen, 8GB RAM, 256GB SSD",
//       "isFav": false,       "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043314/hp_15-fd0334_nia_cgrmui.webp"
//     },
//     {
//       "name": "HP 15s EQ2322 AU",
//       "price": 75000,
//       "specs": "15.6-inch display, AMD Ryzen 5 5500U, 8GB RAM, 512GB SSD",
//       "isFav": false,      "category": "Laptop",
//
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043313/hp_15s_eq2322_au_ptfzsk.webp"
//     },
//     {
//       "name": "Lenovo Ideapad 3",
//       "price": 80000,
//       "specs": "15.6-inch display, Intel i5 12th Gen, 8GB RAM, 512GB SSD",
//       "isFav": false, "category": "Laptop",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043314/lenovo_ideapad_3_yzh5gv.webp"
//     },
//     {
//       "name": "Lenovo Thinkpad E16",
//       "price": 150000,
//       "specs": "16-inch display, Intel i7 13th Gen, 16GB RAM, 1TB SSD",
//       "isFav": false, "category": "Laptop",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043315/lenovo_thinkpad_e16_ord7of.webp"
//     },
//   ],
//
//   /// For Buds
//   [
//     {
//       "name": "Ronin R-520 Earbuds",
//       "price": 4100,
//       "specs": "Bluetooth 5.0, 4-hour battery, water-resistant",
//       "isFav": false, "category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043321/ronin_r-520_earbuds_umvmyt.webp"
//     },
//     {
//       "name": "Ronin R-7020 Earbuds",
//       "price": 6000,
//       "specs": "Bluetooth 5.0, 5-hour battery, noise cancellation",
//       "isFav": false,"category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043323/ronin_r-7020_earbuds_nibbnv.webp"
//     },
//     {
//       "name": "Ronin R-7025 Earbuds",
//       "price": 6200,
//       "specs": "Bluetooth 5.0, 5-hour battery, water-resistant",
//       "isFav": false,"category": "Earphone",
//       "imageUrl":"https://res.cloudinary.com/dz6supklb/image/upload/v1737043322/ronin_r-7025_earbuds_gat5ta.webp"
//     },
//     {
//       "name": "Ronin R-1500 Headphone",
//       "price": 3200,
//       "specs": "Wired, over-ear, 40mm drivers",
//       "isFav": false,"category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043321/ronin_r-1500_headphone_neemoq.webp"
//     },
//     {
//       "name": "Ronin R-710 Earbuds",
//       "price": 5000,"category": "Earphone",
//       "specs": "Bluetooth 5.0, 6-hour battery, sweat-proof",
//       "isFav": false,
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043321/ronin_r-710_earbuds_tpoqx4.webp"
//     },
//     {
//       "name": "Ronin R-140 Earbuds",
//       "price": 6000,
//       "specs": "Bluetooth 5.0, 7-hour battery, noise cancellation",
//       "isFav": false,"category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043317/ronin_r-140_earbuds_hkjexi.webp"
//     },
//     {
//       "name": "Ronin R-190 Earbuds",
//       "price": 5000,
//       "specs": "Bluetooth 5.0, 6-hour battery, water-resistant",
//       "isFav": false,"category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043320/ronin_r-190_earbuds_h7taqi.webp"
//     },
//     {
//       "name": "Ronin R-540 Earbuds",
//       "price": 4100,
//       "specs": "Bluetooth 5.0, 4-hour battery, ergonomic fit",
//       "isFav": false,"category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043321/ronin_r-540_earbuds_qs6zqo.webp"
//     },
//     {
//       "name": "Ronin R-570 Earbuds",
//       "price": 4500,
//       "specs": "Bluetooth 5.0, 5-hour battery, noise cancellation",
//       "isFav": false,"category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043322/ronin_r-570_earbuds_avrnke.webp"
//     },
//     {
//       "name": "Ronin R-740 Earbuds",
//       "price": 6200,
//       "specs": "Bluetooth 5.0, 7-hour battery, water-resistant",
//       "isFav": false,"category": "Earphone",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043321/ronin_r-740_earbuds_hkvnd9.webp"
//     },
//   ],
//
//   /// For Smart Watches
//   [
//     {
//       "name": "Ronin R06 Smart Watch",
//       "price": 4000,
//       "specs": "1.3-inch display, heart rate monitor, IP67 rating",
//       "isFav": false,"category": "Smart Watch",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043315/ronin_r06_smart_watch_ruup2o.webp"
//     },
//     {
//       "name": "Ronin R08 Smart Watch",
//       "price": 4500,
//       "specs": "1.4-inch display, fitness tracking, water-resistant",
//       "isFav": false,"category": "Smart Watch",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043316/ronin_r08_smart_watch_y3wwm4.webp"
//     },
//     {
//       "name": "Ronin R09 Smart Watch",
//       "price": 6000,
//       "specs": "1.4-inch display, heart rate monitor, Bluetooth calling",
//       "isFav": false,"category": "Smart Watch",
//       "imageUrl":"https://res.cloudinary.com/dz6supklb/image/upload/v1737043316/ronin_r09_smart_watch_rxxwnr.webp"
//     },
//     {
//       "name": "Ronin R02 Smart Watch",
//       "price": 2000,
//       "specs": "1.2-inch display, fitness tracking, IP67 rating",
//       "isFav": false,"category": "Smart Watch",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043315/ronin_r02_smart_watch_l1rxlc.webp"
//     },
//     {
//       "name": "Ronin R04 Smart Watch",
//       "price": 3000,
//       "specs": "1.3-inch display, heart rate monitor, water-resistant",
//       "isFav": false,"category": "Smart Watch",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043315/ronin_r04_smart_watch_yf7e5p.webp"
//     },
//     {
//       "name": "Ronin R010 Smart Watch",
//       "price": 8000,
//       "specs": "1.5-inch display, Bluetooth calling, IP68 rating",
//       "isFav": false,"category": "Smart Watch",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043316/ronin_r010_smart_watch_tkmfwp.webp"
//     },
//     {
//       "name": "Ronin R012 Smart Watch",
//       "price": 10000,
//       "specs": "1.6-inch display, fitness tracking, Bluetooth calling",
//       "isFav": false,"category": "Smart Watch",
//       "imageUrl": "https://res.cloudinary.com/dz6supklb/image/upload/v1737043317/ronin_r012_smart_watch_u4scxb.webp"
//     },
//   ],
// ];
