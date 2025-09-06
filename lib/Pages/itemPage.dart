import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_application/Provider/cart_provider.dart';
import 'package:ecomerce_application/Provider/favProvider.dart';
import 'package:ecomerce_application/Provider/item_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  final QueryDocumentSnapshot item;

  const ItemPage({super.key, required this.item});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ItemProvider>(context, listen: false);
      provider.changeColor(index: 0);
      provider.quantity = 1;

    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ItemProvider>(context, listen: false);
    print("Hello");

    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade200,
            borderRadius: BorderRadius.circular(40),
          ),
          height: screenHeight * 0.1, // Adjust height based on screen size
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  height: screenHeight * 0.06,
                  // Adjust height based on screen size
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.5, color: Colors.white),
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove,
                          size: 27,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          provider.quantityDec();
                        },
                      ),
                      Consumer<ItemProvider>(
                        builder: (context, listener, child) {
                          return Text(
                            "${listener.quantity}",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 27,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          provider.quantityInc();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 7,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 700),
                        content: Text(
                          "${provider.quantity} ${widget.item["name"]} ${provider.quantity == 1 ? "has been" : "have been"} added to your cart",
                        ),
                      ),
                    );

                    Provider.of<CartProvider>(context, listen: false).addToCart(
                      item: widget.item,
                      quantity: provider.quantity,
                      selectedColor: provider.selectedColor,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: screenWidth * 0.03),
                    width: screenWidth * 0.4,
                    // Adjust width based on screen size
                    height: screenHeight * 0.07,
                    // Adjust height based on screen size
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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
              height: screenHeight * 0.3,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.white),
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(widget.item["imageUrl"]),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(22),
                  topLeft: Radius.circular(22),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.036,
                  top: screenHeight * 0.018,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item["name"],
                        style: GoogleFonts.gelasio(
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Price : ${widget.item["price"]}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.07),
                            child: IconButton(
                                  onPressed: () {
                                    Provider.of<FavProvider>(context,listen: false).favToggle(
                                      widget.item,
                                      selectedColor: provider.selectedColor,
                                    );
                                  },
                                  icon: Consumer<FavProvider>(
                        builder: (context,favListener,child){
                                    return Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color:
                                          favListener.checkFav(widget.item)
                                              ? Colors.red
                                              : Colors.grey,
                                    );}
                                  ),

                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: screenHeight * 0.039,
                        width: screenWidth * 0.17,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.white),
                            SizedBox(width: 7),
                            Text(
                              "4.5",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Colors :",
                            style: GoogleFonts.gelasio(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.08,
                        width: screenWidth * 0.9,
                        // Adjust width based on screen size
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                provider.changeColor(index: index);
                              },
                              child: Consumer<ItemProvider>(
                                builder: (context, listener, child) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: listener.borderColors[index],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: provider.colors[index],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        "Specifications :",
                        style: GoogleFonts.gelasio(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.item["specs"],
                        style: const TextStyle(fontSize: 20),
                      ),
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
