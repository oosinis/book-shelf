import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/book.dart';

class FirestoreService {
  final CollectionReference books =
      FirebaseFirestore.instance.collection('games');

  Future<List<Book>> fetchBooks() async {
    try {
      QuerySnapshot querySnapshot = await books.get();
      return querySnapshot.docs.map((doc) => Book.fromFirestore(doc)).toList();
    } catch (error){
      print('Error fetching games: $error');
      throw error;
    }
  }
}
