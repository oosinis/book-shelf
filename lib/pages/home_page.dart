import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/tile_comp.dart';
import '../models/tile.dart';
import '../theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  List tiles = [
    Tile(
      title: "Sipsik",
      description: "Audioraamat!",),
    Tile(
      title: "Astridi raamatud", 
      description: "Vaata uut väjaannet!",), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.color1,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: tiles.length,
              itemBuilder: (context, index) => TileComp(
                tile: tiles[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
