import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String imgPath;
  final String itemName;
  final int itemPrice;
  final int quantity;
  final void Function()? deleteItem;
  final void Function()? onTap;

  final String color;

  const CartItem(
      {super.key,
      required this.onTap,
      required this.color,
      required this.quantity,
      required this.imgPath,
      required this.itemName,
      required this.itemPrice,
      required this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          height: 157,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(5, 5),
                  blurRadius: 2,
                  spreadRadius: 1,
                  color: Colors.black54)
            ],
            color: Colors.deepPurple.shade100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: double.infinity,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image(
                    image: NetworkImage(imgPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemName,
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.purple),
                          ),
                          Text(
                            "$itemPrice Rs",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                          Text(
                            "Quantity: $quantity",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                          Text(
                            "Color: $color",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: deleteItem,
                      icon: Icon(
                        Icons.delete,
                        size: 35,
                        color: Colors.pink[200],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
