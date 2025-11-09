// lib/screens/add_user_screen.dart

import 'package:flutter/material.dart';

import 'adduser.dart';


class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  // TextEditingControllers for text inputs
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final roleController = TextEditingController();

  // Dropdown selected value
  String? selectedAddress;

  // Manually written addresses
  final List<String> addressList = [
    'Kumira',
    'Shitakundo',
    'Chittagong City',
    'Fouzdarhat',
    'Patenga',
    'Anowara',
    'Patiya',
    'Raozan',
    'Chondonaish',
    'Halishohor Agro Area',
  ];

  final FirestoreSetup firestoreSetup = FirestoreSetup();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    roleController.dispose();
    super.dispose();
  }

  void addUser() async {
    if (selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Please select an address!")),
      );
      return;
    }

    await firestoreSetup.addUserFromControllers(
      nameController: nameController,
      emailController: emailController,
      phoneController: phoneController,
      roleController: roleController,
      addressController: TextEditingController(text: selectedAddress!),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("✅ User added to Firestore!")),
    );

    // Clear all fields after submission
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    roleController.clear();
    setState(() => selectedAddress = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User to Firestore'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role (seller/buyer)'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Address',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Dropdown for addresses
            DropdownButtonFormField<String>(
              value: selectedAddress,
              hint: const Text('Choose an address'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              items: addressList.map((String address) {
                return DropdownMenuItem<String>(
                  value: address,
                  child: Text(address),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAddress = value;
                });
              },
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: addUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Add User to Firestore',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
