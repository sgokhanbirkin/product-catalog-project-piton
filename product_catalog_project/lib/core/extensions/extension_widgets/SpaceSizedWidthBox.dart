// ignore_for_file: file_names, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';

class SpaceSizedWidthBox extends StatelessWidget {
  final double width;

  const SpaceSizedWidthBox({required this.width, super.key})
      : assert(width > 0 && width <= 1);
  @override
  Widget build(BuildContext context) => SizedBox(width: context.width * width);
}
