// A simple header for category titles
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';

class CategoryHeader extends StatelessWidget {
  final String title;

  const CategoryHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
      ),
    );
  }
}
