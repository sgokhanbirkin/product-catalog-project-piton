import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/repository/category_repository.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/home/state/home_state.dart';
import 'package:product_catalog_project/features/home/view_models/home_view_model.dart';
import 'package:product_catalog_project/features/home/views/home_view.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class MockCategoryRepository extends Mock implements CategoryRepository {}

class MockHomeViewModel extends StateNotifier<HomeState>
    with Mock
    implements HomeViewModel {
  MockHomeViewModel() : super(HomeState());

  @override
  Future<void> loadInitialData() async {}

  @override
  Future<void> filterProductsByCategory(int categoryId) async {}

  @override
  void resetFilter() {}

  @override
  Future<String> getImageUrl(String productFileName) async {
    return '';
  }

  @override
  Future<void> loadData() async {}
}

void main() {
  late MockProductRepository mockProductRepository;
  late MockCategoryRepository mockCategoryRepository;
  late MockHomeViewModel mockHomeViewModel;

  setUpAll(() {
    registerFallbackValue(Product(id: 0));
    registerFallbackValue(Category(id: 0, name: '', created_at: ''));
  });

  setUp(() {
    mockProductRepository = MockProductRepository();
    mockCategoryRepository = MockCategoryRepository();
    mockHomeViewModel = MockHomeViewModel();

    // GetIt setup
    final getIt = GetIt.instance;
    if (!getIt.isRegistered<AppRouter>()) {
      getIt.registerSingleton<AppRouter>(AppRouter());
    }
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  final testCategories = [
    Category(id: 1, name: 'Best Seller', created_at: '2024-01-01'),
    Category(id: 2, name: 'Classics', created_at: '2024-01-01'),
  ];

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
        homeViewModelProvider.overrideWith((ref) => mockHomeViewModel),
        productRepositoryProvider.overrideWithValue(mockProductRepository),
        categoryRepositoryProvider.overrideWithValue(mockCategoryRepository),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('HomeView shows loading indicator when loading',
      (WidgetTester tester) async {
    when(() => mockHomeViewModel.state).thenReturn(HomeState(isLoading: true));

    await tester.pumpWidget(buildTestWidget(child: const HomeView()));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomeView shows categories and products when loaded',
      (WidgetTester tester) async {
    when(() => mockHomeViewModel.state).thenReturn(HomeState(
      categories: testCategories,
      products: testProducts,
      isLoading: false,
    ));

    await tester.pumpWidget(buildTestWidget(child: const HomeView()));
    await tester.pump();

    expect(find.text('Best Seller'), findsOneWidget);
    expect(find.text('Classics'), findsOneWidget);
    expect(find.text('Test Product 1'), findsOneWidget);
    expect(find.text('Test Author 1'), findsOneWidget);
    expect(find.text('\$10.0'), findsOneWidget);
  });

  testWidgets('HomeView filters products when category is selected',
      (WidgetTester tester) async {
    final filteredProducts = [testProducts[0]];

    when(() => mockHomeViewModel.state).thenReturn(HomeState(
      categories: testCategories,
      products: testProducts,
      isLoading: false,
    ));

    when(() => mockProductRepository.getProductsByCategory(1))
        .thenAnswer((_) async => filteredProducts);

    await tester.pumpWidget(buildTestWidget(child: const HomeView()));
    await tester.pump();

    await tester.tap(find.text('Best Seller'));
    await tester.pumpAndSettle();

    expect(find.text('Test Product 1'), findsOneWidget);
    expect(find.text('Test Product 2'), findsNothing);
  });

  testWidgets('HomeView shows error message when loading fails',
      (WidgetTester tester) async {
    when(() => mockHomeViewModel.state).thenReturn(HomeState(
      errorMessage: 'Failed to load data',
      isLoading: false,
    ));

    await tester.pumpWidget(buildTestWidget(child: const HomeView()));
    await tester.pump();

    expect(find.text('Failed to load data'), findsOneWidget);
  });
}
