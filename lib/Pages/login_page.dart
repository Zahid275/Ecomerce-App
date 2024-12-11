import 'package:ecomerce_app/Provider/provider.dart';
import 'package:ecomerce_app/Pages/signUp_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = context.read<itemProvider>();
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                  width: 250,
                  height: 100,
                  child: Image.asset("assets/logo/logo_withoutBack.png")),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Sign in",
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
                provider.cusTomTextField(controller: provider.nameController,label: "Username", prefixIcon: Icons.person_outline, suffixIcon: Icon(null)),

                  SizedBox(
                    height: 30,
                  ),
                  provider.cusTomTextField(controller: provider.passController,label: "Password", prefixIcon: Icons.lock_outline, suffixIcon: Icon(Icons.remove_red_eye_outlined)),


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
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: ElevatedButton(
                          onPressed: () {

                            if(provider.nameController.text.toString().isNotEmpty && provider.passController.text.toString().isNotEmpty){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please write all the required credentials")));
                            }
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 5,
                              backgroundColor: Colors.deepPurple.shade300),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Or sign in With",
                      style: TextStyle(
                          color: Colors.deepPurple.shade300,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      socialButton(
                          imgPath: "assets/logo/socialLogos/google.png"),
                      SizedBox(
                        width: 20,
                      ),
                      socialButton(imgPath: "assets/logo/socialLogos/fb.png"),
                      SizedBox(
                        width: 20,
                      ),
                      socialButton(
                          imgPath: "assets/logo/socialLogos/twitter.png"),
                      SizedBox(
                        width: 20,
                      ),
                      socialButton(imgPath: "assets/logo/socialLogos/in.png"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Sign_Up();
                      }));
                    },
                    child: Text(
                      "Don't have an Account? Sign Up",
                      style: TextStyle(
                          color: Colors.deepPurple.shade300,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
