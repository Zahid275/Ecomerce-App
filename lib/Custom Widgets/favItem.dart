import 'package:flutter/material.dart';

import '../Models/favModel.dart';

class FavItem extends StatelessWidget {
  FavModel favModel;

  FavItem(this.favModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: favModel.onTap,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: screenWidth*0.05, vertical: screenHeight*0.014),
        child: Container(
          height: screenHeight*0.15,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  color: Colors.black54)
            ],
            color: Colors.deepPurple[100],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: double.infinity,
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: Image(
                    image: NetworkImage(favModel.imgPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        favModel.itemName,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                            color: Colors.purple.shade300),
                      ),
                      Text(
                        "Price: ${favModel.itemPrice}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                      Text(
                        "Color: ${favModel.color}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: favModel.deleteItem,
                icon: Icon(
                  Icons.delete,
                  size: 35,
                  color: Colors.pink[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
