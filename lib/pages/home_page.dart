import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/tile_comp.dart';
import '../models/tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  List tiles = [
    Tile(
      title: "GTA SALE",
      description: "Big sale for this game",
      imagePath: ""),
    Tile(
      title: "GTA NEWS", 
      description: "New Update", 
      imagePath: ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 193, 138, 1),
      body: Column(
        children: [
          Center(child: Text("Welcome " + user.email!),),
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
