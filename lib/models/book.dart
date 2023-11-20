import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Book {
  final String name;
  final String author;
  final String description;

  Book({required this.name, required this.author, required this.description});

  factory Book.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Book(
      name: data['name'],
      author: data['author'],
      description: data['color']
    );
  }
}