import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TxtField1 extends StatelessWidget {
  final TextEditingController? controller;
  final hintText;
  final bool obscureText;

  const TxtField1({super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: 1, //text field koto boro hobe
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.grey.shade200,
        filled: false,
        hintText: hintText,
        hintStyle: GoogleFonts.quicksand(
          color: Colors.grey[500],
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}