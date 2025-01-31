import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Item extends StatelessWidget {
  final String? imgPath;
  final String? itemName;
  final int? itemPrice;
  final void Function()? onTap;
  final void Function()? onTapFav;
  final Icon favIcon;

  const Item(
      {super.key,
      required this.favIcon,
      required this.onTapFav,
      required this.imgPath,
      required this.itemName,
      required this.itemPrice,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
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
                                "$imgPath",
                              ),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                      child: Column(
                        children: [
                          Text("$itemName",
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
                          Text("$itemPrice Rs",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                          IconButton(
                            onPressed: onTapFav,
                            icon: favIcon,
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
