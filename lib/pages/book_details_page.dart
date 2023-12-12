import 'package:book_shelf/theme.dart';
import 'package:flutter/material.dart';

import '../APIs/book_api.dart';
import '../models/book.dart';

class BookDetailsPage extends StatefulWidget {
  final String bookId;

  const BookDetailsPage({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  final BookApi bookApi = BookApi();
  late Future<Book> _bookFuture;

  @override
  void initState() {
    super.initState();
    _bookFuture = bookApi.getBookDetails(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:CustomTheme.color1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:CustomTheme.color1,
        title: FutureBuilder<Book>(
          future: _bookFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Book book = snapshot.data!;
              return Text(
                book.title.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.black87,
                ),
              );
            }
          },
        ),
        centerTitle: true,
      ),
    );
  }
}
