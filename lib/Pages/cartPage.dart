import 'package:ecomerce_application/Models/cartModel.dart';
import 'package:ecomerce_application/Pages/itemPage.dart';
import 'package:ecomerce_application/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Custom Widgets/cartItem.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<ItemProvider>();
    final provider = context.read<ItemProvider>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cart items",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            stream: provider.cartStream,
            builder: (context, snapshot) {
              provider.getCartStream();
              listener.getCartDocs(snapshot);

        if (provider.cartDocs.isEmpty) {
                return const Center(child: Text("Not items in cart"));
              } else {
                return Column(children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: provider.cartDocs.length,
                        itemBuilder: (context, index) {


                          CartModel cartModel = CartModel(
                              onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return ItemPage(item: provider.cartDocs[index]);
                                }));},
                              color: provider.cartDocs[index]["color"],
                              itemPrice: provider.cartDocs[index]["price"],
                              imgPath: provider.cartDocs[index]["imageUrl"],
                              quantity: provider.cartDocs[index]["quantity"],
                              itemName: '${provider.cartDocs[index]["name"]}',
                              deleteItem: () {
                                listener.deleterCartItem(index);
                              },
                          );
                          return CartItem(cartModel: cartModel);

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
                              Text("${provider.totalPriceCalculate()} Rs",
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Your products are being processed and will be delivered to you soon")));
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
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
                ]);
              }
            }));
  }
}
