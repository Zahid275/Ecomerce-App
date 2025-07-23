import 'package:ecomerce_application/Custom%20Widgets/favItem.dart';
import 'package:ecomerce_application/Models/favModel.dart';
import 'package:ecomerce_application/Pages/itemPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listener = context.watch<ItemProvider>();
    final provider = context.read<ItemProvider>();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Favourite items",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: StreamBuilder(
            stream: provider.favStream,
            builder: (context, snapshot) {
              provider.getFavStream();
              listener.getFavDocs(snapshot);

              if (provider.favDocs.isEmpty) {
                return const Center(child: Text("Not items in Favourites"));
              } else {
                return ListView.builder(
                    itemCount: provider.favDocs.length,
                    itemBuilder: (context, index) {
                      FavModel favModel = FavModel(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ItemPage(item: provider.favDocs[index]);
                          }));
                        },
                        color: provider.selectedColor,
                        itemPrice: provider.favDocs[index]["price"],
                        imgPath: provider.favDocs[index]["imageUrl"],
                        itemName: '${provider.favDocs[index]["name"]}',
                        deleteItem: () {
                          listener.deleteFav(index);
                        },
                      );

                      return FavItem(favModel);
                    });
              }
            }));
  }
}
