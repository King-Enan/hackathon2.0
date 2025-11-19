import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

class OrderService {
  final CollectionReference ordersRef =
  FirebaseFirestore.instance.collection('orders');

  /// --------------------------
  /// CREATE ORDER (Auto ID)
  /// --------------------------
  Future<String?> createOrder(OrderModel order) async {
    try {
      DocumentReference doc = await ordersRef.add(order.toMap());
      return doc.id; // Firestore auto-generated orderId
    } catch (e) {
      print("🔥 Error creating order: $e");
      return null;
    }
  }

  /// --------------------------
  /// GET ORDER BY ID
  /// --------------------------
  Future<OrderModel?> getOrderById(String orderId) async {
    try {
      DocumentSnapshot doc = await ordersRef.doc(orderId).get();

      if (!doc.exists) return null;

      return OrderModel.fromDocument(doc);
    } catch (e) {
      print("🔥 Error fetching order: $e");
      return null;
    }
  }

  /// --------------------------
  /// GET ORDERS BY SELLER EMAIL
  /// --------------------------
  Future<List<OrderModel>> getOrdersBySeller(String sellerEmail) async {
    try {
      QuerySnapshot snap = await ordersRef
          .where('sellerEmail', isEqualTo: sellerEmail)
          .get();

      return snap.docs
          .map((doc) => OrderModel.fromDocument(doc))
          .toList();
    } catch (e) {
      print("🔥 Error fetching seller orders: $e");
      return [];
    }
  }

  /// --------------------------
  /// GET ORDERS BY BUYER EMAIL
  /// --------------------------
  Future<List<OrderModel>> getOrdersByBuyer(String buyerEmail) async {
    try {
      QuerySnapshot snap = await ordersRef
          .where('buyerUid', isEqualTo: buyerEmail)
          .get();

      return snap.docs
          .map((doc) => OrderModel.fromDocument(doc))
          .toList();
    } catch (e) {
      print("🔥 Error fetching buyer orders: $e");
      return [];
    }
  }

  /// --------------------------
  /// GET ORDERS BY SELLER EMAIL
  /// --------------------------
  Future<List<OrderModel>> getOrdersByStatus(String status) async {
    try {
      QuerySnapshot snap = await ordersRef
          .where('status', isEqualTo: status)
          .get();

      return snap.docs
          .map((doc) => OrderModel.fromDocument(doc))
          .toList();
    } catch (e) {
      print("🔥 Error fetching seller orders: $e");
      return [];
    }
  }

}
