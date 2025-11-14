import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hktn/services/product_service.dart';
import 'package:hktn/widget/support_widget.dart';

import '../local_db/user/local_user.dart';
import '../models/product_model.dart';

class FarmerUploadProduct extends StatefulWidget {
  const FarmerUploadProduct({Key? key}) : super(key: key);

  @override
  State<FarmerUploadProduct> createState() => _FarmerUploadProductState();
}

class _FarmerUploadProductState extends State<FarmerUploadProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  //final TextEditingController productImageController = TextEditingController();
  //final TextEditingController descriptionController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  String? selectedType;
  String imgUrl = "no Url";
  String stock = "Available";

  //final box = GetStorage();
  final userData = getLocalUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E9EF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Header Bar
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.green),
                        onPressed: () {
                           Get.back();
                        },
                      ),
                      const Text(
                        'Upload Product',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade300,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Image and input fields on top
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Upload Image Box
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.camera_alt, color: Colors.green, size: 48),
                                      SizedBox(height: 8),
                                      Text(
                                        'Upload Image',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ),
                                // Dollar sign circle top right
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.orange.shade300,
                                    child: const Text(
                                      '\$',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),

                            const SizedBox(width: 16),

                            // Input fields: Product Name, Quantity, Price stacked
                            Expanded(
                              child: Column(
                                children: [
                                  _iconTextField(
                                    controller: productNameController,
                                    icon: Icons.label,
                                    labelText: 'Product Name',
                                  ),
                                  const SizedBox(height: 12),
                                  _iconTextField(
                                    controller: quantityController,
                                    icon: Icons.scale,
                                    labelText: 'Quantity in kg',
                                    keyboardType: TextInputType.number,
                                  ),
                                  const SizedBox(height: 12),
                                  _iconTextField(
                                    controller: priceController,
                                    icon: Icons.attach_money,
                                    labelText: 'Price per kg',
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _iconDropdown(
                          icon: Icons.category,
                          labelText: 'Select Product Type',
                          items: productTypes,
                          selectedValue: selectedType,
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                        ),


                        const SizedBox(height: 22),

                        // Description label and short description input
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: TextField(
                                  controller: shortDescriptionController,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: 'Write a short description of your product',
                                  ),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Save Product button
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validation check
                              if (productNameController.text.isEmpty ||
                                  selectedType == null ||
                                  priceController.text.isEmpty) {
                                Get.snackbar('Error', 'Please fill all required fields');
                                return;
                              }

                              try {
                                // Prepare ProductModel
                                final product = ProductModel(
                                  productName: productNameController.text.trim(),
                                  category: selectedType!,
                                  description: shortDescriptionController.text.trim(),
                                  farmName: userData!.firstName,
                                  imageURL:
                                  'https://media.istockphoto.com/id/1203599923/photo/food-background-with-assortment-of-fresh-organic-vegetables.jpg?s=612x612&w=0&k=20&c=DZy1JMfUBkllwiq1Fm_LXtxA4DMDnExuF40jD8u9Z0Q=',
                                  price: double.parse(priceController.text.trim()),
                                  sellerUid: userData!.email,
                                  status: 'available',
                                  stock: int.tryParse(quantityController.text.trim()) ?? 0,
                                  createdAt: Timestamp.now(),
                                );

                                // Upload to Firestore
                                await ProductService().addProduct(product);

                                Get.back();
                                // Show success message
                                Get.snackbar('✅ Success', 'Product uploaded successfully');

                                // Clear form fields
                                productNameController.clear();
                                shortDescriptionController.clear();
                                priceController.clear();
                                quantityController.clear();
                                selectedType = null;

                                // setState(() {});

                                // ✅ Navigate back only after upload success
                                Get.back();

                              } catch (e) {
                                Get.snackbar('❌ Error', e.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Upload Product',
                              style: AppWidget.KumbhSansWhiteSizeBold(16),
                            ),
                          ),
                        ),



                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconTextField({
    required TextEditingController controller,
    required IconData icon,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          hintText: labelText,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  // Outside the widget — your dropdown items list
  final List<String> productTypes = [
    'Vegetable',
    'Fruit',
    'Meat',
    'Spinach',
  ];


// Reusable dropdown widget
  Widget _iconDropdown({
    required IconData icon,
    required String labelText,
    required List<String> items,
    required String? selectedValue,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 10),

          // Dropdown
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.white, // dropdown menu background
                shadowColor: Colors.black.withOpacity(0.1),
                dialogBackgroundColor: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedValue,
                  hint: Text(
                    labelText,
                    style: AppWidget.QuickSandBlackSize(16),
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.white, // dropdown menu background
                  borderRadius: BorderRadius.circular(12), // round dropdown corners
                  items: items
                      .map(
                        (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: AppWidget.QuickSandBlackSize(16),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: onChanged,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}