class FavModel {

  final String imgPath;
  final String itemName;
  final num itemPrice;
  final String color;
  final void Function()? deleteItem;
  final void Function()? onTap;


  FavModel(
      {required this.imgPath, required this.itemName, required this.itemPrice, required this.color, required this.deleteItem, required this.onTap});


}