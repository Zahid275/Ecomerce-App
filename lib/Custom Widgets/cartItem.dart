import 'package:flutter/material.dart';

import '../Models/cartModel.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;

  const CartItem({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: cartModel.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
        child: Container(
          height: screenHeight * 0.16,
          width: screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Colors.black54)
            ],
            color: Colors.deepPurple.shade100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight,
                width: screenWidth * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image(
                    image: NetworkImage(cartModel.imgPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(width: screenWidth*0.02,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cartModel.itemName,
                            style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.w700,
                                color: Colors.purple),
                          ),
                          Text(
                            "${cartModel.itemPrice} Rs",
                            style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                          Text(
                            "Quantity: ${cartModel.quantity}",
                            style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                          Text(
                            "Color: ${cartModel.color}",
                            style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: cartModel.deleteItem,
                      icon: Icon(
                        Icons.delete,
                        size: screenWidth * 0.1,
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
