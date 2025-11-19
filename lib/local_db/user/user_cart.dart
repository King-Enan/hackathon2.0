// import 'package:get_storage/get_storage.dart';
// import '../../models/cart_model.dart';
//
// class CartStorage {
//   static final box = GetStorage();
//   static const String cartKey = "cart";
//
//   /// READ all cart items
//   static List<CartItem> getCart() {
//     final list = box.read(cartKey);
//     if (list == null) return [];
//
//     return List<Map<String, dynamic>>.from(list)
//         .map((e) => CartItem.fromMap(e))
//         .toList();
//   }
//
//   /// SAVE full cart list
//   static void saveCart(List<CartItem> cart) {
//     final data = cart.map((e) => e.toMap()).toList();
//     box.write(cartKey, data);
//   }
//
//   /// ADD product to cart
//   static void addToCart(CartItem item) {
//     final cart = getCart();
//
//     // If product already exists → update quantity
//     final index = cart.indexWhere((p) => p.productId == item.productId);
//
//     if (index >= 0) {
//       cart[index].quantity += item.quantity;
//     } else {
//       cart.add(item);
//     }
//
//     saveCart(cart);
//   }
//
//   /// REMOVE a product from cart
//   static void removeFromCart(String productId) {
//     final cart = getCart();
//     cart.removeWhere((item) => item.productId == productId);
//     saveCart(cart);
//   }
//
//   /// CLEAR cart
//   static void clearCart() {
//     box.remove(cartKey);
//   }
// }

import 'package:get_storage/get_storage.dart';

class CartStorage {
  static final box = GetStorage();
  static const String cartKey = 'cart';

  /// Check if a product already exists in cart by productId
  static bool isExisting(String productId){
    final cart = CartStorage.getCart();
    return cart.any((item)=>item['productId']==productId);
  }

  /// Save cart: expects a list of Map<String, dynamic>
  static void saveCart(Map<String, dynamic> cartData) {
    box.write(cartKey, cartData);
  }

  static void saveCartList(List<Map<String, dynamic>> cartData) {
    box.write(cartKey, cartData);
  }
  static List<Map<String, dynamic>> getCart() {
    final data = box.read(cartKey);

    if (data is List) {
      return data
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }

    return [];
  }


  /// Update only quantity & total for a specific product
  static void updateCart(String productId, int quantity, double total) {
    final cart = getCart();

    // find item index
    final index = cart.indexWhere((item) => item['productId'] == productId);

    if (index != -1) {
      // update values
      cart[index]['quantity'] += quantity;
      cart[index]['totalPrice'] += total;

      // save updated list
      saveCartList(cart);
    }
  }

  /// Delete a single cart item by productId
  static void deleteCartItem(String productId) {
    final cart = getCart();
    cart.removeWhere((item) => item['productId'] == productId);
    saveCartList(cart);
  }

  /// Clear the entire cart
  static void clearCart() {
    box.remove(cartKey);
  }
}
