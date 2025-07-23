import 'package:ecomerce_application/Custom%20Widgets/customContainer.dart';
import 'package:ecomerce_application/Provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ItemProvider>();
    final listener = context.watch<ItemProvider>();

    final size = MediaQuery.of(context).size;
    final maxWidth = size.width;
    final maxHeight = size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.deepPurple),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: provider.getUserStream(),
              builder: (context, snapshot) {
                provider.getUserStream();
                listener.getUserDocs(snapshot);

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: maxHeight * 0.2,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                return Column(
                  children: [
                    SizedBox(height: maxHeight * 0.02),
                    Center(
                      child: SizedBox(
                        height: maxHeight * 0.2,
                        width: maxWidth * 0.4,
                        child: const CircleAvatar(
                          child: Icon(Icons.person, size: 100),
                        ),
                      ),
                    ),
                    SizedBox(height: maxHeight * 0.02),
                    Text("Edit Image", style: TextStyle(fontSize: 20, color: Colors.deepPurple.shade900)),
                    SizedBox(height: maxHeight * 0.02),
                    customContainer(text: "Name: ${provider.userDocs?["name"] ?? ""}"),
                    customContainer(text: "Email: ${provider.userDocs?["email"] ?? ""}"),
                    customContainer(text: "Password: ${provider.userDocs?["password"] ?? ""}"),
                    customContainer(text: "Phone No: ${provider.userDocs?["Phone No"] ?? ""}"),
                    SizedBox(height: maxHeight * 0.02),
                    Text(
                      "Address : ${provider.userDocs?["address"] ?? ""}",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: maxHeight * 0.02),
                    ElevatedButton(
                      onPressed: () async{
                        try {
                          provider.clearCredentials();
                          provider.currentIndex = 0;
                         await  FirebaseAuth.instance.signOut();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("$e Failed to Sign Out")),
                          );
                        }
                      },
                      child: const Text("Sign Out"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
