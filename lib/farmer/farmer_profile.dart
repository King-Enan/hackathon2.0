import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hktn/buyer/order_details.dart';
import 'package:hktn/local_db/user/local_user.dart';
import 'package:hktn/sign_in.dart';
import 'package:hktn/widget/support_widget.dart';

import '../firebase_services/firebase_logout.dart';
import '../models/user_modal.dart';

class FarmerProfile extends StatefulWidget {
  @override

  _FarmerProfileState createState() => _FarmerProfileState();
}

//final userData = getLocalUser() ;
UserModel? userData;
class _FarmerProfileState extends State<FarmerProfile> {

  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    final data = box.read('user');
    if (data != null) {
      setState(() {
        userData = UserModel.fromMap(Map<String, dynamic>.from(data));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA), // Light background color
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button, title, settings icon
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      // Navigator.of(context).pop();
                    },
                  ),
                  Text(
                      "Profile",
                      style: AppWidget.QuickSandGreySizeBold(22)
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      // Handle settings tap
                    },
                  )
                ],
              ),
            ),

            SizedBox(height: 30),

            // Profile picture with border
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 10,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 46,
                  backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=12'), // Example avatar image
                ),
              ),
            ),

            SizedBox(height: 15),

            // Name and subtitle
            Text(
              userData!.firstName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Alam Cafe',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 20),

            // Contact info row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Phone
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.green, size: 18),
                      SizedBox(width: 6),
                      Text(
                        userData!.phone,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),

                  // Email
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.green, size: 18),
                      SizedBox(width: 6),
                      Text(
                        userData!.email,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),


                ],
              ),
            ),

            SizedBox(height: 25),

            // Menu options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildMenuOption(
                    icon: Icons.list_alt,
                    text: "My Orders",
                    onTap: () {
                      // Handle My Orders tap
                      Get.to(OrderDetails());
                    },
                  ),
                  SizedBox(height: 12),
                  _buildMenuOption(
                    icon: Icons.credit_card,
                    text: "Payment Methods",
                    onTap: () {
                      // Handle Payment Methods tap
                    },
                  ),
                  SizedBox(height: 12),
                  _buildMenuOption(
                    icon: Icons.settings,
                    text: "Settings",
                    onTap: () {
                      // Handle Settings tap
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 25),

            // Optional stats section label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Optional Stats / Section',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            SizedBox(height: 15),

            // Stats row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatBox('21', 'Total Orders'),
                  _buildStatBox('140', 'Active Orders'),
                  _buildStatBox('160', 'Outstanding Payments'),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildMenuOption(
                icon: Icons.logout,
                text: "Log Out",
                onTap: () {
                  // Handle Settings tap
                  _onLogoutPressed(context);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      elevation: 3,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 52,
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(icon, color: Colors.green),
              SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String number, String title) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              number,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _onLogoutPressed(BuildContext context) async {
    try {
      await FirebaseLogoutService.logoutUser();

      Get.to(SignIN());
      print("✅✅✅");

      final data = getLocalUser();
      print(data!.firstName);
      print(data!.email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully! 👋')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

}