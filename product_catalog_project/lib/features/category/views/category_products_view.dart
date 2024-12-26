import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:product_catalog_project/core/providers/repository_provider.dart';
import 'package:product_catalog_project/core/repository/product_repository.dart';
import 'package:product_catalog_project/core/routes/app_router.dart';
import 'package:product_catalog_project/features/category/view_models/category_products_view_model.dart';

@RoutePage()
class CategoryProductsView extends ConsumerStatefulWidget {
  const CategoryProductsView({
    required this.categoryId,
    super.key,
  });

  final int categoryId;

  @override
  _CategoryProductsViewState createState() => _CategoryProductsViewState();
}

class _CategoryProductsViewState extends ConsumerState<CategoryProductsView> {
  late Future<List<Product>> products;
  late CategoryProductsViewModel viewModel;
  late ProductRepository productRepository;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productRepository = ref.read(productRepositoryProvider);
    products = productRepository.getProductsByCategory(widget.categoryId);
    viewModel = CategoryProductsViewModel(productRepository);
  }

  void _filterProducts(String query) {
    setState(() {
      products = productRepository.getProductsByCategory(widget.categoryId);
      products = products.then((productList) {
        return productList.where((product) {
          final name = product.name?.toLowerCase() ?? '';
          final author = product.author?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase()) ||
              author.contains(query.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        FutureBuilder<String>(
          future: viewModel.getCategoryName(categoryId: widget.categoryId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  snapshot.data ?? 'Category',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }
            return const Text('No Category');
          },
        ),
      ]),
      body: Column(
        children: [
          Padding(
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
              onChanged: _filterProducts,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  final productsInCategory = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: context.width * 0.04,
                      mainAxisSpacing: context.height * 0.03,
                      childAspectRatio: 0.55,
                    ),
                    itemCount: productsInCategory.length,
                    itemBuilder: (context, index) {
                      final product = productsInCategory[index];
                      final imageUrl =
                          viewModel.getImageUrl(product.cover ?? '');

                      return GestureDetector(
                        onTap: () {
                          context.pushRoute(
                              ProductDetailRoute(productId: product.id));
                        },
                        child: _productCard(
                          imageUrl: imageUrl,
                          product: product,
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('No products found'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _productCard extends StatelessWidget {
  const _productCard({
    super.key,
    required this.imageUrl,
    required this.product,
  });

  final Future<String> imageUrl;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: context.paddingLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.height * 0.0025),
            child: FutureBuilder<String>(
              future: imageUrl,
              builder: (context, imageSnapshot) {
                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (imageSnapshot.hasError) {
                  return const Icon(Icons.error);
                } else if (imageSnapshot.hasData) {
                  return CachedNetworkImage(
                    imageUrl: imageSnapshot.data ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: context.height * 0.25,
                  );
                } else {
                  return const Icon(Icons.image);
                }
              },
            ),
          ),
          Padding(
            padding: context.paddingLow,
            child: Text(
              product.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.titleSmall?.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          Padding(
            padding: context.paddingLow,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    product.author ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
