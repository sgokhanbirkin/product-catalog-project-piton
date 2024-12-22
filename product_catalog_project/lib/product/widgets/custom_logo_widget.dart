// lib/features/auth/widgets/logo_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/product/utility/constants/product_constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    this.size,
  });
  final double? size;
  @override
  Widget build(BuildContext context) {
    const assetName = ProductConstants.logoAssetPath;

    return Center(
      child: SvgPicture.asset(
        assetName,
        width: context.width * 0.35,
      ),
    );
  }
}
