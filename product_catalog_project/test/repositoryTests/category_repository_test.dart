// test/category_repository_test.dart

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';
import 'package:product_catalog_project/product/cache/category_cache_manager.dart';

class MockProjectNetworkManager extends Mock implements ProjectNetworkManager {}

void main() {
  group('CategoryRepository', () {
    late CategoryRepository categoryRepository;
    late MockProjectNetworkManager mockNetworkManager;
    CategoryCacheManager categoryCacheManager = CategoryCacheManager();
    setUp(() {
      mockNetworkManager = MockProjectNetworkManager();
      categoryRepository =
          CategoryRepository(mockNetworkManager, categoryCacheManager);
    });

    test('fetchCategories returns list of categories on successful response',
        () async {
      // Mock API yanıtı
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/categories'),
        statusCode: 200,
        data: [
          {
            'id': 1,
            'name': 'Kitaplar',
            'created_at': '2023-01-01T10:00:00Z',
          },
          {
            'id': 2,
            'name': 'Elektronik',
            'created_at': '2023-02-01T10:00:00Z',
          },
        ],
      );

      when(mockNetworkManager.dio.get('/categories'))
          .thenAnswer((_) async => mockResponse);

      final categories = await categoryRepository.fetchCategories();

      expect(categories, isA<List<Category>>());
      expect(categories.length, 2);
      expect(categories[0].name, 'Kitaplar');
      //expect(categories[1].createdAt, DateTime.parse('2023-02-01T10:00:00Z'));
    });

    test('fetchCategories throws exception on non-200 response', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/categories'),
        statusCode: 500,
      );

      when(mockNetworkManager.dio.get('/categories'))
          .thenAnswer((_) async => mockResponse);

      expect(() => categoryRepository.fetchCategories(), throwsException);
    });
  });
}
