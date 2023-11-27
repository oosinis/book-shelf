import 'package:book_shelf/APIs/book_api.dart';
import 'package:book_shelf/models/book.dart';
import 'package:book_shelf/pages/book_details_page.dart';
import 'package:book_shelf/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import '../services/firestore.dart';

class SwipeBookPage extends StatefulWidget {
  const SwipeBookPage({Key? key}) : super(key: key);

  @override
  _SwipeBookPageState createState() => _SwipeBookPageState();
}

class Content {
  final String text;
  final String thumbnail;

  Content({required this.text, required this.thumbnail});
}

class _SwipeBookPageState extends State<SwipeBookPage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FirestoreService firestoreService = FirestoreService();
  final BookApi bookApi = BookApi();
  List<Book> _books = [];
  bool loading = true;

  int _currentPage = 0;
  int _itemsPerPage = 40;

  void navigateToBookDetails(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(
          book: _books[index],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    setState(() {
      loading = true;
    });

    List<Book> fetchedBooks = await bookApi.getBooksQuery(
      startIndex: _currentPage * _itemsPerPage,
      maxResults: _itemsPerPage,
    );

    setState(() {
      _books = fetchedBooks;
      _swipeItems = [];

      for (int i = 0; i < fetchedBooks.length; i++) {
        _swipeItems.add(SwipeItem(
          content: Content(text: fetchedBooks[i].title, thumbnail: fetchedBooks[i].imageLinks?['thumbnail']),
        ));
      }

      _matchEngine = MatchEngine(swipeItems: _swipeItems);
      loading = false;
    });
  }

  void _handleStackFinished() {
    _currentPage++;
    _loadBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.color1,
      key: _scaffoldKey,
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Stack(
                children: [
                  Container(
                    height:
                        (MediaQuery.of(context).size.height - kToolbarHeight) *
                            0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: SwipeCards(
                      matchEngine: _matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => navigateToBookDetails(index),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                image: NetworkImage(
                                  _swipeItems[index].content.thumbnail,
                                  ),
                                ),
                            ),
                            alignment: Alignment.center,
                            /* child: Text(
                              _swipeItems[index].content.text,
                              style: const TextStyle(fontSize: 70),
                              textAlign: TextAlign.center,
                            ), */
                          ),
                        );
                      },
                      onStackFinished: _handleStackFinished,
                      leftSwipeAllowed: true,
                      rightSwipeAllowed: true,
                      fillSpace: true,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
