import 'package:flutter/material.dart';

Widget customContainer({required text,required context}){
  final size = MediaQuery.of(context).size;
 return  Padding(
   padding:  EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.01),
   child: Container(
      height: size.height*0.067,width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurpleAccent.shade200,width: 2),
          borderRadius: BorderRadius.circular(30)
      ),

      child: Center(child: Text("$text",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
    ),
 );
}