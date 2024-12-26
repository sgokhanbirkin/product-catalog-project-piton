import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/category/views/category_products_view.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockProductRepository;

  setUpAll(() {
    registerFallbackValue(Product(id: 0));
  });

  setUp(() {
    mockProductRepository = MockProductRepository();

    // GetIt setup
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<AppRouter>()) {
      getIt.registerSingleton<AppRouter>(AppRouter());
    }
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  final testProducts = [
    Product(
      id: 1,
      name: 'Test Product 1',
      author: 'Test Author 1',
      price: 10.0,
    ),
    Product(
      id: 2,
      name: 'Test Product 2',
      author: 'Test Author 2',
      price: 20.0,
    ),
  ];

  Widget buildTestWidget({required Widget child}) {
    return ProviderScope(
      overrides: [
        productRepositoryProvider.overrideWithValue(mockProductRepository),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('CategoryProductsView shows loading state initially',
      (WidgetTester tester) async {
    when(() => mockProductRepository.getProductsByCategory(any()))
        .thenAnswer((_) async => []);
    when(() => mockProductRepository.getCategoryName(
            categoryId: any(named: 'categoryId')))
        .thenAnswer((_) async => 'Test Category');

    await tester.pumpWidget(buildTestWidget(
      child: const CategoryProductsView(categoryId: 1),
    ));

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('CategoryProductsView shows products when loaded',
      (WidgetTester tester) async {
    when(() => mockProductRepository.getProductsByCategory(any()))
        .thenAnswer((_) async => testProducts);
    when(() => mockProductRepository.getImageUrl(
            productFileName: any(named: 'productFileName')))
        .thenAnswer((_) async => 'test_image_url');
    when(() => mockProductRepository.getCategoryName(
            categoryId: any(named: 'categoryId')))
        .thenAnswer((_) async => 'Test Category');

    await tester.pumpWidget(buildTestWidget(
      child: const CategoryProductsView(categoryId: 1),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Test Product 1'), findsOneWidget);
    expect(find.text('Test Author 1'), findsOneWidget);
    expect(find.text('\$10.0'), findsOneWidget);
  });

  testWidgets('CategoryProductsView shows no products message when empty',
      (WidgetTester tester) async {
    when(() => mockProductRepository.getProductsByCategory(any()))
        .thenAnswer((_) async => []);
    when(() => mockProductRepository.getCategoryName(
            categoryId: any(named: 'categoryId')))
        .thenAnswer((_) async => 'Test Category');

    await tester.pumpWidget(buildTestWidget(
      child: const CategoryProductsView(categoryId: 1),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Ürün bulunamadı'), findsOneWidget);
  });

  testWidgets('CategoryProductsView filters products with search',
      (WidgetTester tester) async {
    when(() => mockProductRepository.getProductsByCategory(any()))
        .thenAnswer((_) async => testProducts);
    when(() => mockProductRepository.getImageUrl(
            productFileName: any(named: 'productFileName')))
        .thenAnswer((_) async => 'test_image_url');
    when(() => mockProductRepository.getCategoryName(
            categoryId: any(named: 'categoryId')))
        .thenAnswer((_) async => 'Test Category');

    await tester.pumpWidget(buildTestWidget(
      child: const CategoryProductsView(categoryId: 1),
    ));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Test Product 1');
    await tester.pump();

    expect(find.text('Test Product 1'), findsOneWidget);
    expect(find.text('Test Product 2'), findsNothing);
  });
}
