import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/core/models/category.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/providers/auth_provider.dart';
import 'package:product_catalog_project/core/providers/language_provider.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/home/state/home_state.dart';
import 'package:product_catalog_project/features/home/view_models/home_view_model.dart';
import 'package:product_catalog_project/features/home/view_models/language_view_model.dart';
import 'package:product_catalog_project/product/init/product_localization.dart';
import 'package:product_catalog_project/product/utility/constants/locales.dart';
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
  TextEditingController _searchController = TextEditingController();
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

  void _logout() {
    // Oturumdan çıkma işlemi
    ref
        .read(authProvider.notifier)
        .logout(context); // auth_provider içinde tanımlı logout fonksiyonu
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

  void _selectLanguage(String language) {
    // Update language provider
    ref.read(languageProvider.notifier).state = language;

    // Change the app language using EasyLocalization
    if (language == 'tr') {
      ProductLocalization.updateLanguage(value: Locales.tr, context: context);
    } else if (language == 'en') {
      ProductLocalization.updateLanguage(value: Locales.en, context: context);
    }

    // Hide language menu after selection
    ref
        .read(languageViewModelProvider.notifier)
        .setLanguageMenuVisibility(false);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final isLanguageMenuVisible = ref.watch(languageViewModelProvider);

    return Scaffold(
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage.isNotEmpty
              ? Center(child: Text(state.errorMessage))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.height * 0.05,
                    ),
                    _buildHeaderRow(),
                    _buildSearchBar(),
                    _buildCategoriesList(state.categories),
                    _buildProductSections(state),
                    if (isLanguageMenuVisible) _buildLanguageMenu(),
                  ],
                ),
    );
  }

  Widget _buildLanguageMenu() {
    return Padding(
      padding: context.paddingLow,
      child: Column(
        children: [
          ListTile(
            title: const Text('Türkçe'),
            leading: Radio<String>(
              value: 'tr',
              groupValue: ref.watch(languageProvider),
              onChanged: (value) {
                _selectLanguage('tr');
              },
            ),
          ),
          ListTile(
            title: const Text('English'),
            leading: Radio<String>(
              value: 'en',
              groupValue: ref.watch(languageProvider),
              onChanged: (value) {
                _selectLanguage('en');
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Çıkış Yap'),
            leading: const Icon(Icons.logout),
            onTap: () {
              _logout(); // Logout işlemi
            },
          ),
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
            GestureDetector(
              child: SizedBox(
                width: context.width * 0.15,
                child: const LogoWidget(),
              ),
              onTap: () {
                ref
                    .read(languageViewModelProvider.notifier)
                    .toggleLanguageMenu(); // Toggle the menu visibility on logo tap
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: context.width * 0.05),
              child: Text(
                'homeview.catalog'.tr(),
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
          hintText: 'homeview.search'.tr(),
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
              label: Text('homeview.all'.tr()),
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
                return Center(child: Text('homeview.no_products'.tr()));
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
                          return Center(child: Text('homeview.no_image'.tr()));
                        } else if (snapshot.hasData) {
                          return Center(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data ?? '',
                              height: context.height * 0.175,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return Center(child: Text('homeview.no_image'.tr()));
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
