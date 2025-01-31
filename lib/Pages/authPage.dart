import 'package:ecomerce_app/Custom%20Widgets/customTextField.dart';
import 'package:ecomerce_app/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ItemProvider>();
    final listener = context.watch<ItemProvider>();
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                  width: 250,
                  height: 100,
                  child: Image.asset("assets/logo/logo_withoutBack.png")),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: provider.isSignUp
                    ? const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.deepPurple),
                      )
                    : const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.deepPurple),
                      )),
            const SizedBox(
              height: 26,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  provider.isSignUp
                      ? cusTomTextField(
                          onChanged: (value) {
                            provider.name = value.toString();
                          },
                          label: "Username",
                          prefixIcon: Icons.person_outline,
                  )
                      :
                  Container(),
                  provider.isSignUp
                      ? const SizedBox(
                          height: 20,
                        )
                      : const SizedBox(),
                  cusTomTextField(
                      onChanged: (value) {
                        provider.email = value.toString();
                      },
                      label: "Email",
                      prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  cusTomTextField(
                    obsecure: provider.obsecureTextPass,
                      onChanged: (value) {
                        provider.password = value.toString();
                      },
                      label: "Password",
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(onPressed: (){
                        listener.togglePassIcon();
                      },
                          icon: provider.obsecureTextPass ?const Icon(Icons.remove_red_eye):const Icon(Icons.remove_red_eye_outlined)


                      )
                      ),
                  provider.isSignUp
                      ? const SizedBox(
                          height: 20,
                        )
                      : const SizedBox(),
                  provider.isSignUp
                      ? cusTomTextField(
                    obsecure: listener.obsecureTextCon,
                          onChanged: (value) {
                            provider.confirmPass = value.toString();
                          },
                          label: "Confirm Password",
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(onPressed: (){
                            listener.toggleConfirmPassIcon();
                          },
                              icon: provider.obsecureTextCon ?const Icon(Icons.remove_red_eye):const Icon(Icons.remove_red_eye_outlined)


                          ))
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  provider.isSignUp
                      ? cusTomTextField(
                          onChanged: (value) {
                            provider.phoneNO = value.toString();
                          },
                          label: "Phone No",
                          prefixIcon: Icons.person_outline,
                  )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  provider.isSignUp
                      ? cusTomTextField(
                          onChanged: (value) {
                            provider.address = value.toString();
                          },
                          label: "Address",
                          prefixIcon: Icons.person_outline,
                  )
                      : Container(),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 10),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forget Password",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.deepPurple.shade500),
                        ),
                      ),
                    )
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: provider.isSignUp
                              ? ElevatedButton(
                                  onPressed: () {
                                    provider.signUp(
                                        address: provider.address.toString(),
                                        phoneNo: provider.phoneNO.toString(),
                                        context: context,
                                        name: provider.name.toString(),
                                        confirmPass:
                                            provider.confirmPass.toString(),
                                        email: provider.email.toString(),
                                        password: provider.password.toString());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 5,
                                      backgroundColor:
                                          Colors.deepPurple.shade300),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.white),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    provider.signIn(
                                        password: provider.password.toString(),
                                        email: provider.email.toString(),
                                        context: context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 5,
                                      backgroundColor:
                                          Colors.deepPurple.shade300),
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.white),
                                  )))),
                  const SizedBox(
                    height: 20,
                  ),
                  provider.isSignUp == false
                      ? TextButton(
                          onPressed: () {},
                          child: Text(
                            "Or sign in With",
                            style: TextStyle(
                                color: Colors.deepPurple.shade300,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  provider.isSignUp == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            provider.socialButton(
                                imgPath: "assets/logo/socialLogos/google.png"),
                            const SizedBox(
                              width: 20,
                            ),
                            provider.socialButton(
                                imgPath: "assets/logo/socialLogos/fb.png"),
                            const SizedBox(
                              width: 20,
                            ),
                            provider.socialButton(
                                imgPath: "assets/logo/socialLogos/twitter.png"),
                            const SizedBox(
                              width: 20,
                            ),
                            provider.socialButton(
                                imgPath: "assets/logo/socialLogos/in.png"),
                          ],
                        )
                      : Container(),
                  TextButton(
                      onPressed: () {
                        listener.toggleSignUp();
                      },
                      child: provider.isSignUp
                          ? Text(
                              "Already have an account! Sign in",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade300,
                                  fontWeight: FontWeight.w700),
                            )
                          : Text(
                              "Dont't have an account! Sign Up",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade300,
                                  fontWeight: FontWeight.w700),
                            )),
                  listener.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Container()
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
//
