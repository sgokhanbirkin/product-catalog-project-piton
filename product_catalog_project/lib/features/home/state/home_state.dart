import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/models/product.dart';

class HomeState {
  final List<Product> products;
  final List<Category> categories;
  final bool isLoading;
  final String errorMessage;

  HomeState({
    this.products = const [],
    this.categories = const [],
    this.isLoading = false,
    this.errorMessage = '',
  });

  HomeState copyWith({
    List<Product>? products,
    List<Category>? categories,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
