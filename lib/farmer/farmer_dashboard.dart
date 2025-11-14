import 'package:flutter/material.dart';
import 'package:hktn/widget/support_widget.dart';

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({Key? key}) : super(key: key);

  final Color green = const Color(0xFF3DA942);
  final Color lightGreen = const Color(0xFFDBF0DB);
  final Color backgroundGreen = const Color(0xFFF1F8F1);

  Widget buildTimeFilterButton(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: selected ? green.withOpacity(0.2) : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selected ? green : Colors.grey.shade600,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget buildStatCard({required Widget content}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: content,
      ),
    );
  }

  Widget buildBar(double height, double maxValue, String topLabel, String bottomLabel) {
    double barHeight = (height / maxValue) * 80;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(topLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.green.shade900)),
        const SizedBox(height: 4),
        Container(
          width: 16,
          height: 80,
          decoration: BoxDecoration(color: lightGreen, borderRadius: BorderRadius.circular(8)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: barHeight,
              decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(bottomLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey.shade800)),
      ],
    );
  }

  Widget buildTransactionItem({
    required String productName,
    required String productWeight,
    required String dateTime,
    required String amount,
    required Color amountColor,
    required String productImageUrl,
    required IconData paymentIcon,
    required IconData bankIcon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(radius: 22, backgroundImage: NetworkImage(productImageUrl)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$productName - $productWeight',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                  Text(dateTime,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey.shade600)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(amount,
                    style: TextStyle(color: amountColor, fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(paymentIcon, color: green, size: 18),
                    const SizedBox(width: 6),
                    Icon(bankIcon, color: green, size: 18),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<double> bars = [2200, 2800, 350, 3800, 3300, 780, 350];
    final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    final List<String> topLabels = ["2.2K", "2.8K", "3.8K", "3.3K", "2.5K", "3.9K", "2.3K"];

    return Scaffold(
      backgroundColor: backgroundGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  const Icon(Icons.eco, color: Color(0xFF3DA942), size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 19, color: Colors.black87, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(text: 'Good Morning, '),
                          TextSpan(text: 'Rahim ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: '✌️'),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.green.shade300,
                    backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=12'),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Filters
              Row(
                children: [
                  buildTimeFilterButton("This Week", true),
                  const SizedBox(width: 10),
                  buildTimeFilterButton("This Month", false),
                ],
              ),
              const SizedBox(height: 18),

              // Stats
              Row(
                children: [
                  buildStatCard(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Earnings',
                            style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text("₹12,540",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87)),
                            const Spacer(),
                            Icon(Icons.trending_up, color: green, size: 20),
                            const SizedBox(width: 4),
                            Text('+8%',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: green)),
                            const SizedBox(width: 6),
                            Icon(Icons.monetization_on, size: 20, color: green),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buildStatCard(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Sales',
                            style: TextStyle(color: Colors.grey.shade900, fontWeight: FontWeight.w600, fontSize: 14)),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.shopping_basket_outlined, color: green, size: 28),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('32 Orders',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
                                SizedBox(height: 2),
                                Text('Compared to last week',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),


              Row(
                children: [
                  buildStatCard(
                    content: Row(
                      children: [
                        // Tomato image (circular)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            'https://i.imgur.com/yJw73sF.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Top Product',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Text(
                                    'Tomatoes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: green.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Icon(
                                      Icons.eco,
                                      color: green,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // Weekly chart
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bar_chart_outlined, color: green, size: 20),
                        const SizedBox(width: 10),
                        Text('Weekly Earnings Overview',
                            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        days.length,
                            (index) => buildBar(bars[index], 4000, topLabels[index], days[index]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Transactions
              const Text('Recent Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 14),
              buildTransactionItem(
                productName: 'Tomatoes',
                productWeight: '5 kg',
                dateTime: 'Oct 30, 2025 - 10:32 AM',
                amount: '+₹320',
                amountColor: Colors.green.shade700,
                productImageUrl: 'https://i.imgur.com/yJw73sF.png',
                paymentIcon: Icons.phone_iphone,
                bankIcon: Icons.account_balance,
              ),
              buildTransactionItem(
                productName: 'Red Onion',
                productWeight: '2 kg',
                dateTime: 'Oct 30, 2025 - 9:15 AM',
                amount: '+₹180',
                amountColor: Colors.green.shade700,
                productImageUrl: 'https://i.imgur.com/RY7NrR1.png',
                paymentIcon: Icons.account_balance,
                bankIcon: Icons.monetization_on,
              ),

              const SizedBox(height: 14),

              // Withdraw button
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.account_balance_wallet_rounded, size: 22,color: AppWidget().whiteColor),
                      label: Text('Withdraw Earnings',
                          style: AppWidget.QuickSandWhiteSizeBold(16)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: green,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.info_outline, size: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
