import 'package:ecomerce_app/home.dart';
import 'package:ecomerce_app/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sign_Up extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final provider = context.read<itemProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("") ),
      body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.deepPurple),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 20,),
                      provider.cusTomTextField(controller: provider.nameController ,label: "Full Name", prefixIcon: Icons.person_outline, suffixIcon: Icon(null)),
                      SizedBox(height: 20,),
                      provider.cusTomTextField(controller : provider.emailController,label: "Email ", prefixIcon: Icons.email_outlined, suffixIcon: Icon(null)),
                      SizedBox(height: 20,),
                      provider.cusTomTextField(controller: provider.passController,label: "Password", prefixIcon: Icons.lock_outline_rounded, suffixIcon: Icon(Icons.remove_red_eye_outlined),obsecure: true),
                      SizedBox(height: 20,),
                      provider.cusTomTextField(controller: provider.confirmPassController,label: "Confirm Password", prefixIcon: Icons.lock_outline, suffixIcon: Icon(Icons.remove_red_eye_outlined),obsecure: true),


                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0, top: 20),
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.deepPurple.shade500),
                          ),
                        )
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50.0),
                            child: ElevatedButton(
                              onPressed: () {

                                if(
                                provider.nameController.text.toString().isNotEmpty
                                &&
                                provider.passController.text.toString().isNotEmpty
                                &&
                                provider.emailController.text.toString().isNotEmpty
                                &&
                                provider.confirmPassController.text.toString() == provider.passController.text.toString()



                                ){
                                Navigator.pushReplacement(  context, MaterialPageRoute(builder: (context){
                                  return Home(); }));}else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please write all the required credentials correctly ")));
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 5,
                                  backgroundColor: Colors.deepPurple.shade300),
                            ),
                          )),
                     SizedBox(height: 100,),
                      TextButton(
                        onPressed: () {},

                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account? ",
                                style: TextStyle(
                                    color: Colors.deepPurple.shade300,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text("Sign In",
                                style: TextStyle(
                                    color: Colors.deepPurple.shade300,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),),
                      SizedBox(height: 20,),

                    ],
                  ),
                ),
              ],
            ),
          )
    );
  }


}

