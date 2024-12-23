import 'package:hive/hive.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/product/cache/cache_manager.dart';

class ProductCacheManager extends ICacheManager<Product> {
  ProductCacheManager() : super('products_cache');

  @override
  void registerAdapters() {
    Hive
      ..registerAdapter(ProductAdapter())
      ..registerAdapter(LikesAggregateAdapter())
      ..registerAdapter(AggregateAdapter());
  }

  @override
  Future<void> addItems(List<Product> items) async {
    for (final product in items) {
      await box?.add(product);
    }
  }

  @override
  Future<void> putItems(List<Product> items) async {
    for (final product in items) {
      await box?.put(product.id, product);
    }
  }

  @override
  Future<void> putItem(String key, Product item) async {
    await box?.put(key, item);
  }

  @override
  Product? getItem(String key) {
    return box?.get(key);
  }

  @override
  List<Product>? getValues() {
    return box?.values.toList();
  }

  @override
  Future<void> removeItem(String key) async {
    await box?.delete(key);
  }

  @override
  Future<void> clearAll() async {
    await box?.clear();
  }

  getValuesByCategory(int categoryId) {}
}
