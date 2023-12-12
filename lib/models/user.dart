import 'package:book_shelf/models/book_tile.dart';

class User {
  String email;
  String userName;
  List<BookTile> savedBooks;
  List<BookTile> ratedBooks;
  List<String> categories;

  User( {
    required this.email,
    required this.userName,
    required this.savedBooks,
    required this.ratedBooks,
    required this.categories,
  });
}