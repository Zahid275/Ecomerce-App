import 'dart:async';
import 'package:ecomerce_app/Pages/homePage.dart';
import 'package:ecomerce_app/Pages/accountPage.dart';
import 'package:ecomerce_app/Pages/cartPage.dart';
import 'package:ecomerce_app/Pages/favPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class itemProvider extends ChangeNotifier {
  itemProvider() {
    AddingItems();
    filteredItems = showItemsList;

  Timer(Duration(seconds: 1),(){FlutterNativeSplash.remove();});
  }

 String selectedColor = "White";

  int quantity = 1;

  resetQuantity() {
    quantity = 1;
  }

  incrementQuantity() {
    quantity = quantity + 1;
    notifyListeners();
  }

  decrementQuantity() {
    if (quantity > 1) {
      quantity = quantity - 1;
      notifyListeners();
    }
  }

  addToCart(Map item) {
    cartItemList.add({
      "name": item["name"],
      "price": item["price"],
      "specs": item["specs"],
      "quantity": quantity,
      "color": selectedColor
    });
    print(cartItemList);
  }

  deleteCartItem(int index) {
    cartItemList.removeAt(index);
    notifyListeners();
  }

  List<Color> colors = [Colors.white, Colors.black, Colors.blue, Colors.yellow];
  List<String> realColors = ["white", "black", "blue","yellow"];

  List<Color> borderColors = [
    Colors.pink,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

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
    } else {
      borderColors[index] = Colors.white;
    }
    selectedColor = realColors[index];
    print(selectedColor);
    notifyListeners();
  }

  List<Map<String, dynamic>> cartItemList = [];
  Set<Map<String, dynamic>> favItemSet = {};

  List posters = [
    "assets/posters/poster1.png",
    "assets/posters/poster2.png",
    "assets/posters/poster3.png"
  ];

  List CatIcons = [
    "assets/icons/all3.jpg",
    "assets/icons/mobile.png",
    "assets/icons/laptop.png",
    "assets/icons/buds.png",
    "assets/icons/smart watch.png"
  ];
  int categoryIndex = 0;

  List<Widget> Pages = [
    Homepage(),
    const Cartpage(),
    const FavPage(),
    const Accountpage()
  ];

  num totalPrice = 0;

  ///This function calculates the total price by adding the price and the product of price and quantity
  TotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < cartItemList.length; i++) {
      if (cartItemList[i]["price"] != null) {
        totalPrice =
            totalPrice + cartItemList[i]["price"] * cartItemList[i]["quantity"];
      }
      print(totalPrice);
    }
    return totalPrice;
  }

  UpCatIndex(int index) {
    categoryIndex = index;
    notifyListeners();


  }

  List<Map<String, dynamic>> showItemsList = [];
  List<List<Map<String, dynamic>>> itemsInfo = [
    /// For Mobiles
    [
      {
        "name": "Realme 12",
        "price": 80000,
        "specs":
            "6.5-inch display, 108MP camera, 5000mAh battery, Snapdragon 8 Gen 1",
        "isFav": false
      },
      {
        "name": "Samsung Galaxy A55",
        "price": 80000,
        "specs": "6.6-inch display, 64MP camera, 5000mAh battery, Exynos 1280",
        "isFav": false
      },
      {
        "name": "Samsung Galaxy S22 Ultra",
        "price": 200000,
        "specs":
            "6.8-inch display, 108MP camera, 5000mAh battery, Snapdragon 8 Gen 1",
        "isFav": false
      },
      {
        "name": "Samsung Galaxy A54",
        "price": 70000,
        "specs": "6.4-inch display, 50MP camera, 5000mAh battery, Exynos 1380",
        "isFav": false
      },
      {
        "name": "Xiaomi Redmi 10C",
        "price": 29999,
        "specs": "6.7-inch display, 50MP camera, 5000mAh battery, Snapdragon 680",
        "isFav": false
      },
      {
        "name": "Xiaomi Redmi 13 Pro Plus",
        "price": 50000,
        "specs":"6.73-inch display, 200MP camera, 5100mAh battery, MediaTek Dimensity 9200+",
        "isFav": false
      },
      {
        "name": "Xiaomi 12",
        "price": 30000,
        "specs":"6.28-inch display, 50MP camera, 4500mAh battery, Snapdragon 8 Gen 1",
        "isFav": false
      },
    ],

    /// For Laptop
    [
      {
        "name": "Acer Aspire 5",
        "price": 115000,
        "specs": "15.6-inch display, Intel i5 12th Gen, 8GB RAM, 512GB SSD",
        "isFav": false
      },
      {
        "name": "Dell Inspiron 7430",
        "price": 130000,
        "specs": "14-inch display, Intel i7 13th Gen, 16GB RAM, 512GB SSD",
        "isFav": false
      },
      {
        "name": "Dell Latitude 15 3540",
        "price": 100000,
        "specs": "15.6-inch display, Intel i5 13th Gen, 8GB RAM, 512GB SSD",
        "isFav": false
      },
      {
        "name": "Dell Latitude 3540",
        "price": 95000,
        "specs": "15.6-inch display, Intel i5 12th Gen, 8GB RAM, 256GB SSD",
        "isFav": false
      },
      {
        "name": "Dell Vostro 3520",
        "price": 90000,
        "specs": "15.6-inch display, Intel i5 11th Gen, 8GB RAM, 512GB SSD",
        "isFav": false
      },
      {
        "name": "HP EliteBook 640",
        "price": 120000,
        "specs": "14-inch display, Intel i5 13th Gen, 16GB RAM, 512GB SSD",
        "isFav": false
      },
      {
        "name": "HP 15-FD0334 NIA",
        "price": 70000,
        "specs": "15.6-inch display, Intel i3 11th Gen, 8GB RAM, 256GB SSD",
        "isFav": false
      },
      {
        "name": "HP 15s EQ2322 AU",
        "price": 75000,
        "specs": "15.6-inch display, AMD Ryzen 5 5500U, 8GB RAM, 512GB SSD",
        "isFav": false
      },
      {
        "name": "Lenovo Ideapad 3",
        "price": 80000,
        "specs": "15.6-inch display, Intel i5 12th Gen, 8GB RAM, 512GB SSD",
        "isFav": false
      },
      {
        "name": "Lenovo Thinkpad E16",
        "price": 150000,
        "specs": "16-inch display, Intel i7 13th Gen, 16GB RAM, 1TB SSD",
        "isFav": false
      },
    ],

    /// For Buds
    [
      {
        "name": "Ronin R-520 Earbuds",
        "price": 4100,
        "specs": "Bluetooth 5.0, 4-hour battery, water-resistant",
        "isFav": false
      },
      {
        "name": "Ronin R-7020 Earbuds",
        "price": 6000,
        "specs": "Bluetooth 5.0, 5-hour battery, noise cancellation",
        "isFav": false
      },
      {
        "name": "Ronin R-7025 Earbuds",
        "price": 6200,
        "specs": "Bluetooth 5.0, 5-hour battery, water-resistant",
        "isFav": false
      },
      {
        "name": "Ronin R-1500 Headphone",
        "price": 3200,
        "specs": "Wired, over-ear, 40mm drivers",
        "isFav": false
      },
      {
        "name": "Ronin R-710 Earbuds",
        "price": 5000,
        "specs": "Bluetooth 5.0, 6-hour battery, sweat-proof",
        "isFav": false
      },
      {
        "name": "Ronin R-140 Earbuds",
        "price": 6000,
        "specs": "Bluetooth 5.0, 7-hour battery, noise cancellation",
        "isFav": false
      },
      {
        "name": "Ronin R-190 Earbuds",
        "price": 5000,
        "specs": "Bluetooth 5.0, 6-hour battery, water-resistant",
        "isFav": false
      },
      {
        "name": "Ronin R-540 Earbuds",
        "price": 4100,
        "specs": "Bluetooth 5.0, 4-hour battery, ergonomic fit",
        "isFav": false
      },
      {
        "name": "Ronin R-570 Earbuds",
        "price": 4500,
        "specs": "Bluetooth 5.0, 5-hour battery, noise cancellation",
        "isFav": false
      },
      {
        "name": "Ronin R-740 Earbuds",
        "price": 6200,
        "specs": "Bluetooth 5.0, 7-hour battery, water-resistant",
        "isFav": false
      },
    ],

    /// For Smart Watches
    [
      {
        "name": "Ronin R06 Smart Watch",
        "price": 4000,
        "specs": "1.3-inch display, heart rate monitor, IP67 rating",
        "isFav": false
      },
      {
        "name": "Ronin R08 Smart Watch",
        "price": 4500,
        "specs": "1.4-inch display, fitness tracking, water-resistant",
        "isFav": false
      },
      {
        "name": "Ronin R09 Smart Watch",
        "price": 6000,
        "specs": "1.4-inch display, heart rate monitor, Bluetooth calling",
        "isFav": false
      },
      {
        "name": "Ronin R02 Smart Watch",
        "price": 2000,
        "specs": "1.2-inch display, fitness tracking, IP67 rating",
        "isFav": false
      },
      {
        "name": "Ronin R04 Smart Watch",
        "price": 3000,
        "specs": "1.3-inch display, heart rate monitor, water-resistant",
        "isFav": false
      },
      {
        "name": "Ronin R010 Smart Watch",
        "price": 8000,
        "specs": "1.5-inch display, Bluetooth calling, IP68 rating",
        "isFav": false
      },
      {
        "name": "Ronin R012 Smart Watch",
        "price": 10000,
        "specs": "1.6-inch display, fitness tracking, Bluetooth calling",
        "isFav": false
      },
    ],
  ];

  ///This function add the items to list which is being shown according to the category inddex
  AddingItems() {
    showItemsList.clear();
    if (categoryIndex == 0) {
      for (int i = 0; i < itemsInfo.length; i++) {
        showItemsList.addAll(itemsInfo[i]);
      }
    } else {
      showItemsList.addAll(itemsInfo[categoryIndex - 1]);
    }
    notifyListeners();
  }

  ///This function change the currentIndex of bottom Nav
  int currentIndex = 0;
  onChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  ///For deleting items of favourites from favourite pages
  deleteFavItem(int index) {
    favItemSet.toList()[index]["isFav"] = false;
    favItemSet.remove(favItemSet.toList()[index]);
    notifyListeners();
  }

  ///For adding  and deleting items of favourites from HomePage Page

  favFunction1({required int index}) {
    if (filteredItems[index]["isFav"] == false) {
      filteredItems[index]["isFav"] = true;
      favItemSet.add(filteredItems[index]);
    } else {
      filteredItems[index]["isFav"] = false;
      favItemSet.remove(filteredItems[index]);
    }

    notifyListeners();
  }

  ///For adding and deleting items of favourites from item Page
  favFunction2(Map<String, dynamic> item) {
    if (item["isFav"] == false) {
      item["isFav"] = true;
      favItemSet.add(item);
    } else {
      item["isFav"] = false;
      favItemSet.remove(item);
    }
    notifyListeners();
  }
////////////////////////////////////////////////////////////////////
  ///Search bar Logic

  String query = "";

  List<Map<String, dynamic>> filteredItems = [];
  String searchQuery = '';

//Filter Function
  filterFunction(String query) {
    if (query.isNotEmpty) {
      searchQuery = query.toLowerCase();
      filteredItems = showItemsList.where((item) {
        return item["name"].toString().toLowerCase().contains(searchQuery);
      }).toList();
    } else {
      filteredItems = showItemsList;
    }
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////////
  ///Login Sign up functions and variables
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPassController = TextEditingController();

  Widget cusTomTextField(
      {controller,
      required String label,
      required IconData prefixIcon,
      required Icon suffixIcon,
      obsecure = false}) {
    return Container(
      width: 360,
      height: 47,
      child: TextField(
        controller: controller,
        obscureText: obsecure,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon,
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepPurple.shade300, width: 2),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepPurple.shade300, width: 2),
              borderRadius: BorderRadius.circular(12)),
          disabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.deepPurple.shade300, width: 2),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

///SocialButton Custom Widget Function Based
Widget socialButton({
  required imgPath,
}) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      child: Image.asset(imgPath),
      height: 46,
      width: 46,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(blurRadius: 5, spreadRadius: 0.5, offset: Offset(1, 2))
          ]),
    ),
  );
}
