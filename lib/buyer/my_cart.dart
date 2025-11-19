import 'package:flutter/material.dart';
import 'package:hktn/%20banner/template_green.dart';
import 'package:hktn/local_db/user/user_cart.dart';
import 'package:hktn/widget/support_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:iconify_flutter/icons/ic.dart';

class MyCart extends StatefulWidget {
  //final Map<String, dynamic> to_transection;

  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<Map<String, dynamic>> cartItems = CartStorage.getCart();

  @override
  @override
  // void initState() {
  //   super.initState();
  //
  //   cartItems = [];
  //
  //   // Since to_transection itself is a single map
  //   cartItems.add(
  //     CartItem(
  //       id: widget.to_transection['id'] ?? UniqueKey().toString(),
  //       name: widget.to_transection['name'] ?? '',
  //       price: (widget.to_transection['price'] is num)
  //           ? (widget.to_transection['price'] as num).toDouble()
  //           : 0.0,
  //       quantity: (widget.to_transection['ordering'] is int)
  //           ? widget.to_transection['ordering'] as int
  //           : 1,
  //     ),
  //   );
  // }


  // void _incrementQuantity(int index) {
  //   setState(() {
  //     cartItems[index].quantity++;
  //   });
  // }
  //
  // void _decrementQuantity(int index) {
  //   setState(() {
  //     if (cartItems[index].quantity > 1) {
  //       cartItems[index].quantity--;
  //     }
  //   });
  // }
  //
  double get _totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  void _removeItem(String productId) {
    CartStorage.deleteCartItem(productId);
    setState(() {
      cartItems=CartStorage.getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? _buildEmptyCart()
                : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                print("✅✅✅");
                print(cartItems.length);
                return _buildCartItem(item, index);
              },
            ),
          ),

          if (cartItems.isNotEmpty)
            _buildBottomBar()
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String,dynamic> item, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item['imageURL'],
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _placeholderImage(item),
            )
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['productName'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  "Total : ${item['totalPrice'].toStringAsFixed(2)} Tk",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontSize: 14),
                ),
                SizedBox(height: 2),
                // Text(
                //   item.farm,
                //   style: TextStyle(color: Colors.grey[600], fontSize: 13),
                // ),
              ],
            ),
          ),

          // Quantity controls
          Row(
            children: [
              // InkWell(
              //   onTap: () => _incrementQuantity(index),
              //   borderRadius: BorderRadius.circular(18),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(18),
              //     ),
              //     padding: EdgeInsets.all(6),
              //     child: Icon(Icons.add, color: Colors.white, size: 20),
              //   ),
              // ),
              Iconify(Ic.twotone_production_quantity_limits,size: 16,),
              SizedBox(width: 10),
              Text(
                "${item['quantity'].toString()} Kg",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(width: 10),
              // InkWell(
              //   onTap: () => _decrementQuantity(index),
              //   borderRadius: BorderRadius.circular(18),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(18),
              //     ),
              //     padding: EdgeInsets.all(6),
              //     child: Icon(Icons.remove, color: Colors.white, size: 20),
              //   ),
              // ),
            ],
          ),

          SizedBox(width: 12),

          // Delete button
          InkWell(
            onTap: () => _removeItem(item['productId']),
            child: Icon(Icons.delete_outline, color: Colors.red, size: 26),
          ),
        ],
      ),
    );
  }

  Widget _placeholderImage(Map<String,dynamic> item) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color:  Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
         Icons.local_florist,
        color: Colors.white70,
        size: 36,
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_basket_outlined, color: Colors.orange.shade700, size: 80),
            SizedBox(height: 12),
            Text("Your cart is empty",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),
            SizedBox(height: 8),
            Text(
              "Browse products to add to your cart",
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to browse products page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(
                "Browse Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -3))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total: ${formatCurrency(_totalPrice)} TK",
            style: AppWidget.QuickSandBlackSizeBold(18),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppWidget().primaryColor,
              //padding: EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () {
              // TODO: Proceed to payment action
            },
            child: Text(
              "Proceed to Payment",
              style: AppWidget.QuickSandBlackSizeBold(14),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

