import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Custom Widgets/customTextField.dart';
import '../Provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ItemProvider>();
    final listener = context.watch<ItemProvider>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              Center(
                child: SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.15,
                  child: Image.asset("assets/logo/logo_withoutBack.png"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  provider.isSignUp ? "Sign Up" : "Sign In",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Center(
                child: Column(
                  children: [
                    if (provider.isSignUp)
                      cusTomTextField(
                        onChanged: (value) => provider.name = value,
                        label: "Username",
                        prefixIcon: Icons.person_outline,
                      ),
                    SizedBox(height: size.height * 0.02),
                    cusTomTextField(
                      onChanged: (value) => provider.email = value,
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                    ),
                    SizedBox(height: size.height * 0.02),
                    cusTomTextField(
                      obsecure: provider.obsecureTextPass,
                      onChanged: (value) => provider.password = value,
                      label: "Password",
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        onPressed: listener.togglePassIcon,
                        icon: Icon(provider.obsecureTextPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    if (provider.isSignUp) ...[
                      SizedBox(height: size.height * 0.02),
                      cusTomTextField(
                        obsecure: listener.obsecureTextCon,
                        onChanged: (value) => provider.confirmPass = value,
                        label: "Confirm Password",
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          onPressed: listener.toggleConfirmPassIcon,
                          icon: Icon(provider.obsecureTextCon
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      cusTomTextField(
                        onChanged: (value) => provider.phoneNO = value,
                        label: "Phone No",
                        prefixIcon: Icons.phone,
                      ),
                      SizedBox(height: size.height * 0.02),
                      cusTomTextField(
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
                    SizedBox(height: size.height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: provider.isSignUp
                            ? () => provider.signUp(
                          address: provider.address!,
                          phoneNo: provider.phoneNO!,
                          context: context,
                          name: provider.name!,
                          confirmPass: provider.confirmPass!,
                          email: provider.email!,
                          password: provider.password!,
                        )
                            : () => provider.signIn(
                          password: provider.password!,
                          email: provider.email!,
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
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (!provider.isSignUp) ...[
                      SizedBox(height: size.height * 0.02),
                      Text(
                        "Or sign in With",
                        style: TextStyle(
                          color: Colors.deepPurple.shade300,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        children: [
                          provider.socialButton(
                              imgPath: "assets/logo/socialLogos/google.png"),
                          provider.socialButton(
                              imgPath: "assets/logo/socialLogos/fb.png"),
                          provider.socialButton(
                              imgPath: "assets/logo/socialLogos/twitter.png"),
                          provider.socialButton(
                              imgPath: "assets/logo/socialLogos/in.png"),
                        ],
                      ),
                    ],
                    TextButton(
                      onPressed: listener.toggleSignUp,
                      child: Text(
                        provider.isSignUp
                            ? "Already have an account? Sign in"
                            : "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: Colors.deepPurple.shade300,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (listener.isLoading)
                      const Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
