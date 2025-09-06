import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce_application/Provider/favProvider.dart';
import 'package:ecomerce_application/Provider/homepage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Custom Widgets/categoryIcons.dart';
import '../Custom Widgets/item.dart';
import '../Models/itemModel.dart';
import 'itemPage.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePage_Provider>(context, listen: false);
    double maxWidth = MediaQuery
        .of(context)
        .size
        .width;
    double maxHeight = MediaQuery
        .of(context)
        .size
        .height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(22),
                bottomRight: Radius.circular(13),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: maxHeight * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.04),
                  child: Card(
                    elevation: 2,
                    child: SizedBox(
                      width: double.infinity,
                      height: maxHeight * 0.06,
                      child: TextField(
                        onChanged: (value) {
                          provider.querry = value;
                          provider.filterItems(provider.querry);
                        },
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            fontSize: maxWidth * 0.05,
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                CarouselSlider(
                  items:
                  provider.posters.map((item) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: maxHeight * 0.013,
                      ),
                      width: double.infinity,
                      child: Image.asset(item, fit: BoxFit.fill),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: maxWidth / maxHeight * 3.5,
                    enlargeCenterPage: true,
                    autoPlayInterval: const Duration(seconds: 5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: maxHeight * 0.025),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: maxHeight * 0.012,
                    horizontal: maxWidth * 0.05,
                  ),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: maxWidth * 0.07,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.catIcons.length,
                    itemBuilder: (context, index) {
                      return Consumer<HomePage_Provider>(
                        builder: (context, listener, child) {
                          return CategoryIcons(
                            backColor:
                            listener.categoryIndex == index
                                ? Colors.purple.shade300
                                : Colors.white,
                            imgPath: provider.catIcons[index],
                            onTap: () {
                              provider.filterByCategory(index);

                              provider.upCatIndex(index);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                Consumer<HomePage_Provider>(
                  builder: (context, listener, child) {
                    if (provider.docs == null || provider.docs!.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.filteredItems!.length,
                      itemBuilder: (context, index) {
                        final favProvider = Provider.of<FavProvider>(
                          context,
                          listen: false,
                        );

                        ItemModel itemModel = ItemModel(
                            favIcon:
                            Consumer<FavProvider>(
                              builder: (context, favListener, child) {
                                final isFav = favListener.checkFav(provider.filteredItems![index]);
                                return Icon(
                                  isFav ? Icons.favorite : Icons.favorite_outline,
                                  color: isFav ? Colors.red : Colors.black,
                                  size: 30,
                                );
                              },
                            ),


                            onTapFav: ()
                        {
                          favProvider.favToggle(
                            selectedColor: "White",
                            provider.filteredItems![index],
                          );
                        },
                        onTap: () {
                        Navigator.of(context).push(
                        MaterialPageRoute(
                        builder:
                        (context) => ItemPage(
                        item: provider.filteredItems![index],
                        ),
                        ),
                        );
                        },
                        itemPrice: provider.filteredItems![index]["price"],
                        itemName: provider.filteredItems![index]["name"],
                        imgPath: provider.filteredItems![index]["imageUrl"],
                        );
                        return Padding(
                        padding: EdgeInsets.symmetric(
                        horizontal: maxWidth * 0.02,
                        ),
                        child: Consumer<FavProvider>(
                        builder: (context, _, child) {
                        return Item(itemModel: itemModel);
                        },
                        )
                        ,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: maxWidth * 0.03,
                        mainAxisSpacing: maxHeight * 0.03,
                        childAspectRatio: maxWidth / 2 / (maxHeight * 0.33),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
