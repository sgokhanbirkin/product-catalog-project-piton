import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/providers/network_provider.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final networkManager = ref.watch(projectNetworkManagerProvider);
  return ProductRepository(
    networkManager,
    ref.watch(categoryRepositoryProvider),
  );
});

final categoryRepositoryProvider = Provider<CategoryRepository>(
  (ref) {
    final networkManager = ref.watch(projectNetworkManagerProvider);
    return CategoryRepository(networkManager);
  },
);
