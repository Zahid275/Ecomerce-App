import 'package:ecomerce_application/Models/itemModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Item extends StatelessWidget {
  ItemModel itemModel;

  Item({super.key, required this.itemModel});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: itemModel.onTap,
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius:1 ,
              color: Colors.white24
              )
            ],
              border: Border.all(width: 0.2),
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: maxHeight*0.155,
                width: double.infinity,
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
                padding:  EdgeInsets.only(top: maxHeight*0.02, left: maxWidth*0.02),
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
                padding:  EdgeInsets.only(
                    left: maxWidth*0.02, right: maxWidth*0.03, bottom: 0),
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
    );
  }
}
