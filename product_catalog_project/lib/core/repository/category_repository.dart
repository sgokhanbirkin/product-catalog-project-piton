import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';

@injectable
class CategoryRepository {
  CategoryRepository(this._networkManager);
  final ProjectNetworkManager _networkManager;

  Future<List<Category>> fetchCategories() async {
    try {
      final response = await _networkManager.dio.get('/categories');
      if (response.statusCode == 200) {
        return Category.fromJsonList(response.data as List<dynamic>);
      } else {
        throw Exception('Kategoriler yüklenemedi');
      }
    } on DioException catch (e) {
      rethrow;
    } catch (e) {
      throw Exception('Beklenmeyen bir hata oluştu');
    }
  }
}
