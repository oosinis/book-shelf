import 'package:cloud_firestore/cloud_firestore.dart';

class BookTile {
  final String id;
  final String thumbnail;
  final String title;
  final String publishedDate;
  final int pageCount;
  final List<String>? categories;

  BookTile({required this.id, required this.thumbnail, required this.title, required this.publishedDate, required this.pageCount, required this.categories});

  factory BookTile.fromJson(Map<String, dynamic> json) {
    return BookTile(
      id: json['id'] ?? '', 
      title: json['volumeInfo']['title'] ?? 'No Title',
      publishedDate: json['publishedDate'] ?? 'No Published Date',
      pageCount: json['pageCount'] ?? 0,
      categories: json['categories'] != null ? List<String>.from(json['categories']) : null,
      thumbnail: json['volumeInfo']['imageLinks']['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'title': title,
      'publishedDate': publishedDate,
      'pageCount': pageCount,
      'categories': categories,
    };
  }
}