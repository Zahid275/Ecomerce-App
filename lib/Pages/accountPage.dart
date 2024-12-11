import 'package:ecomerce_app/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<itemProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Account",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.deepPurple),),centerTitle: true,automaticallyImplyLeading: false,),
      body: Padding(

        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: CircleAvatar(
                  child: Icon(Icons.person,size: 200,),

                ),
              ),
            ),
            SizedBox(height: 10,),

            Text("Edit Image",style: TextStyle(fontSize: 25,fontWeight:FontWeight.w700,color: Colors.deepPurple.shade900)),
            SizedBox(height: 40,),


            Row(
              children: [
                Text("Name :  ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.deepPurple.shade900),),
                Text("${provider.nameController.text.toString()}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.deepPurpleAccent),),
              ],
            ),
            Row(
              children: [
                Text("Password :  ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.deepPurple.shade900),),
                Text("${provider.passController.text.toString()}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.deepPurpleAccent),),
              ],
            ),

            SizedBox(height: 30,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    TextButton(onPressed: (){}, child: Text("Change Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                    TextButton(onPressed: (){}, child: Text("Change Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)),
                  ],
                ),

              ],
            )
          ],

        ),
      ),
    );
  }
}
