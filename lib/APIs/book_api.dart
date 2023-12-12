import 'dart:convert';
import 'package:book_shelf/models/book_tile.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';

class BookApi {
  static const String baseUrl = "https://www.googleapis.com/books/v1/volumes";

  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final response = await http.get(Uri.parse('$baseUrl?q=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('items')) {
        // Extract relevant book information
        List<Map<String, dynamic>> books = (data['items'] as List)
            .map((item) => item['volumeInfo'] as Map<String, dynamic>)
            .toList();

        return books;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load books');
    }
  }

  // Get List of random books
  Future<List<BookTile>> getBooks({
    String query = 'car',
    String orderBy = 'newest',
    int maxResults = 40,
    int startIndex = 0,
  }) async {

    final response = await http.get(Uri.parse(
      '$baseUrl?q=$query&orderBy=$orderBy&maxResults=$maxResults&startIndex=$startIndex',
    ));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('items')) {
        List<BookTile> books = (data['items'] as List)
            .map((item) => BookTile.fromJson(item))
            .toList();

        return books;
      } else {
        return [];
      }
    } else {
      throw Exception('API error');
    }
  }
  
  //Get Book Details
  Future<Book> getBookDetails(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) throw Exception('API error');
    
    final Map<String, dynamic> data = json.decode(response.body);
    var book = Book.fromJson(id, data);

    return book;
  }
}
