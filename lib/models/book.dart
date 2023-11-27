import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String description;
  final String publisher;
  final String publishedDate;
  final int pageCount;
  final List<String>? categories;
  final Map<String, dynamic>? imageLinks;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.publisher,
    required this.publishedDate,
    required this.pageCount,
    this.categories,
    required this.imageLinks
  });

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Book(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      authors: List<String>.from(data['authors'] ?? ['No Author']),
      description: data['description'] ?? 'No Description',
      publisher: data['publisher'] ?? 'No Publisher',
      publishedDate: data['publishedDate'] ?? 'No Published Date',
      pageCount: data['pageCount'] ?? 0,
      categories: data['categories'] != null ? List<String>.from(data['categories']) : null, 
      imageLinks: data['imageLinks'] != null ? Map<String, dynamic>.from(data['imageLinks']) : null, 
    );
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? '', 
      title: json['title'] ?? 'No Title',
      authors: List<String>.from(json['authors'] ?? ['No Author']),
      description: json['description'] ?? 'No Description',
      publisher: json['publisher'] ?? 'No Publisher',
      publishedDate: json['publishedDate'] ?? 'No Published Date',
      pageCount: json['pageCount'] ?? 0,
      categories: json['categories'] != null ? List<String>.from(json['categories']) : null,
      imageLinks: json['imageLinks'] != null ? Map<String, dynamic>.from(json['imageLinks']) : null,
    );
  }
}
