import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/core/models/product.dart';

final productDetailViewModelProvider = Provider<ProductDetailViewModel>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return ProductDetailViewModel(productRepository);
});

class ProductDetailViewModel {
  final ProductRepository productRepository;

  ProductDetailViewModel(this.productRepository);

  Future<Product> fetchProductDetails(int productId) async {
    try {
      return await productRepository.getProductById(productId);
    } catch (e) {
      throw Exception('Failed to load product details');
    }
  }

  Future<String> getImageUrl(String cover) async {
    final imageUrl =
        await productRepository.getImageUrl(productFileName: cover);

    return imageUrl;
  }
}
