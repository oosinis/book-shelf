import 'package:book_shelf/models/book_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';

class FirestoreService {
  final CollectionReference books = FirebaseFirestore.instance.collection('books');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<List<Book>> fetchBooks() async {
    try {
      QuerySnapshot querySnapshot = await books.get();
      return querySnapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
    } catch (error) {
      print('Error fetching books: $error');
      throw error;
    }
  }

  Future<void> saveBook(String userId, BookTile bookTile) async {
    try {
      var userDoc = await users.doc(userId).get();

      if (!userDoc.exists) throw Exception('User not found');

      await users.doc(userId).update({
        'savedBooks': FieldValue.arrayUnion([bookTile.toJson()]),
      });

    } catch (error) {
      throw Exception('Error saving the book');
    }
  }
}
