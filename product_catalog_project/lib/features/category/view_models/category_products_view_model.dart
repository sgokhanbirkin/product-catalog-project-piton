// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';

import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/features/category/state/category_products_state.dart';

final categoryProductsViewModelProvider =
    StateNotifierProvider<CategoryProductsViewModel, CategoryProductsState>(
  (ref) {
    final _productRepository = ref.read(productRepositoryProvider);
    return CategoryProductsViewModel(_productRepository);
  },
);

class CategoryProductsViewModel extends StateNotifier<CategoryProductsState> {
  final ProductRepository productRepository;

  CategoryProductsViewModel(this.productRepository)
      : super(CategoryProductsState());

  // Refactor to get the image URL like in the HomeViewModel
  Future<String> getImageUrl(String cover) async {
    try {
      final imageUrl =
          await productRepository.getImageUrl(productFileName: cover);
      return imageUrl;
    } catch (e) {
      throw Exception("Failed to fetch image URL: $e");
    }
  }

  Future<String> getCategoryName({required int categoryId}) async {
    try {
      final categoryName =
          await productRepository.getCategoryName(categoryId: categoryId);
      return categoryName;
    } catch (e) {
      throw Exception("Failed to fetch category name: $e");
    }
  }
}
