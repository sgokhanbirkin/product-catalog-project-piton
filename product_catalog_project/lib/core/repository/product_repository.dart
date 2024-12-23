import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';
import 'package:product_catalog_project/product/cache/product_cache_manager.dart'; // Import the cache manager

@injectable
class ProductRepository {
  ProductRepository(
    this._networkManager,
    this._categoryRepository,
    this._productCacheManager,
  ) : _productBox = Hive.box<Product>('products');

  final ProjectNetworkManager _networkManager;
  final CategoryRepository _categoryRepository;
  final ProductCacheManager _productCacheManager; // Cache manager

  final Box<Product> _productBox;

  // Retrieve all products from the cache
  List<Product> getAllProducts() {
    return _productBox.values.toList();
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      print('Fetching products for category $categoryId');
      final response = await _networkManager.dio.get('/products/$categoryId');
      if (response.statusCode == 200) {
        // Check if 'product' key exists and is not null
        final dynamicResponse = response.data['product'] as List<dynamic>;
        // Convert response data into Product objects
        print('Converting response data to Product objects');

        var products = Product.fromJsonList(dynamicResponse);

        print('________________-  ');
        print('Fetched products: $products');
        // Store fetched products in the cache
        final categoryBox = await Hive.openBox<Product>('category_$categoryId');
        await categoryBox.clear(); // Clear any old data
        await categoryBox.addAll(products); // Add new products for the category
      }
    } on DioException catch (e) {
      print('Network error: $e');
      throw Exception('Beklenmeyen bir hata oluştu : $e');
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu : $e');
    }
  }

  // Load products from cache and from the API if necessary
  Future<dynamic> loadProducts() async {
    // First, attempt to load products from cache
    final cachedProducts = _productCacheManager.getValues();

    if (cachedProducts != null && cachedProducts.isNotEmpty) {
      return cachedProducts;
    } else {
      // If cache is empty, fetch products from the API
      await _categoryRepository.fetchCategories(); // Fetch categories first
      final allProducts = await _categoryRepository
          .fetchCategories(); // Adjust based on your fetching logic
      return allProducts;
    }
  }

  Future<List<Product>> getProductsByCategory(int categoryId) async {
    try {
      // Hive'da "products" box'ını açıyoruz
      final Box<Product> productBox =
          await Hive.openBox<Product>('category_$categoryId');

      // Verilen kategoriye ait ürünleri filtreleyerek döndürüyoruz
      final List<Product> productsInCategory = productBox.values.toList();
      return productsInCategory;
    } catch (e) {
      print("Hata: $e");
      throw Exception('Ürünler alınırken bir hata oluştu');
    }
  }

  Future<String> getImageUrl({required String productFileName}) async {
    try {
      // Doğru URL ile POST isteği gönderme
      final response = await _networkManager.postData(
        endpoint: '/cover_image',
        data: {
          'fileName': productFileName,
        },
      );

      // Status code kontrolü
      if (response.statusCode == 200) {
        // 'url' değerini doğru şekilde alıyoruz
        if (response.data != null && response.data is Map) {
          return response.data['action_product_image']["url"] as String;
        } else {
          throw Exception('Response data is not in expected format');
        }
      } else {
        throw Exception(
            'Beklenmeyen bir hata oluştu, Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu: $e');
    }
  }
}
