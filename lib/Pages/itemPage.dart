import 'package:ecomerce_app/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Itempage extends StatelessWidget {
  final Map<String, dynamic> item;

  const Itempage({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    final provider = context.read<itemProvider>();
    final listener = context.watch<itemProvider>();

    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade200, borderRadius: BorderRadius.circular(40)),
          height: 70,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 45,

                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5,color: Colors.white),
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(22)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove,
                          size: 27,color: Colors.white,
                        ),
                        onPressed: () {
                          listener.decrementQuantity();
                        }
                      ),
                      Text(
                        "${listener.quantity}",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500,color: Colors.white),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 27,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          listener.incrementQuantity();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 7,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(duration : const Duration(milliseconds: 700 ),content: Text("${provider.quantity} ${item["name"]} ${provider.quantity ==1 ?"has been":"have been"} added to your cart")));

                    provider.addToCart(item);///This function adds items to cart items

                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: 150,
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(22)),
                    child: const Center(
                        child: Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      "assets/home/${item["name"].toLowerCase()}.png")),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(22),
                      topLeft: Radius.circular(22))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["name"],
                        style: GoogleFonts.gelasio(
                            fontWeight: FontWeight.w700, fontSize: 26),
                      ),
                      Text(
                        "Price : ${item["price"]}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.purple.shade300,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    "4.5",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              "Seller Name",
                              style: GoogleFonts.gelasio(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Colors :",
                            style: GoogleFonts.gelasio(
                                fontSize: 28, fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                            onPressed: (){
                             listener.favFunction2(item);

                            },
                            icon: Icon(
                              item["isFav"] ? Icons.favorite:Icons.favorite_outline_outlined, color:item["isFav"] ?Colors.red:Colors.black,
                              size: 38,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        width: 400,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                (provider.changeColor(index: index));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3,
                                        color: provider.borderColors[index]),
                                    shape: BoxShape.circle),
                                child: CircleAvatar(
                                  backgroundColor: provider.colors[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Specifications :",
                        style: GoogleFonts.gelasio(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                      Container(
                        child: Text(
                          item["specs"],
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
