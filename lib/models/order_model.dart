import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? orderId;
  String buyerUid;
  String sellerUid;
  String productId;
  String productName;
  int quantity;
  double price;
  double totalPrice;
  String status;
  DateTime createdAt;

  OrderModel({
    this.orderId,
    required this.buyerUid,
    required this.sellerUid,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "buyerUid": buyerUid,
      "sellerUid": sellerUid,
      "productId": productId,
      "productName": productName,
      "quantity": quantity,
      "price": price,
      "totalPrice": totalPrice,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  /// 🔄 Map → Model
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      buyerUid: map['buyerUid'] ?? '',
      sellerUid: map['sellerUid'] ?? '',
      productId: map['productId'] ?? '',
      productName: map['productName'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      status: map['status'] ?? '',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }


  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      orderId: doc.id,
      buyerUid: data['buyerUid'] ?? '',
      sellerUid: data['sellerUid'] ?? '',
      productId: data['productId'] ?? '',
      productName: data['productName'] ?? '',
      quantity: data['quantity'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: data['status'] ?? 'pending',
      createdAt: data['createdAt'] == null
          ? DateTime.now()
          : DateTime.parse(data['createdAt']),
    );
  }

}
