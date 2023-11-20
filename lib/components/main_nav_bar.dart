import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MainNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: GNav(
        color: Colors.black87,
        activeColor: Color.fromRGBO(229, 193, 138, 1),
        tabActiveBorder: Border.all(color: Colors.black54),
        tabBackgroundColor: Colors.black87,
        tabBorderRadius: 25,
        onTabChange: (value) => onTabChange!(value),
         tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.swipe,
                text: 'Swipe',
              ),
              GButton(
                icon: Icons.man,
                text: 'Profile',
              )
            ]
      ),
    );
  }
}