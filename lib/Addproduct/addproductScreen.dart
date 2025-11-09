import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hktn/Addproduct/productAdd.dart';


class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final stockController = TextEditingController();

  final _productService = FirestoreProductSetup();

  // ✅ Firebase Auth reference
  final _auth = FirebaseAuth.instance;

  String? _sellerUid;

  @override
  void initState() {
    super.initState();
    _getCurrentSellerUid();
  }

  Future<void> _getCurrentSellerUid() async {
    final user = _auth.currentUser;
    if (user != null) {
      // Optional: double-check in Firestore that this user is actually a seller
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists && userDoc['role'] == 'seller') {
        setState(() {
          _sellerUid = user.uid;
        });
      } else {
        print("⚠️ Current user is not a seller or not found in Firestore.");
      }
    } else {
      print("⚠️ No user logged in.");
    }
  }

  Future<void> _uploadProduct() async {
    if (_sellerUid == null) {
      print("⚠️ Seller UID not found! Please log in as a seller.");
      return;
    }

    await _productService.addProduct(
      sellerUid: _sellerUid!,
      productNameController: productNameController,
      descriptionController: descriptionController,
      priceController: priceController,
      categoryController: categoryController,
      stockController: stockController,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_sellerUid == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: productNameController,
              decoration: const InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: stockController,
              decoration: const InputDecoration(labelText: "Stock"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadProduct,
              child: const Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
