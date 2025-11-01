import 'package:flutter/material.dart';
import 'package:hktn/widget/support_widget.dart';
class RectangleBox extends StatefulWidget {
  String name;
  bool isSelect;
  RectangleBox({super.key,required this.name,required this.isSelect});

  @override
  State<RectangleBox> createState() => _RectangleBoxState();
}

class _RectangleBoxState extends State<RectangleBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(right: 10),
      height: 30,
      decoration: BoxDecoration(
        color: widget.isSelect?AppWidget().primaryColor:AppWidget().whiteColor,
        borderRadius: BorderRadius.circular(5),
        //boxShadow: AppWidget().boxShadowPrimary,
        border: Border.all( // Add border
          color: AppWidget().greyColor.withOpacity(.1), // Change to your preferred color
          width: 1.5, // Adjust thickness
        ),
      ),
      child: Text(widget.name,
        style: widget.isSelect?AppWidget.QuickSandWhiteSize(16):AppWidget.QuickSandGreySize(16),
      ),
    );
  }
}
