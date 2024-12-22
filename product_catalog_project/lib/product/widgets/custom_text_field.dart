// lib/widgets/custom_text_field.dart

import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.fillColor = const Color(0xFFF4F4FF), // Default background color
    this.errorNotifier, // Add errorNotifier parameter
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final Color fillColor;
  final ValueNotifier<String?>? errorNotifier; // Optional errorNotifier

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.lowValue,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true, // Enable the fill color
              fillColor:
                  fillColor, // Set the background color of the text field
              border: InputBorder.none, // Remove border
            ),
          ),
        ),
        // Listen to errorNotifier and display the error
        if (errorNotifier != null)
          ValueListenableBuilder<String?>(
            valueListenable: errorNotifier!,
            builder: (context, error, child) {
              if (error != null) {
                return Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        SizedBox(
          height: context.lowValue,
        ),
      ],
    );
  }
}
