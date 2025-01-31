import 'package:ecomerce_app/Custom%20Widgets/customContainer.dart';
import 'package:ecomerce_app/Provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ItemProvider>();
    final listener = context.watch<ItemProvider>();
    provider.getUserStream();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.deepPurple),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                  stream: provider.userStream,
                  builder: (context, snapshot) {
                    listener.getUserDocs(snapshot);

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: SizedBox(
                            height: 170,
                            width: 170,
                            child: CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 170,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Edit Image",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.deepPurple.shade900)),
                        const SizedBox(
                          height: 10,
                        ),
                        customContainer(
                            text: "Name: ${provider.userDocs!["name"]}"),
                        customContainer(
                            text: "Email: ${provider.userDocs!["email"]}"),
                        customContainer(
                            text:
                                "Password: ${provider.userDocs!["password"]}"),
                        customContainer(
                            text:
                                "Phone No: ${provider.userDocs!["Phone No"]}"),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Address : ${provider.userDocs!["address"]}",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              try {
                                FirebaseAuth.instance.signOut();
                               provider.clearCredentials();

                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e Failed to Sign Out")));
                              }
                            },
                            child: const Text("Sign Out"))
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
