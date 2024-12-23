import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.onPressed,
    required this.buttonText,
    super.key,
  });
  final VoidCallback onPressed;
  final Widget buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEF6B4A),
        borderRadius: BorderRadius.circular(10),
      ),
      width: context.width * 0.93,
      height: context.height * 0.075,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEF6B4A), // Buton rengi
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Butonun yuvarlak köşeleri
          ),
        ),
        onPressed: onPressed,
        child: buttonText,
      ),
    );
  }
}
