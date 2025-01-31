import 'package:flutter/material.dart';

class FavItem extends StatelessWidget {
  final String  imgPath;
  final String itemName;
  final num itemPrice;
  final String color;

  final void Function()? deleteItem;
 final  void Function()? onTap;

  const FavItem({super.key,required this.imgPath,required this.itemName,
    required this.deleteItem,required this.itemPrice,required this.color,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
        onTap,

      child: Padding(
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
                    image: NetworkImage(imgPath),
                    fit: BoxFit.fill
                    ,),
                ),
              ),

               Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(itemName,style:  TextStyle(fontSize: 23,fontWeight: FontWeight.w700,color: Colors.purple.shade300),),
                        Text("Price: $itemPrice",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black54),),
                        Text("Color: $color",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black54),)

                      ],
                    ),
                  ),
                ),

           IconButton(
                 onPressed: deleteItem
                ,icon: Icon(Icons.delete,size: 35,color: Colors.pink[200],),),
            ],


          ),
        ),
      ),
    );
  }
}
