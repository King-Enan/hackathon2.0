// lib/services/firestore_setup.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreSetup {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Add user data to Firestore using TextEditingControllers
  Future<void> addUserFromControllers({
    required TextEditingController nameController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required TextEditingController roleController,
    required TextEditingController addressController,
  }) async {
    try {
      // Validate fields
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          roleController.text.isEmpty ||
          addressController.text.isEmpty) {
        throw Exception("⚠️ Please fill all the fields!");
      }

      // Create user map
      final Map<String, dynamic> userData = {
        'uid': DateTime.now().millisecondsSinceEpoch.toString(), // temp ID
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'role': roleController.text.trim().toLowerCase(), // seller/buyer
        'address': addressController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Add to Firestore
      await _firestore.collection('users').add(userData);

      print('✅ User added successfully: ${userData['name']}');
    } catch (e) {
      print('❌ Error adding user: $e');
    }
  }
}
