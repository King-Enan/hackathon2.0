import 'package:flutter/material.dart';
import 'package:hktn/models/order_model.dart';
import 'package:hktn/services/order_service.dart';
import 'package:hktn/widget/support_widget.dart';

class FarmerProductOrderDetails extends StatefulWidget {
  final OrderModel order;
  FarmerProductOrderDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<FarmerProductOrderDetails> createState() => _FarmerProductOrderDetailsState();
}

class _FarmerProductOrderDetailsState extends State<FarmerProductOrderDetails> {
  bool? accepted;
  String status = "";
  bool isLoading = false;
  @override
  void initState() {
    if(widget.order.status!="pending" && widget.order.status=="decline")
      {
        accepted = false;
        status = "Order Declined";
      }
    if(widget.order.status!="pending" && widget.order.status=="accepted")
    {
      accepted = true;
      status ="Order Accepted";
    }
    print(accepted.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("✅✅✅");print("✅✅✅");
    print(widget.order.buyerUid);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 22,
                  offset: const Offset(0, 8)),
            ],
          ),
          child: Column(
            children: [
              // Image with back and favorite button overlays
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                    child: Image.network(
                      "https://media.istockphoto.com/id/1203599923/photo/food-background-with-assortment-of-fresh-organic-vegetables.jpg?s=612x612&w=0&k=20&c=DZy1JMfUBkllwiq1Fm_LXtxA4DMDnExuF40jD8u9Z0Q=",
                      height: 240,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Back button top-left
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          widget.order.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 4),
                        // Seller farm
                        Row(
                          children: [
                            Text(
                              "Buyer: ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Text(
                                "${widget.order.sellerUid}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppWidget().primaryColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                        // Price per kg row
                        Text(
                          "Price/kg  : ${widget.order.price} tk",
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),


                        const SizedBox(height: 30),
                        // Order Details block
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              _infoRow("Order ID:", widget.order.orderId.toString()),
                              _infoRow("Product ID:", widget.order.productId),
                              _infoRow("Buyer UID:", widget.order.buyerUid),
                              _infoRow("Quantity:", "${widget.order.quantity} kg"),
                              _infoRow("Price/Unit:", "₹${widget.order.price}"),
                              _infoRow(
                                  "Total Price:", "₹${widget.order.totalPrice}"),
                              _infoRow("Order Time:",
                                  formatDateTime(widget.order.createdAt)),
                              _infoRow("Buyer Location:", "order.buyerLocation"),
                              _infoRow("Buyer Contact:", "order.phone"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom buttons
              if(accepted==null && status == "")decideButton()
                else decidedButton(accepted!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget decideButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 22.0, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async{
                // Decline order action
                setState(() {
                  isLoading = true;
                  accepted =false;
                  status = "Order Declined";
                });
                await OrderService().updateOrderStatus(widget.order.orderId.toString(), "decline");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order Declined')),
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppWidget().redColor),)
                  : Text(
                'Decline Order',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: ElevatedButton(
              onPressed: () async{
                // Accept order action
                setState(() {
                  isLoading = true;
                  accepted =true;
                  status = "Order Accepted";
                });
                await OrderService().updateOrderStatus(widget.order.orderId.toString(), "accepted");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order Accepted')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppWidget().redColor),)
                  : Text(
                'Accept Order',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget decidedButton(bool accepted){
    print(accepted.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
      child: Container(
        child: Text(status,
        style: TextStyle(color: decideColor(accepted),fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Color decideColor(bool accept){
    switch(accept){
      case false :
        return AppWidget().redColor;
      case true :
        return AppWidget().primaryColor;
    }
  }

}

String formatDateTime(DateTime dt) {
  return "${dt.day.toString().padLeft(2, '0')} ${_monthName(dt.month)} ${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
}

String _monthName(int month) {
  const months = [
    "",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return months[month];
}

