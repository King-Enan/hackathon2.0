import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String? productId;
  final String productName;
  final String category;
  final String description;
  final String farmName;
  final String imageURL;
  final double price;
  final String sellerUid;
  final String status;
  final int stock;
  final Timestamp createdAt;

  ProductModel({
    this.productId,
    required this.productName,
    required this.category,
    required this.description,
    required this.farmName,
    required this.imageURL,
    required this.price,
    required this.sellerUid,
    required this.status,
    required this.stock,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'category': category,
      'description': description,
      'farmName': farmName,
      'imageURL': imageURL,
      'price': price,
      'sellerUid': sellerUid,
      'status': status,
      'stock': stock,
      'createdAt': createdAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      productName: map['productName'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      farmName: map['farmName'] ?? '',
      imageURL: map['imageURL'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      sellerUid: map['sellerUid'] ?? '',
      status: map['status'] ?? '',
      stock: (map['stock'] ?? 0).toInt(),
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }
}
