// ignore_for_file: inference_failure_on_function_invocation, unused_catch_clause

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';

@injectable
class ProductRepository {
  ProductRepository(this._networkManager, this._categoryRepository)
      : _productBox = Hive.box<Product>('products');
  final ProjectNetworkManager _networkManager;
  final CategoryRepository _categoryRepository;

  final Box<Product> _productBox;

  Future<List<Product>> fetchAllProducts() async {
    try {
      final categories = await _categoryRepository.fetchCategories();

      final futures =
          categories.map((category) => fetchProductsByCategory(category.id));

      final productsPerCategory = await Future.wait(futures);

      final allProducts =
          productsPerCategory.expand((products) => products).toList();

      await _productBox.clear();
      for (final product in allProducts) {
        await _productBox.put(product.id, product);
      }

      return allProducts;
    } catch (e) {
      throw Exception('Ürünler fetch edilirken bir hata oluştu: $e');
    }
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    try {
      /// API
      final response = await _networkManager.dio.get('/products/$categoryId');
      if (response.statusCode == 200) {
        final products = Product.fromJsonList(response.data as List<dynamic>);
        return products;
      } else {
        throw Exception('Kategoriye ait ürünler yüklenemedi');
      }
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu');
    }
  }
  /* 
  /// API yapısında böyle bir kullanım yok. Tüm productları alamıyoruz.
  Future<List<Product>> fetchProducts() async {
    if (_productBox.isNotEmpty) {
      final firstProduct = _productBox.values.first;
      if (DateTime.now().difference(firstProduct.createdAt).inHours < 24) {
        return _productBox.values.toList();
      }
    }

    try {
      final response = await _networkManager.dio.get('/products');
      if (response.statusCode == 200) {
        final products = Product.fromJsonList(response.data as List<dynamic>);
        // Önbelleğe kaydet
        await _productBox.clear();
        for (final product in products) {
          await _productBox.put(product.id, product);
        }
        return products;
      } else {
        throw Exception('Ürünler yüklenemedi');
      }
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu');
    }
  }*/

  /*
/// API yapısında böyle bir kullanım yok. Tek bir product alamıyoruz.
  Future<Product> fetchProductById(int productId) async {
    if (_productBox.containsKey(productId)) {
      return _productBox.get(productId)!;
    }

    try {
      final response = await _networkManager.dio.get('/products/$productId');
      if (response.statusCode == 200) {
        final product = Product.fromJson(response.data as Map<String, dynamic>);
        await _productBox.put(product.id, product);
        return product;
      } else {
        throw Exception('Ürün detayları yüklenemedi');
      }
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu');
    }
  }
*/
}
