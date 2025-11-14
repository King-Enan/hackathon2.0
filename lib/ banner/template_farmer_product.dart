import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hktn/farmer/farmer_update_product.dart';
import 'package:hktn/models/product_model.dart';
import 'package:hktn/services/product_service.dart';
import 'package:hktn/widget/support_widget.dart';
class TemplateFarmerProduct extends StatefulWidget {
  //final Map<String, dynamic> product;
  final ProductModel product;
  //final List<ProductModel> product;
  int index;
  //final VoidCallback onDelete;
  //final Future<void> Function() onDelete;

  TemplateFarmerProduct({super.key,required this.product,required this.index,
    //required this.onDelete
   });
  @override
  State<TemplateFarmerProduct> createState() => _TemplateFarmerProductState();
}

class _TemplateFarmerProductState extends State<TemplateFarmerProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.product.imageURL,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Product details - expanded for layout
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Quantity: ${widget.product.stock} kg',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹ ${widget.product.price}/kg',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
          ),

          // Status button with glow effect
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 18, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor(widget.product.stock),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: statusColor(widget.product.stock).withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              statusText(widget.product.stock),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Action icons column
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Edit pencil icon (orange color)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.orange,
                  size: 22,
                ),
                onPressed: () {
                  Get.to(FarmerUpdateProduct(product: widget.product, index: widget.index));
                },
              ),
              const SizedBox(height: 10),

              // Upload/share icon (red color)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.upload,
                  color: Colors.redAccent,
                  size: 22,
                ),
                onPressed: () {
                  // Upload/share action
                },
              ),
              const SizedBox(height: 10),

              // Delete icon (red color)
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 22,
                ),
                onPressed: () async {
                  final bool? confirmed = await showDeleteConfirmationDialog(context, widget.product.productName);
                  if (confirmed == true) {
                    await ProductService().deleteProduct(widget.product.productId.toString());
                    Get.snackbar('Deleted', 'Product deleted successfully');
                    //await widget.onDelete();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum ProductStatus { availableGreen, availableRed, soldOut }


  Color statusColor(int stock) {
  if(stock>0)
    {
      return Colors.green.shade600;
    }
  else
    return Colors.red.shade600;
  }

  String statusText(int status) {
  if(status>0)
    return 'Available';
  else
    return 'Sold Out';

  }

/// Widget to show a confirmation dialog with Yes/No buttons for delete confirmation.
Future<bool?> showDeleteConfirmationDialog(BuildContext context, String productName) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap a button
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppWidget().whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Confirm Delete',style: AppWidget.QuickSandBlackSizeBold(22),),
        content: Text('Are you sure you want to delete "$productName"?',style: AppWidget.QuickSandBlackSize(16),),
        actions: <Widget>[
          TextButton(
            child: Text('No',style: AppWidget.QuickSandBlackSize(16)),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false (cancel)
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            child:Text('Yes',style: AppWidget.QuickSandBlackSize(16)),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true (confirmed delete)
            },
          ),
        ],
      );
    },
  );
}