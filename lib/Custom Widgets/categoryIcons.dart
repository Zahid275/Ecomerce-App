import 'package:flutter/material.dart';

class Categoryicons extends StatelessWidget {

  String imgPath;
  void Function()? onTap;
  Color backColor;
  Categoryicons({super.key, required this.imgPath,required this.onTap,required this.backColor});
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
              width: 80,
              height: 80,

              child: CircleAvatar(
                backgroundColor: Colors.white,
              backgroundImage: Image(image: AssetImage(imgPath),).image
          ),
          ),
        ),
        const SizedBox(height: 5,),
        Container(width: 50,height: 2.5,color: backColor)
      ],
    );
  }
}