import 'package:ecomerce_app/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Custom Widgets/cartItem.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<itemProvider>();
    final provider = context.read<itemProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Cart items",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w700,),),
        automaticallyImplyLeading: false,

      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: provider.cartItemList.length,
                itemBuilder: (context, index) {
                  return Cartitem(
                    color: provider.cartItemList[index]["color"],
                    itemPrice: provider.cartItemList[index]["price"],
                    imgPath:
                        "assets/home/${provider.cartItemList[index]["name"].toString().toLowerCase()}.png",
                    quantity: provider.cartItemList[index]["quantity"],
                    ItemName: '${provider.cartItemList[index]["name"]}',
                    deleteItem: () {
                      listener.deleteCartItem(index);
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(22),
                      topLeft: Radius.circular(22))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      Text("${provider.TotalPrice()} Rs",
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Your products are being processed and will be delivered to you soon")));
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade300,
                            borderRadius: BorderRadius.circular(22)),
                        width: double.infinity,
                        height: 50,
                        child: const Center(
                            child: Text(
                          "Check Out",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
