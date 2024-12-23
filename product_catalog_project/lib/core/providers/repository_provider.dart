import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/providers/network_provider.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/product/cache/category_cache_manager.dart';
import 'package:product_catalog_project/product/cache/product_cache_manager.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final networkManager = ref.watch(projectNetworkManagerProvider);
  final CategoryCacheManager cacheManager = CategoryCacheManager();
  return CategoryRepository(networkManager, cacheManager);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final networkManager = ref.watch(projectNetworkManagerProvider);
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  final ProductCacheManager cacheManager = ProductCacheManager();
  return ProductRepository(networkManager, categoryRepository, cacheManager);
});
