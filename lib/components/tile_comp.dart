import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tile.dart';

class TileComp extends StatelessWidget {
  final Tile tile;
  const TileComp({super.key, required this.tile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 5),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            tile.imagePath,
            height: 140,
          ),
          Text(
            tile.title,
            style:
                GoogleFonts.dmSerifDisplay(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            width: 160,
            child: Row(
              children: [
                Text(
                  tile.description,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
