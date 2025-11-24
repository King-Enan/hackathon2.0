import 'package:flutter/material.dart';
import 'package:hktn/widget/support_widget.dart';
import 'package:lottie/lottie.dart';
class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/loading/loading.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            //SizedBox(height: 5),
            Lottie.asset(
              'assets/loading/loading_dots.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
