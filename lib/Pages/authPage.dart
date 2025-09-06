import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Custom Widgets/customTextField.dart';
import '../Provider/auth_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authentication_Provider>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.15,
                  child: Image.asset("assets/logo/logo_withoutBack.png"),
                ),
              ),

              Center(
                child: Consumer<Authentication_Provider>(
                  builder: (context, listener, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding:  EdgeInsets.only(left: size.width*0.03,bottom: size.height*0.019),
                          child: Text(
                            listener.isSignUp ? "Sign Up" : "Sign In",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      provider.isSignUp ?  CustomTextfield(
                          onChanged: (value) => provider.name = value,
                          label: "Username",
                          prefixIcon: Icons.person_outline,
                        ):const SizedBox(),
                        SizedBox(height: size.height * 0.01),
                        CustomTextfield(
                          onChanged: (value) => provider.email = value,
                          label: "Email",
                          prefixIcon: Icons.email_outlined,
                        ),
                        SizedBox(height: size.height * 0.01),
                        CustomTextfield(
                          obsecure: provider.obsecureTextPass,
                          onChanged: (value) => provider.password = value,
                          label: "Password",
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: IconButton(
                            onPressed: provider.togglePassIcon,
                            icon: Icon(
                              provider.obsecureTextPass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                        ),
                        if (provider.isSignUp) ...[
                          SizedBox(height: size.height * 0.01),
                          CustomTextfield(
                            obsecure: provider.obsecureTextCon,
                            onChanged: (value) => provider.confirmPass = value,
                            label: "Confirm Password",
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              onPressed: provider.toggleConfirmPassIcon,
                              icon: Icon(
                                provider.obsecureTextCon
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          CustomTextfield(
                            onChanged: (value) => provider.phoneNO = value,
                            label: "Phone No",
                            prefixIcon: Icons.phone,
                          ),
                          SizedBox(height: size.height * 0.01),
                          CustomTextfield(
                            onChanged: (value) => provider.address = value,
                            label: "Address",
                            prefixIcon: Icons.home,
                          ),
                        ],
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "Forget Password",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.deepPurple.shade500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: size.height*0.057
                          ,
                          child: ElevatedButton(
                            onPressed:
                                provider.isSignUp
                                    ? () => provider.signUp(
                                      address: provider.address ?? "",
                                      phoneNo: provider.phoneNO ?? "",
                                      context: context,
                                      name: provider.name ?? "",
                                      confirmPass: provider.confirmPass ?? "",
                                      email: provider.email ?? "",
                                      password: provider.password ?? "",
                                    )
                                    : () => provider.signIn(
                                      password: provider.password ?? "",
                                      email: provider.email ?? "",
                                      context: context,
                                    ),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 5,
                              backgroundColor: Colors.deepPurple.shade300,
                            ),
                            child: Text(
                              provider.isSignUp ? "Sign Up" : "Sign In",
                              style: const TextStyle(color: Colors.white,fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: size.height * 0.02),
              Text(
                "Or sign in With",
                style: TextStyle(
                  color: Colors.deepPurple.shade300,
                  fontWeight: FontWeight.w700,
                  fontSize: 16
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  provider.socialButton(
                    context: context,
                    imgPath: "assets/logo/socialLogos/google.png",
                  ),
                  provider.socialButton(
                    context: context,
                    imgPath: "assets/logo/socialLogos/fb.png",
                  ),
                  provider.socialButton(
                    context: context,
                    imgPath: "assets/logo/socialLogos/twitter.png",
                  ),
                  provider.socialButton(
                    context: context,
                    imgPath: "assets/logo/socialLogos/in.png",
                  ),
                ],
              ),
              SizedBox(height: size.height*0.007,),

              Consumer<Authentication_Provider>(
                builder: (context, listener, child) {
                  return TextButton(
                    onPressed: provider.toggleSignUp,
                    child: Text(
                      listener.isSignUp
                          ? "Already have an account? Sign in"
                          : "Don't have an account? Sign Up",
                      style: TextStyle(
                        color: Colors.deepPurple.shade300,
                        fontWeight: FontWeight.w700,
                        fontSize: 16
                      ),
                    ),
                  );
                },
              ),

              provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
