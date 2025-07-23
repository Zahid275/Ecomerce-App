class CartModel {
  final String imgPath;
  final String itemName;
  final int itemPrice;
  final int quantity;
  final void Function()? deleteItem;
  final void Function()? onTap;

  final String color;

  const CartModel(
      {
        required this.onTap,
        required this.color,
        required this.quantity,
        required this.imgPath,
        required this.itemName,
        required this.itemPrice,
        required this.deleteItem});
}