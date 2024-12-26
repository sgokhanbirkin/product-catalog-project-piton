// test/category_repository_test.dart

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';
import 'package:product_catalog_project/product/cache/category_cache_manager.dart';

class MockProjectNetworkManager extends Mock implements ProjectNetworkManager {
  final _dio = MockDio();

  @override
  Dio get dio => _dio;
}

class MockDio extends Mock implements Dio {}

class MockCategoryCacheManager extends Mock implements CategoryCacheManager {
  @override
  Future<void> putCategories(List<Category> categories) async {}
}

void main() {
  group('CategoryRepository', () {
    late CategoryRepository categoryRepository;
    late MockProjectNetworkManager mockNetworkManager;
    late MockCategoryCacheManager mockCacheManager;
    late MockDio mockDio;

    setUp(() {
      mockNetworkManager = MockProjectNetworkManager();
      mockCacheManager = MockCategoryCacheManager();
      mockDio = mockNetworkManager.dio as MockDio;
      categoryRepository =
          CategoryRepository(mockNetworkManager, mockCacheManager);
    });

    test('fetchCategories returns list of categories on successful response',
        () async {
      final mockResponseData = {
        'data': [
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
        ]
      };

      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/categories'),
        statusCode: 200,
        data: mockResponseData,
      );

      when(() => mockDio.get('/categories'))
          .thenAnswer((_) async => mockResponse);

      final categories = await categoryRepository.fetchCategories();

      expect(categories, isA<List<Category>>());
      expect(categories.length, 2);
      expect(categories[0].name, 'Kitaplar');
      expect(categories[1].name, 'Elektronik');
    });

    test('fetchCategories throws exception on non-200 response', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/categories'),
        statusCode: 500,
      );

      when(() => mockDio.get('/categories'))
          .thenAnswer((_) async => mockResponse);

      expect(() => categoryRepository.fetchCategories(), throwsException);
    });

    test('fetchCategories caches categories on successful response', () async {
      final mockResponseData = {
        'data': [
          {
            'id': 1,
            'name': 'Kitaplar',
            'created_at': '2023-01-01T10:00:00Z',
          }
        ]
      };

      final mockResponse = Response(
        requestOptions: RequestOptions(path: '/categories'),
        statusCode: 200,
        data: mockResponseData,
      );

      when(() => mockDio.get('/categories'))
          .thenAnswer((_) async => mockResponse);
      when(() => mockCacheManager.putCategories(any()))
          .thenAnswer((_) async {});

      await categoryRepository.fetchCategories();

      verify(() => mockCacheManager.putCategories(any())).called(1);
    });
  });
}
