class CartItem {
  final String productId;
  final String productName;
  final double total;
  final String category;
  int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.total,
    required this.quantity,
    required this.category,
  });

  Map<String, dynamic> toMap() => {
    "productId": productId,
    "productName": productName,
    "total": total,
    "quantity": quantity,
    "category" : category,
  };

  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
    productId: map["productId"],
    productName: map["productName"],
    total: map["total"].toDouble(),
    quantity: map["quantity"],
    category:  map["category"],
  );
}
