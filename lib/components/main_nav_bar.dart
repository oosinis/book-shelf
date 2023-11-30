import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../theme.dart';

class MainNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MainNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GNav(
        color: CustomTheme.color2,
        activeColor: CustomTheme.color1,
        tabActiveBorder: Border.all(color: CustomTheme.color2),
        tabBackgroundColor: CustomTheme.color2,
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