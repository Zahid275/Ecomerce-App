import 'package:flutter/material.dart';

class ItemModel {  final String? imgPath;
final String? itemName;
final int? itemPrice;
final void Function()? onTap;
final void Function()? onTapFav;
final Icon favIcon;

const ItemModel(
    {
      required this.favIcon,
      required this.onTapFav,
      required this.imgPath,
      required this.itemName,
      required this.itemPrice,
      required this.onTap});}