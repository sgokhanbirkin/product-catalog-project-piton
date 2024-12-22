// ignore_for_file: file_names, sort_constructors_first, prefer_asserts_with_message

import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';

class SpaceSizedHeightBox extends StatelessWidget {
  final double height;

  const SpaceSizedHeightBox({required this.height, super.key})
      : assert(height > 0 && height <= 1);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: context.height * height);
  }
}
