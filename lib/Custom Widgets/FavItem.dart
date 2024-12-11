import 'package:flutter/material.dart';

class FavItem extends StatelessWidget {
  String imgPath;
  String itemName;
  int itemPrice;

  void Function()? deleteItem;

  FavItem({super.key,required this.imgPath,required this.itemName,
    required this.deleteItem,required this.itemPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20,vertical: 15),
      child: Container(
        height: 125,
        width: double.infinity,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(22),
          boxShadow: const [BoxShadow(
              offset: Offset(5, 5),
              blurRadius: 2,spreadRadius: 1,color: Colors.black54)],
          color:Colors.deepPurple[100 ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: double.infinity,
              width:120,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image(
                  image: AssetImage(imgPath),
                  fit: BoxFit.fill
                  ,),
              ),
            ),

            Container(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(itemName,style:  TextStyle(fontSize: 23,fontWeight: FontWeight.w700,color: Colors.purple.shade300),),
                      Text("Price: $itemPrice",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black54),)
                    ],
                  ),
                ),
              ),
            ),

            Container(child: IconButton(
               onPressed: deleteItem
              ,icon: Icon(Icons.delete,size: 35,color: Colors.pink[200],),),)
          ],


        ),
      ),
    );
  }
}
