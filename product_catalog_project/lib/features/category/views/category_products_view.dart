// lib/features/category/views/category_products_view.dart

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CategoryProductsView extends StatelessWidget {
  const CategoryProductsView({
    required this.categoryId,
    super.key,
  });
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori Ürünleri'),
      ),
      body: Center(
        child: Text('Kategori ID: $categoryId'),
      ),
    );
  }
}
