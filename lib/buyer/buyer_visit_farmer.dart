import 'package:flutter/material.dart';
import 'package:hktn/db/db.dart';

import '../ banner/template_green.dart';
import '../widget/support_widget.dart';
import 'buyer_homepage.dart';

class BuyerVisitFarmer extends StatefulWidget {
  @override
  _BuyerVisitFarmerState createState() => _BuyerVisitFarmerState();
}

class _BuyerVisitFarmerState extends State<BuyerVisitFarmer> {

  final vegs = ProductList();

  // For selectable delivery method buttons
  String selectedDeliveryMethod = "Pickup";

  // Example cart item counts
  int tomatoCount = 0;
  int cucumberCount = 0;

  // Example subtotal calculation
  double tomatoPrice = 60;
  double cucumberPrice = 60;

  @override
  Widget build(BuildContext context) {
    double subtotal = (tomatoCount * tomatoPrice) + (cucumberCount * cucumberPrice);
    int totalItems = tomatoCount + cucumberCount;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top padding and back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.green,
                      size: 28,
                    ),
                  ),
                  Spacer(),
                  // Favorite icon
                  Icon(Icons.favorite_border, color: Colors.orange, size: 28),
                  SizedBox(width: 20),
                  // Message icon
                  Icon(Icons.report_outlined, color: Colors.red, size: 28),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFarmerInfoCard(),

                    SizedBox(height: 18),

                    _buildAboutFarmSection(),

                    SizedBox(height: 18),

                    _buildProductListingArea(),

                    SizedBox(height: 25),

                    // Delivery method and ETA section
                    _buildDeliverySelection(),

                    SizedBox(height: 20),

                    _buildLogisticsOverview(),

                    SizedBox(height: 20),

                    _buildProductSection(),

                    SizedBox(height: 25),

                    _buildBusinessPolicyInfo(),
                  ],
                ),
              ),
            ),

            // Cart summary bar
            if (totalItems > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$totalItems item${totalItems > 1 ? 's' : ''} · ₹${subtotal.toStringAsFixed(0)} Subtotal",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Go to cart
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          "View Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmerInfoCard() {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFEAF3E9), // light green background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Farmer profile photo
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/13.jpg'), // example profile image
          ),

          SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and farm
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                    children: [
                      TextSpan(text: "Abdul Karim – "),
                      TextSpan(
                        text: "Karim's Farm",
                        style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4),

                // Location & distance
                Row(
                  children: [
                    Icon(Icons.location_pin, size: 16, color: Colors.grey[700]),
                    SizedBox(width: 4),
                    Text(
                      "Kumira, Sitakunda (25 km away)",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                // ID & Phone verified label + message icon
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                          SizedBox(width: 4),
                          Text(
                            "ID & Phone verified",
                            style: TextStyle(fontSize: 12, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.mode_comment_outlined, color: Colors.green, size: 28),
                  ],
                ),

                SizedBox(height: 8),

                // Reviews
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    SizedBox(width: 4),
                    Text(
                      "(27 reviews)",
                      style: TextStyle(fontSize: 12, color: Colors.orange[700]),
                    )
                  ],
                ),

                SizedBox(height: 6),

                // Farm info line
                Text(
                  "Natural farming since 2012",
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),

                SizedBox(height: 10),

                // Action buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _actionButton("Message", Icons.message_outlined, Colors.green, () {
                      // Message action
                    }),
                    _actionButton("Call", Icons.call, Colors.green, () {
                      // Call action
                    }),
                    _actionButton("Follow", Icons.person_add_alt_1_sharp, Colors.green, () {
                      // Follow action
                    }),
                    // _actionButton("Report", Icons.flag_outlined, Colors.red, () {
                    //   // Report action
                    // }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, Color bgColor, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAboutFarmSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About the Farm",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 6),
        Text(
          "Family-run farm cultivating pesticide-free since 2012. Daily harvest and morning dispatch.",
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),

        // Tags row
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _buildTag("Organic"),
            _buildTag("Community Verified"),
            _buildTag("Fresh Harvest"),
            _buildTag("Low Carbon"),
          ],
        ),

        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            // View farm photos action
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("View Farm Photos", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.green.shade100, borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green.shade700),
      ),
    );
  }

  Widget _buildProductListingArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Product Listing Area",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.star, color: Colors.orange, size: 20),
            SizedBox(width: 6),
            Text(
              "4.8 (127 reviews)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )
          ],
        ),
        SizedBox(height: 10),

        // License with photo and rating
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/13.jpg'), // same profile photo
              radius: 16,
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Organic License PDF",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    Icon(Icons.star_half, color: Colors.orange, size: 16),
                  ],
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.picture_as_pdf_rounded,
              color: Colors.green,
              size: 24,
            )
          ],
        ),

        SizedBox(height: 14),

        Text(
          "Refund Policy: Report issues within 24h for refund or credit",
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),

        SizedBox(height: 8),

        Text(
          "Cancel Policy: Report issues within atd 2% (Excellent reliability)",
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildDeliverySelection() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedDeliveryMethod = "Pickup";
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: selectedDeliveryMethod == "Pickup" ? Colors.green : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(22),
              ),
              alignment: Alignment.center,
              child: Text(
                "Pickup",
                style: TextStyle(
                  color: selectedDeliveryMethod == "Pickup" ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedDeliveryMethod = "Delivery";
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: selectedDeliveryMethod == "Delivery" ? Colors.green : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(22),
              ),
              alignment: Alignment.center,
              child: Text(
                "Delivery",
                style: TextStyle(
                  color: selectedDeliveryMethod == "Delivery" ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogisticsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Logistics Overview",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 12),
        _buildLogisticsSearchAndSort(),

        SizedBox(height: 10),

        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _buildLogisticsFilterChip("Category"),
            _buildLogisticsFilterChip("Price"),
            _buildLogisticsFilterChip("Freshness"),
            _buildLogisticsFilterChip("Availability"),
            _buildLogisticsFilterChip("Organic"),
          ],
        ),
      ],
    );
  }

  Widget _buildLogisticsSearchAndSort() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(Icons.search, size: 20, color: Colors.grey[600]),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search within farm",
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            // Sort action
          },
          child: Text(
            "Sort",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildLogisticsFilterChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey.shade200,
      labelStyle: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey[700]),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }

  Widget _buildProductSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Section",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: 14),

        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: AppWidget().fixPadding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              productlist.items.length,
                  (index) {
                final recommendedItemData = productlist.items[index];
          
                return TemplateGreen(data: recommendedItemData,index: index,);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required String imageUrl,
    required String title,
    required double pricePerKg,
    required int availableKg,
    required int reviewsCount,
    required double rating,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 7, offset: Offset(0, 4))],
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with badge on top-left
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Fresher",
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),

          SizedBox(height: 6),

          Text(
            "₹${pricePerKg.toStringAsFixed(0)} / kg",
            style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.bold, fontSize: 14),
          ),

          SizedBox(height: 4),

          Text(
            "$availableKg kg available",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),

          SizedBox(height: 4),

          Row(
            children: [
              Icon(Icons.star, color: Colors.orange, size: 14),
              SizedBox(width: 4),
              Text(
                "$rating (${reviewsCount} reviews)",
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),

          SizedBox(height: 10),

          // Quantity selector and add to cart button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove, size: 20),
                      onPressed: onDecrement,
                      splashRadius: 20,
                    ),
                    Text(
                      "$count",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, size: 20),
                      onPressed: onIncrement,
                      splashRadius: 20,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  elevation: 0,
                ),
                onPressed: () {
                  // Add to cart action
                },
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBusinessPolicyInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Business & Policy Info",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),

        SizedBox(height: 12),

        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/13.jpg'), // profile photo
              radius: 20,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fredrin Karim's Farm", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("20 3-17 AM", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),

        SizedBox(height: 14),

        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/8/87/PDF_file_icon.svg'), // pdf icon URL or local asset could be used
              radius: 20,
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Organic License PDF", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("2018-11 AM", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ],
    );
  }
}