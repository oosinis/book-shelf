import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ReadView extends StatelessWidget {
  const ReadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MasonryGridView.builder(
        itemCount: 12,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('lib/images/book.jpg')),
        ),
      ),
    );
  }
}
