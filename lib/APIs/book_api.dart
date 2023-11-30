import 'dart:convert';
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

  Future<List<Book>> getBooksQuery({
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
        List<Book> books = (data['items'] as List)
            .map((item) => Book.fromJson(item['volumeInfo']))
            .toList();

        return books;
      } else {
        return [];
      }
    } else {
      throw Exception('API error');
    }
  }
}
