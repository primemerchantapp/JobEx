import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Category {
  final String id;
  final String title;
  final String imageUrl;

  Category({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  factory Category.fromFirestore(Map<String, dynamic> data, String id) {
    return Category(
      id: id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => [..._categories];

  Future<void> fetchCategories() async {
    try {
      QuerySnapshot categorySnapshot =
          await FirebaseFirestore.instance.collection('categories').get();

      _categories = await Future.wait(categorySnapshot.docs.map((doc) async {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String imageUrl = data['imageUrl'] ?? '';

        if (imageUrl.startsWith('gs://') || imageUrl.startsWith('/')) {
          imageUrl = await getDownloadURL(imageUrl);
        }

        return Category(
          id: doc.id,
          title: data['title'] ?? '',
          imageUrl: imageUrl,
        );
      }));

      notifyListeners();
    } catch (error) {
      print('Error fetching categories: $error');
      throw Exception('Failed to fetch categories');
    }
  }

  Future<String> getDownloadURL(String path) async {
    if (path.isEmpty) return '';
    try {
      Reference ref = FirebaseStorage.instance.ref(path);
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error getting download URL: $e');
      return '';
    }
  }
}
