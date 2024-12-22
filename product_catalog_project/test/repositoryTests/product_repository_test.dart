// test/product_repository_test.dart
/*
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/core/service/project_network_manager.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:dio/dio.dart';

class MockProjectNetworkManager extends Mock implements ProjectNetworkManager {}

class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  group('ProductRepository', () {
    late ProductRepository productRepository;
    late MockProjectNetworkManager mockNetworkManager;
    late MockCategoryRepository mockCategoryRepository;

    setUp(() {
      mockNetworkManager = MockProjectNetworkManager();
      mockCategoryRepository = MockCategoryRepository();
      productRepository =
          ProductRepository(mockNetworkManager, mockCategoryRepository);
    });

    test(
        'fetchAllProducts fetches categories and products, stores them in Hive',
        () async {
      // Mock kategorileri oluşturma
      final categories = [
        Category(
            id: 1,
            name: 'Kitaplar',
            createdAt: DateTime.parse('2023-01-01T10:00:00Z')),
        Category(
            id: 2,
            name: 'Elektronik',
            createdAt: DateTime.parse('2023-02-01T10:00:00Z')),
      ];

      // Mock CategoryRepository'nin fetchCategories metodunu ayarlama
      when(mockCategoryRepository.fetchCategories())
          .thenAnswer((_) async => categories);

      // Mock ürünleri oluşturma
      final productsCategory1 = [
        Product(
          id: 1,
          name: 'Dune',
          author: 'Frank Herbert',
          cover: 'dune.png',
          createdAt: DateTime.parse('2023-01-09T14:39:18Z'),
          description: 'Dune is set in the distant future...',
          price: 87.75,
          sales: 5,
          slug: 'dune',
          likesAggregate: LikesAggregate(aggregate: Aggregate(count: 0)),
        ),
      ];

      final productsCategory2 = [
        Product(
          id: 2,
          name: 'Smartphone',
          author: 'Apple',
          cover: 'smartphone.png',
          createdAt: DateTime.parse('2023-03-09T14:39:18Z'),
          description: 'Latest smartphone from Apple...',
          price: 999.99,
          sales: 10,
          slug: 'smartphone',
          likesAggregate: LikesAggregate(aggregate: Aggregate(count: 10)),
        ),
      ];

      // Mock NetworkManager'nin fetchProductsByCategory metodunu ayarlama
      when(mockNetworkManager.dio.get('/categories/1/products'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/categories/1/products'),
                statusCode: 200,
                data: productsCategory1.map((p) => p.toJson()).toList(),
              ));

      when(mockNetworkManager.dio.get('/categories/2/products'))
          .thenAnswer((_) async => Response(
                requestOptions: RequestOptions(path: '/categories/2/products'),
                statusCode: 200,
                data: productsCategory2.map((p) => p.toJson()).toList(),
              ));

      // Hive kutusunu mocklamak için ek adımlar gerekebilir
      // Ancak basit bir test için mevcut Hive kutusunu kullanabilirsiniz

      // Fetch işlemini gerçekleştir
      final allProducts = await productRepository.fetchAllProducts();

      // Beklenen sonuçları kontrol et
      expect(allProducts.length, 2);
      expect(allProducts[0].name, 'Dune');
      expect(allProducts[1].name, 'Smartphone');

      // Hive kutusuna eklenmiş ürünleri kontrol et
      expect(productRepository._productBox.length, 2);
      expect(productRepository._productBox.get(1)!.name, 'Dune');
      expect(productRepository._productBox.get(2)!.name, 'Smartphone');
    });

    test('fetchAllProducts throws exception when fetching categories fails',
        () async {
      // Mock CategoryRepository'nin fetchCategories metodunu hata fırlatacak şekilde ayarlama
      when(mockCategoryRepository.fetchCategories())
          .thenThrow(Exception('Kategoriler yüklenemedi'));

      // Fetch işlemini gerçekleştir ve hatayı bekle
      expect(() => productRepository.fetchAllProducts(), throwsException);
    });

    // Diğer test senaryolarını ekleyebilirsiniz
  });
}
*/
