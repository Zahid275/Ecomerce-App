import 'package:ecomerce_application/Provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, provider, child) {
        return Scaffold(

            backgroundColor: Colors.grey.shade300,
            bottomNavigationBar: Container(
              height: 80,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(22)),

              child: GNav(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                rippleColor: Colors.white54,
                gap: 5,
                tabBorderRadius: 30,
                iconSize: 30,
                activeColor: Colors.deepPurple.shade300,
                color: Colors.deepPurple.shade300,
                backgroundColor: Colors.deepPurple.shade100,
                tabBackgroundColor: Colors.white,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: Icons.shopping_cart,style: GnavStyle.google,
                    text: "Cart",
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: "Favs",
                  ),
                  GButton(
                    icon: Icons.person,
                    text: "Profile",
                  ),
                ],
                selectedIndex: provider.currentIndex,
                onTabChange: (value) {
                  provider.onChanged(value);
                },
              ),
            ),
            body: provider.pages[provider.currentIndex]);
      },
    );
  }
}
