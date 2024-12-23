import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';
import 'package:product_catalog_project/product/cache/category_cache_manager.dart';

@injectable
class CategoryRepository {
  CategoryRepository(this._networkManager, this._categoryCacheManager);

  final ProjectNetworkManager _networkManager;
  final CategoryCacheManager _categoryCacheManager;

  // Fetch categories from API or local storage (Hive)
  Future<List<Category>> fetchCategories() async {
    // First, try to get categories from cache
    List<Category>? cachedCategories = _categoryCacheManager.getValues();

    // If categories exist in cache, return them
    if (cachedCategories != null && cachedCategories.isNotEmpty) {
      return cachedCategories;
    } else {
      // If not, fetch categories from API
      try {
        final response = await _networkManager.dio.get('/categories');
        if (response.statusCode == 200) {
          final dynamicResponse = response.data['category'] as List<dynamic>;

          // Convert response data into Category objects
          List<Category> categories = dynamicResponse.map((item) {
            return Category.fromJson(item as Map<String, dynamic>);
          }).toList();

          // Cache the fetched categories in Hive
          await _categoryCacheManager.putItems(categories);

          print('Categories successfully saved to cache');
          return categories;
        } else {
          throw Exception('Failed to load categories');
        }
      } catch (e) {
        throw Exception('Error fetching categories: $e');
      }
    }
  }
}
