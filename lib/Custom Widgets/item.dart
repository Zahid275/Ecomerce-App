import 'package:ecomerce_application/Models/itemModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Item extends StatelessWidget {
  ItemModel itemModel;

  Item({required this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: itemModel.onTap,
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4, spreadRadius: 0, offset: Offset(1, 1))
                    ],
                    border: Border.all(width: 0.2),
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12)),
                height: 260,
                width: 184,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: 185,
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          image: DecorationImage(
                              image: NetworkImage(
                                "${itemModel.imgPath}",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Column(
                        children: [
                          Text("${itemModel.itemName}",
                              style: GoogleFonts.gelasio(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 4.0, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${itemModel.itemPrice} Rs",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          IconButton(
                            onPressed: itemModel.onTapFav,
                            icon: itemModel.favIcon,
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
