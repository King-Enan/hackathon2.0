import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hktn/%20banner/template_farmer_product.dart';
import 'package:hktn/farmer/farmer_upload_product.dart';
import 'package:hktn/local_db/user/local_user.dart';

import '../models/product_model.dart';
import '../services/product_service.dart';

class FarmerProducts extends StatefulWidget {
  FarmerProducts({Key? key}) : super(key: key);

  @override
  State<FarmerProducts> createState() => _FarmerProductsState();
}

class _FarmerProductsState extends State<FarmerProducts> {
  // late final products;

  final userData = getLocalUser();

  Color statusColor(ProductStatus status) {
    switch (status) {
      case ProductStatus.availableGreen:
        return Colors.green.shade600;
      case ProductStatus.availableRed:
        return Colors.red.shade600;
      case ProductStatus.soldOut:
        return Colors.red.shade600;
    }
  }

  String statusText(ProductStatus status) {
    switch (status) {
      case ProductStatus.availableGreen:
      case ProductStatus.availableRed:
        return 'Available';
      case ProductStatus.soldOut:
        return 'Sold Out';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'My Products',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Profile or settings action
            },
            icon: CircleAvatar(
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          children: [
            // Product cards list
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: ProductService().getProductsByFarmer(userData!.email), // fetch by farmer email
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final products = snapshot.data ?? [];

                  if (products.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }
                  // Future<void> _loadProducts() async {
                  //   final userData = getLocalUser();
                  //   final data = await ProductService().getProductsByFarmer(userData!.email);
                  //   setState(() {
                  //     products = data;
                  //   });
                  // }

                  return ListView.separated(
                    itemCount: products.length,
                    separatorBuilder: (context, _) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return TemplateFarmerProduct(product: product, index: index,
                      //   onDelete: () async {
                      //   await _loadProducts(); // call async function safely
                      // },
                      );
                    },
                  );
                },
              ),
            ),


            // No crops message + Add product button area
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_basket_outlined,
                    size: 34,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'No crops added yet.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Tap the + button to upload your first product.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Add Product floating style button with label
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          Get.to(FarmerUploadProduct());
                        },
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.add),
                        elevation: 3,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



