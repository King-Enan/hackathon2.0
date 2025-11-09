import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreProductSetup {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Add product data to Firestore (no image)
  Future<void> addProductFromControllers({
    required String sellerUid, // 🔗 Link product to seller UID
    required TextEditingController productNameController,
    required TextEditingController descriptionController,
    required TextEditingController priceController,
    required TextEditingController categoryController,
    required TextEditingController stockController,
  }) async {
    try {
      // Validate inputs
      if (sellerUid.isEmpty ||
          productNameController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          priceController.text.isEmpty ||
          categoryController.text.isEmpty ||
          stockController.text.isEmpty) {
        throw Exception("⚠️ Please fill all product fields!");
      }

      // Parse numeric fields
      final double? price = double.tryParse(priceController.text.trim());
      final int? stock = int.tryParse(stockController.text.trim());
      if (price == null || stock == null) {
        throw Exception("⚠️ Price and Stock must be valid numbers!");
      }

      // Create product map
      final Map<String, dynamic> productData = {
        'productId': DateTime.now().millisecondsSinceEpoch.toString(),
        'productName': productNameController.text.trim(),
        'description': descriptionController.text.trim(),
        'price': price,
        'category': categoryController.text.trim().toLowerCase(),
        'stock': stock,
        'sellerUid': sellerUid, // 🔗 Relationship with users collection
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Add to Firestore
      await _firestore.collection('products').add(productData);

      print('✅ Product added successfully: ${productData['productName']}');
    } catch (e) {
      print('❌ Error adding product: $e');
    }
  }

  /// 🔹 Fetch all products of a specific seller
  Future<List<Map<String, dynamic>>> getProductsBySeller(String sellerUid) async {
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .where('sellerUid', isEqualTo: sellerUid)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('❌ Error fetching seller products: $e');
      return [];
    }
  }
}
