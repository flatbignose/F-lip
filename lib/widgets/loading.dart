import 'package:flutter/material.dart';
import '../multi_use/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: secondColor,
      ),
    );
  }
}
