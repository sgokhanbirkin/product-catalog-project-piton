import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/category/views/category_products_view.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = ref.read(homeViewModelProvider.notifier)..loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage.isNotEmpty
              ? Center(child: Text(state.errorMessage))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderRow(),
                    _buildCategoriesList(state.categories),
                    _buildSearchAndCategories(),
                    _buildProductSections(state),
                  ],
                ),
    );
  }

  Widget _buildHeaderRow() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.05, // Add padding to the left and right
        right: context.width * 0.05,
        top: context.height * 0.05,
        bottom: context.height * 0.02,
      ),
      child: SizedBox(
        height: context.height * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // This ensures the items are spaced to the left and right
          children: [
            // Logo aligned to the left
            SizedBox(
              width: context.width * 0.15,
              child: const LogoWidget(),
            ),

            // Filter text aligned to the right
            Padding(
              padding: EdgeInsets.only(
                right: context.width * 0.05,
              ),
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

  Widget _buildCategoriesList(List<Category> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Adding the 'ALL' chip at the beginning
          Padding(
            padding: context.paddingLow,
            child: ChoiceChip(
              label: Text('ALL'),
              selected: selectedCategoryIndex == null,
              onSelected: (isSelected) {
                setState(() {
                  selectedCategoryIndex =
                      null; // Set to null to indicate 'ALL' is selected
                });
              },
            ),
          ),
          // Now adding the category chips dynamically
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

  Widget _buildSearchAndCategories() {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.05,
        right: context.width * 0.05,
      ),
      child: Column(
        children: [
          // Search bar
          TextField(
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
        ],
      ),
    );
  }

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
                            category.name,
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
                    _buildProductsList(productsInCategory),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
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
                            // Product name with truncation if needed
                            Text(
                              product.name ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodyMedium,
                            ),
                            // Author name
                            Text(
                              product.author ?? '',
                              maxLines: 1,
                              style: context.textTheme.bodySmall,
                            ),
                            SizedBox(
                              height: context.height * 0.05,
                            ),

                            const Spacer(),
                            // Product price at the bottom
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
