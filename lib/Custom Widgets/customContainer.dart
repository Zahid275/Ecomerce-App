import 'package:flutter/material.dart';

Widget customContainer({required text}){
 return  Padding(
   padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
   child: Container(
      height: 60,width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurpleAccent.shade200,width: 2),
          borderRadius: BorderRadius.circular(30)
      ),

      child: Center(child: Text("$text",style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w700),)),
    ),
 );
}