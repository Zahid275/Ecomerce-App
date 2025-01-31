import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce_app/Custom%20Widgets/categoryIcons.dart';
import 'package:ecomerce_app/Pages/itemPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Custom Widgets/item.dart';
import '../Provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ItemProvider>();
    final listener = context.watch<ItemProvider>();

    provider.getStream();
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
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    elevation: 2,
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextField(
                          onChanged: (value) {
                            provider.query = value;
                            // provider.filterFunction(provider.query.toString());
                          },
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {},
                            ),
                            hintText: "Search ",
                            hintStyle: const TextStyle(
                                fontSize: 20, color: Colors.grey),
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
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(),
                        child:
                            Image.asset(item, fit: BoxFit.fill, width: 1000.0),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 18 / 9,
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 10),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(22)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
                  ),
                ),
                SizedBox(
                  height: 100,
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
                      provider.getDocs(snapshot);

                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: provider.docs!.length,
                          itemBuilder: (context, index) {
                            listener.checkFav(provider.docs![index]);
                            return Item(
                                favIcon:
                                    provider.checkFav(provider.docs![index])
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
                                  listener.favToggle(provider.docs![index]);
                                },
                                onTap: () {
                                  provider.changeColor(index: 0);
                                  provider.selectedColor = "White";

                                  provider.quantity = 1;
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Itempage(
                                        item: provider.docs![index]);
                                  }));
                                },
                                itemPrice: provider.docs![index]["price"],
                                itemName: provider.docs![index]["name"],
                                imgPath: provider.docs![index]["imageUrl"]);
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 165 / 230,
                          ),
                        );
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
