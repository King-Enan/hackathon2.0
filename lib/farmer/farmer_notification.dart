import 'package:flutter/material.dart';
import 'package:hktn/local_db/user/local_user.dart';
import 'package:hktn/services/order_service.dart';
import 'package:hktn/widget/support_widget.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';

import '../local_db/user/user_cart.dart';
import '../models/order_model.dart';
class FarmerNotification extends StatefulWidget {
  const FarmerNotification({super.key});

  @override
  State<FarmerNotification> createState() => _FarmerNotificationState();
}

class _FarmerNotificationState extends State<FarmerNotification> {
  // void _removeItem(String productId) {
  //   CartStorage.deleteCartItem(productId);
  //   setState(() {
  //     cartItems=CartStorage.getCart();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        centerTitle: true,
      ),
      backgroundColor: AppWidget().whiteColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 4, left: 20.0, right: 20, bottom: 8),
        child: Column(
          children: [
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: AppWidget().fixPadding),
                scrollDirection: Axis.horizontal,
                child: FutureBuilder<List<OrderModel>>(
                  future: OrderService().getOrdersBySeller(getLocalUser()!.email),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    final products = snapshot.data ?? [];
                    print(products.length);
                    print("✅✅✅");print("✅✅✅");
                    return Column(
                      children: List.generate(
                        products.length,
                            (index) {
                          final data = products[index];
                          if(data==null)
                            return Text("nai");
                          else
                          {
                            print(data.runtimeType);
                            print(data.productName);
                            return _buildNotification(data, index);
                          }
                        },
                      ),
                    );
                  },
                )

            )
          ],
        ),
      ),
    );
  }
}
Widget _buildNotification(OrderModel item, int index) {
  return Stack(
    children: [
      Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric( vertical: 12),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "",
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => _placeholderImage(item),
                      )
                  ),

                  SizedBox(width: 12),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Total : ${item.totalPrice.toStringAsFixed(2)} Tk",
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      SizedBox(height: 2),
                      // Text(
                      //   item.farm,
                      //   style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      // ),
                    ],
                  ),

                  SizedBox(width: 60,),
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
                        "${item.quantity.toString()} Kg",
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
                  // InkWell(
                  //   onTap: () => _removeItem(item['productId']),
                  //   child: Icon(Icons.delete_outline, color: Colors.red, size: 26),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
      Positioned(
        right: 0,
        top: 10,
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            "NEW",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ),
      Positioned(
        right: 0,
        bottom: 10,
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            //color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
            ),
          ),
          child: Text(
            "More..>>",
            style: TextStyle(color: AppWidget().primaryColor, fontSize: 12),
          ),
        ),
      )
    ],

  );
}

Widget _placeholderImage(OrderModel item) {
  return Container(
    width: 64,
    height: 64,
    decoration: BoxDecoration(
      color:  Colors.grey.shade300,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Icon(
      Icons.notifications,
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


