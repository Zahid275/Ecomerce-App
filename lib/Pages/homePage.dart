import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Custom Widgets/categoryIcons.dart';
import '../Custom Widgets/item.dart';
import '../Models/itemModel.dart';
import '../Provider/provider.dart';
import 'itemPage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ItemProvider>();
    final listener = context.watch<ItemProvider>();

    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(13))),
            child: Column(
              children: [
                SizedBox(
                  height: maxHeight * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.04),
                  child: Card(
                    elevation: 2,
                    child: SizedBox(
                        width: double.infinity,
                        height: maxHeight * 0.06,
                        child: TextField(
                          onChanged: (value) {
                            listener.querry =value;
                            listener.filterItems(listener.querry);

                          },
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                fontSize: maxWidth * 0.05, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none),
                          ),
                        )),
                  ),
                ),
                CarouselSlider(
                    items: provider.posters.map((item) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: maxHeight * 0.013,
                        ),
                        width: double.infinity,
                        child:
                        Image.asset(item, fit: BoxFit.fill),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 17 /9,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 5),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * 0.025,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(22)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: maxHeight * 0.012,
                      horizontal: maxWidth * 0.05),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: maxWidth * 0.07),
                  ),
                ),
                SizedBox(
                  height: maxHeight * 0.12,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.catIcons.length,
                    itemBuilder: (context, index) {
                      return CategoryIcons(
                          backColor: provider.categoryIndex == index
                              ? Colors.purple.shade300
                              : Colors.white,
                          imgPath: provider.catIcons[index],
                          onTap: () {
                            listener.upCatIndex(index);
                          });
                    },
                  ),
                ),
                StreamBuilder(
                    stream: provider.getStream(),
                    builder: (context, snapshot) {
                      provider.getStream();
                      listener.getDocs(snapshot);


                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,

                        itemCount: provider.filteredItems!.length,
                        itemBuilder: (context, index) {
                          listener.checkFav(provider.filteredItems![index]);

                          ItemModel itemModel = ItemModel(
                              favIcon: provider.checkFav(provider.filteredItems![index])
                                  ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              )
                                  : const Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                                size: 30,
                              ),
                              onTapFav: () {
                                listener.favToggle(provider.filteredItems![index]);
                              },
                              onTap: () {
                                provider.changeColor(index: 0);
                                provider.selectedColor = "White";

                                provider.quantity = 1;
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return ItemPage(item: provider.filteredItems![index]);
                                    }));
                              },
                              itemPrice: provider.filteredItems![index]["price"],
                              itemName: provider.filteredItems![index]["name"],
                              imgPath: provider.filteredItems![index]["imageUrl"]
                          );
                          return Item(itemModel: itemModel);
                        },
                        gridDelegate:
                         SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
crossAxisSpacing: 3,
mainAxisSpacing: 3,                          childAspectRatio: maxWidth*0.04  / maxHeight/0.030,
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
