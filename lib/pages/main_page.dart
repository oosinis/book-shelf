import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/main_nav_bar.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'swipe_game_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SwipeBookPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 193, 138, 1),
      appBar: AppBar(
        title: const Text(
          'GameSpot',
          style: TextStyle(fontSize: 40, color: Colors.black87),
        ),
        backgroundColor: const Color.fromRGBO(229, 193, 138, 1),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.black87,
          ),
          onPressed: signUserOut,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: MainNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
