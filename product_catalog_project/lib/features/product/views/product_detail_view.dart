// lib/features/product/views/product_detail_view.dart

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ProductDetailView extends StatelessWidget {
  final int productId;

  const ProductDetailView({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ürün Detayı'),
      ),
      body: Center(
        child: Text('Ürün ID: $productId'),
      ),
    );
  }
}
