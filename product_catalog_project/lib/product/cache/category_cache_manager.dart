import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/product/cache/cache_manager.dart';

class CategoryCacheManager extends ICacheManager<Category> {
  CategoryCacheManager() : super('categoryBox');

  @override
  Future<void> addItems(List<Category> items) async {
    await box?.addAll(items);
  }

  @override
  Future<void> putItems(List<Category> items) async {
    for (var item in items) {
      await box?.put(item.id, item);
    }
  }

  @override
  Category? getItem(String key) {
    return box?.get(key);
  }

  @override
  List<Category>? getValues() {
    return box?.values.toList();
  }

  @override
  Future<void> putItem(String key, Category item) async {
    await box?.put(key, item);
  }

  @override
  Future<void> removeItem(String key) async {
    await box?.delete(key);
  }
}
