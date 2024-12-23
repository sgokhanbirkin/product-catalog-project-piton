import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/models/product.dart';

abstract class ICacheManager<T> {
  final String key;
  Box<T>? box;

  ICacheManager(this.key);

  Future<void> init() async {
    await Hive.initFlutter();
    registerAdapters();
    if (!(box?.isOpen ?? false)) {
      box = await Hive.openBox<T>(key);
    }
  }

  void registerAdapters() {
    Hive
      ..registerAdapter(
        CategoryAdapter(),
      )
      ..registerAdapter(
        ProductAdapter(),
      );
  }

  Future<void> addItems(List<T> items);

  Future<void> putItems(List<T> items);

  T? getItem(String key);

  List<T>? getValues();

  Future<void> putItem(String key, T item);

  Future<void> removeItem(String key);

  T? getSingleItem() {
    return this.getItem(this.key);
  }

  Future<void> putSingleItem(T item) {
    return this.putItem(this.key, item);
  }

  Future<void> removeSingleItem() {
    return this.removeItem(this.key);
  }

  Future<void> clearAll() async {
    await box?.clear();
  }
}
