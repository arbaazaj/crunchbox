import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';

class CustomButtonWithBorder extends StatelessWidget {
  final String buttonText;
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomButtonWithBorder({
    super.key,
    required this.buttonText,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(
        buttonText,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
      icon: Icon(iconData, color: AppColors.primary, size: 20),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.background),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8.0),
            side: BorderSide(
              color: AppColors.primary,
              style: BorderStyle.solid,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
