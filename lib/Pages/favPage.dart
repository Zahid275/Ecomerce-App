import 'package:ecomerce_app/Custom%20Widgets/FavItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<itemProvider>();
    final provider = context.read<itemProvider>();

    return Scaffold(
        appBar: AppBar(title: Text("Favourite items",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w700,),),
        automaticallyImplyLeading: false,
        ),
    body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      provider.favItemSet.toList().isNotEmpty
          ? Expanded(
              child: ListView.builder(
                  itemCount: provider.favItemSet.length,
                  itemBuilder: (context, index) {
                    return FavItem(
                      itemPrice: provider.favItemSet.toList()[index]["price"],
                      imgPath:
                          "assets/home/${provider.favItemSet.toList()[index]["name"].toString().toLowerCase()}.png",
                      itemName:
                          '${provider.favItemSet.toList()[index]["name"]}',
                      deleteItem: () {
                        listener.deleteFavItem(index);
                      },
                    );
                  }),
            )
          : Center(
              child: Text(
              "No items have been added to favourites",
              style: TextStyle(fontSize: 1),
            ))
    ]));
  }
}
