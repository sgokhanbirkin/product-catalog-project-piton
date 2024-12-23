import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/features/home/state/home_state.dart';

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  final categoryRepository = ref.read(categoryRepositoryProvider);
  return HomeViewModel(productRepository, categoryRepository);
});

class HomeViewModel extends StateNotifier<HomeState> {
  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;

  HomeViewModel(this._productRepository, this._categoryRepository)
      : super(HomeState());

  Future<void> loadData() async {
    // Verilerin yüklenmesine başla
    state = state.copyWith(isLoading: true);
    try {
      // Kategorileri çek
      final categories = await _categoryRepository.fetchCategories();

      // Kategorilere ait ürünleri çek
      for (final category in categories) {
        await _productRepository.fetchProductsByCategory(category.id);
      }

      // Kategorileri ve ürünleri state'e kaydet
      state = state.copyWith(
        categories: categories,
        products: _productRepository.getAllProducts(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Veriler yüklenemedi',
      );
    }
  }

  Future<String> getImageUrl(String cover) async {
    final imageUrl =
        await _productRepository.getImageUrl(productFileName: cover);

    return imageUrl;
  }
}
