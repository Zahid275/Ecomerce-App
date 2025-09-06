import 'package:ecomerce_application/Custom%20Widgets/favItem.dart';
import 'package:ecomerce_application/Models/favModel.dart';
import 'package:ecomerce_application/Pages/itemPage.dart';
import 'package:ecomerce_application/Provider/favProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favourite items",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: provider.getFavStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }else if(snapshot.data!.docs.isEmpty){
            return const Center(child: Text("No items in Favourites"),);
          }
          else {
            provider.favDocs  = snapshot.data!.docs;

            return ListView.builder(
              itemCount: provider.favDocs.length,
              itemBuilder: (context, index) {
                FavModel favModel = FavModel(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ItemPage(item: provider.favDocs[index]);
                        },
                      ),
                    );
                  },
                  color: provider.favDocs[index]["color"],
                  itemPrice: provider.favDocs[index]["price"],
                  imgPath: provider.favDocs[index]["imageUrl"],
                  itemName: '${provider.favDocs[index]["name"]}',
                  deleteItem: () {
                    provider.deleteFav(provider.favDocs[index]["name"],context: context);
                  },
                );

                return FavItem(favModel);
              },
            );
          }
        },
      ),
    );
  }
}
