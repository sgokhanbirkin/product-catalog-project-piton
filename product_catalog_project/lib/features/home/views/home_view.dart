import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/home/state/home_state.dart';
import 'package:product_catalog_project/features/home/view_models/home_view_model.dart';
import 'package:product_catalog_project/product/widgets/custom_logo_widget.dart';

@RoutePage()
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late HomeViewModel viewModel;
  int? selectedCategoryIndex = 0;
  TextEditingController _searchController =
      TextEditingController(); // Search controller
  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = ref.read(homeViewModelProvider.notifier)..loadData();
    });

    _searchController.addListener(() {
      setState(_filterProducts);
    });
  }

  // Method to filter products based on search term
  void _filterProducts() {
    final searchTerm = _searchController.text.toLowerCase();
    final allProducts = viewModel.state.products;

    filteredProducts = allProducts.where((product) {
      final productName = product.name?.toLowerCase() ?? '';
      final productAuthor = product.author?.toLowerCase() ?? '';
      return productName.contains(searchTerm) ||
          productAuthor.contains(searchTerm);
    }).toList();
  }

  // Add a method to handle category filtering
  void _filterCategoryProducts(List<Product> allProducts, String searchTerm) {
    filteredProducts = allProducts.where((product) {
      final productName = product.name?.toLowerCase() ?? '';
      final productAuthor = product.author?.toLowerCase() ?? '';
      return productName.contains(searchTerm) ||
          productAuthor.contains(searchTerm);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage.isNotEmpty
              ? Center(child: Text(state.errorMessage))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderRow(),
                    _buildSearchBar(),
                    _buildCategoriesList(state.categories),
                    _buildProductSections(state),
                  ],
                ),
    );
  }

  Widget _buildHeaderRow() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.05,
        right: context.width * 0.05,
        top: context.height * 0.01,
        bottom: context.height * 0.02,
      ),
      child: SizedBox(
        height: context.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.width * 0.15,
              child: const LogoWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(right: context.width * 0.05),
              child: Text(
                'Catalog',
                style: context.textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for products...',
          prefixIcon: const Icon(Icons.search),
          fillColor: const Color.fromARGB(26, 97, 81, 221),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(List<Category> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: context.paddingLow,
            child: ChoiceChip(
              label: Text('ALL'),
              selected: selectedCategoryIndex == null,
              onSelected: (isSelected) {
                setState(() {
                  selectedCategoryIndex = null;
                });
              },
            ),
          ),
          ...categories.map((category) {
            int categoryIndex = categories.indexOf(category);
            return Padding(
              padding: context.paddingLow,
              child: ChoiceChip(
                label: Text(category.name ?? ''),
                selected: selectedCategoryIndex == categoryIndex,
                onSelected: (isSelected) {
                  setState(() {
                    selectedCategoryIndex = isSelected ? categoryIndex : null;
                  });
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Updated product sections with category filtering applied individually
  Widget _buildProductSections(HomeState state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.categories.length,
        itemBuilder: (context, index) {
          final category = state.categories[index];
          return FutureBuilder<List<Product>>(
            future: ref
                .read(productRepositoryProvider)
                .getProductsByCategory(category.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final productsInCategory = snapshot.data!;

                // Filter products based on the search input
                _filterCategoryProducts(
                    productsInCategory, _searchController.text);

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.05,
                        right: context.width * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            category.name ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushRoute(
                                CategoryProductsRoute(categoryId: category.id),
                              );
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 137, 15)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildProductsList(
                        filteredProducts), // Use filteredProducts here
                  ],
                );
              } else {
                return const Center(child: Text('No products found'));
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildProductsList(List<Product> products) {
    // Filtered products based on search query
    final productsToShow =
        _searchController.text.isEmpty ? products : filteredProducts;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: productsToShow.map((product) {
          final imageUrl = viewModel.getImageUrl(product.cover ?? '');
          return GestureDetector(
            onTap: () {
              context.pushRoute(ProductDetailRoute(productId: product.id));
            },
            child: Padding(
              padding: context.paddingLow,
              child: Container(
                width: context.width * 0.6,
                height: context.height * 0.175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(47, 97, 81, 221),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<String>(
                      future: imageUrl,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Error loading image'));
                        } else if (snapshot.hasData) {
                          return Center(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data ?? '',
                              height: context.height * 0.175,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return const Center(child: Text('No image found'));
                        }
                      },
                    ),
                    SizedBox(
                      width: context.width * 0.008,
                    ),
                    // Product name with truncation if needed
                    Expanded(
                      child: Padding(
                        padding: context.paddingLow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyMedium,
                            ),
                            Text(
                              product.author ?? '',
                              maxLines: 1,
                              style: context.textTheme.bodySmall,
                            ),
                            SizedBox(
                              height: context.height * 0.05,
                            ),
                            const Spacer(),
                            Text(
                              '\$${product.price}',
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
