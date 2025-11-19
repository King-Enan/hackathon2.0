import 'package:flutter/material.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:hktn/local_db/user/local_user.dart';
import 'package:hktn/models/order_model.dart';
import 'package:hktn/services/order_service.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample order data
  final List<Order> orders = [
    Order(
      id: 1025,
      items: ['Tomatoes', 'Onions'],
      status: OrderStatus.pending,
      buyer: 'Shahed Alam',
      farmer: null,
    ),
    Order(
      id: 1024,
      items: ['Farm Cucumbers', 'Beans'],
      status: OrderStatus.ongoing,
      buyer: 'Fatima Begum',
      farmer: null,
    ),
    Order(
      id: 1023,
      items: ['Red Onions'],
      status: OrderStatus.completed,
      buyer: null,
      farmer: "Rahim's Farm",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // Filter orders by status
  List<Order> getOrdersByStatus(OrderStatus status) {
    return orders.where((order) => order.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        centerTitle: true,
        title: Text(
          'Orders',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt, color: Colors.green),
            onPressed: () {
              // Add action if needed
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
          tabs: [
            Tab(text: 'Ongoing'),
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ongoing
          _buildOrderList("ongoing"),
          // Pending
          _buildOrderList("pending"),
          // Completed
          _buildOrderList("completed"),
        ],
      ),
    );
  }

  Widget _buildOrderList(String status) {
    //final filteredOrderss = OrderService().getOrdersByStatus(status);

    return FutureBuilder(
        //future: OrderService().getOrdersByBuyer(getLocalUser()!.email),
        future: OrderService().getOrdersByStatus(status),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator(),);
            }
          if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_basket_outlined,
                      color: Colors.green,
                      size: 60,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No orders yet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Your orders will appear here once confirmed',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          }

          final filteredOrders = snapshot.data!;
print(filteredOrders.length);
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              return OrderCard(order);
            },
          );


        }
    );


    //

  }
}

// Model to represent order status
enum OrderStatus { ongoing, pending, completed }

// Order model
class Order {
  final int id;
  final List<String> items;
  final OrderStatus status;
  final String? buyer;
  final String? farmer;

  Order({
    required this.id,
    required this.items,
    required this.status,
    this.buyer,
    this.farmer,
  });
}

// Individual order card widget
class _OrderCard extends StatelessWidget {
  final Order order;

  const _OrderCard({required this.order});

  Color _getStatusColor() {
    switch (order.status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.ongoing:
        return Colors.green;
      case OrderStatus.completed:
        return Colors.green.shade700;
    }
  }

  String _getStatusText() {
    switch (order.status) {
      case OrderStatus.pending:
        return "Pending";
      case OrderStatus.ongoing:
        return "Ongoing";
      case OrderStatus.completed:
        return "Completed";
    }
  }

  Widget _buildStatusTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getStatusText(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildIcons() {
    // For demo, use simple icons matching the type of order items, or simpler icons
    if (order.status == OrderStatus.pending || order.status == OrderStatus.ongoing) {
      // Delivery truck icon to right
      return Icon(Icons.local_shipping, color: Colors.green);
    }
    if (order.status == OrderStatus.completed) {
      return Icon(Icons.check_circle, color: Colors.green);
    }
    return SizedBox();
  }

  // Basic example to fetch illustrative item emoji icons for demo purpose
  List<Widget> _itemIcons() {
    List<Widget> icons = [];
    for (var item in order.items) {
      if (item.toLowerCase().contains('tomato')) {
        icons.add(_emojiIcon('🍅'));
      } else if (item.toLowerCase().contains('onion')) {
        icons.add(_emojiIcon('🧅'));
      } else if (item.toLowerCase().contains('cucumber')) {
        icons.add(_emojiIcon('🥒'));
      } else if (item.toLowerCase().contains('beans')) {
        icons.add(_emojiIcon('🫘'));
      } else {
        icons.add(_emojiIcon('🌿')); // default icon
      }
    }
    return icons;
  }

  Widget _emojiIcon(String emoji) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        emoji,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firstLine = 'Order #${order.id}';
    final secondLine = '${order.items.join(", ")} (${order.items.length} item${order.items.length > 1 ? 's' : ''})';
    final thirdLine = order.buyer != null ? 'Buyer: ${order.buyer}' : 'Farmer: ${order.farmer}';

    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: order id and status tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                firstLine,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              _buildStatusTag(),
            ],
          ),

          SizedBox(height: 8),

          // Middle row: items + emojis and total count
          Row(
            children: [
              Expanded(
                child: Text(
                  secondLine,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Row(children: _itemIcons()),
            ],
          ),

          SizedBox(height: 8),

          // Bottom row: buyer/farmer label and right icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                thirdLine,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              _buildIcons(),
            ],
          ),
        ],
      ),
    );
  }
}

Widget OrderCard(OrderModel order)
{
  return Container(
    margin: EdgeInsets.only(bottom: 14),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row: order id and status tag
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Order #${order.orderId}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            _buildStatusTag(order.status),
          ],
        ),

        SizedBox(height: 8),

        // Middle row: items + emojis and total count
        Row(
          children: [
            Expanded(
              child: Text(
                "${order.productName}e(" ")} (${order.quantity} item${order.quantity > 1 ? 's' : ''})",
                style: TextStyle(fontSize: 14),
              ),
            ),
            // Row(children: _itemIcons()),
          ],
        ),

        SizedBox(height: 8),

        // Bottom row: buyer/farmer label and right icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              order.sellerUid,
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
            _buildIcons(order.status),
          ],
        ),
      ],
    ),
  );
}

Color _getStatusColor(String status) {
  switch (status) {
    case "pending":
      return Colors.orange;
    case "ongoing":
      return Colors.green;
    case "completed":
      return Colors.green.shade700;
    default:
      return Colors.grey;
  }
}

String _getStatusText(String status) {
  switch (status) {
    case "pending":
      return "Pending";
    case "ongoing":
      return "Ongoing";
    case "completed":
      return "Completed";
    default :
      return "Pending";
  }
}

Widget _buildStatusTag(String status) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: _getStatusColor(status),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      _getStatusText(status),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),
  );
}

Widget _buildIcons(String status) {
  // For demo, use simple icons matching the type of order items, or simpler icons
  if (status == OrderStatus.pending || status == OrderStatus.ongoing) {
    // Delivery truck icon to right
    return Icon(Icons.local_shipping, color: Colors.green);
  }
  if (status == OrderStatus.completed) {
    return Icon(Icons.check_circle, color: Colors.green);
  }
  return SizedBox();
}