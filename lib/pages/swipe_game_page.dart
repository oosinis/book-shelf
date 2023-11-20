import 'package:book_shelf/models/book.dart';
import 'package:book_shelf/pages/book_details_page.dart';
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
  final Color color;

  Content({required this.text, required this.color});
}

class _SwipeBookPageState extends State<SwipeBookPage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final FirestoreService firestoreService = FirestoreService();
  List<Book> _books = [];
  bool loading = true;

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
    _loadGames();
  }

  Future<void> _loadGames() async {
    List<Book> fetchedBooks = await firestoreService.fetchBooks();
    setState(() {
      _books = fetchedBooks;

      for (int i = 0; i < _books.length; i++) {
        _swipeItems.add(SwipeItem(
          content: Content(text: _books[i].name, color: Colors.red),
        ));
      }

      _matchEngine = MatchEngine(swipeItems: _swipeItems);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(229, 193, 138, 1),
      key: _scaffoldKey,
      body: Center(
          child: loading
              ? CircularProgressIndicator()
              : Stack(children: [
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
                              color: _swipeItems[index].content.color,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              _swipeItems[index].content.text,
                              style: const TextStyle(fontSize: 70),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                      onStackFinished: () {},
                      leftSwipeAllowed: true,
                      rightSwipeAllowed: true,
                      fillSpace: true,
                    ),
                  ),
                ])),
    );
  }
}
