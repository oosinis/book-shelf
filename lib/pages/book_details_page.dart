import 'package:flutter/material.dart';

import '../models/book.dart';

class BookDetailsPage extends StatefulWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 193, 138, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(229, 193, 138, 1),
        title: Text(
          widget.book.title.toString(),
          style: const TextStyle(
            fontSize: 40,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
