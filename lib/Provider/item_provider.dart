import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
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
}
