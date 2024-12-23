import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:product_catalog_project/core/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:product_catalog_project/core/extensions/context_extensions.dart';
import 'package:product_catalog_project/features/product/view_models/product_detail_view.dart';
import 'package:product_catalog_project/product/widgets/custom_elevated_button.dart';

@RoutePage()
class ProductDetailView extends ConsumerStatefulWidget {
  final int productId;

  const ProductDetailView({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  late Future<Product> productDetails;
  late ProductDetailViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(productDetailViewModelProvider);
    productDetails = viewModel.fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
      ),
      body: FutureBuilder<Product>(
        future: productDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }
          if (snapshot.hasData) {
            final product = snapshot.data!;
            final imageUrl =
                viewModel.getImageUrl(product.cover ?? ''); // Get the image URL

            return SingleChildScrollView(
              child: Padding(
                padding: context.paddingLow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Use CachedNetworkImage with the correct URL
                    FutureBuilder<String>(
                      future: imageUrl, // Fetch the image URL
                      builder: (context, imageSnapshot) {
                        if (imageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // Loading spinner
                        } else if (imageSnapshot.hasError) {
                          return const Icon(Icons.error); // Error icon
                        } else if (imageSnapshot.hasData) {
                          return CachedNetworkImage(
                            imageUrl: imageSnapshot.data ?? '',
                            height: context.height * 0.4,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return const Icon(
                            Icons.image,
                          ); // Default icon if no image
                        }
                      },
                    ),
                    SizedBox(height: context.height * 0.02),
                    Text(
                      product.name ?? '',
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.height * 0.01),
                    Text(
                      product.author ?? '',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(height: context.height * 0.02),
                    Text(
                      'Summary',
                      style: context.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.height * 0.01),
                    Text(
                      product.description ?? 'No summary available.',
                      style: context.textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: context.height * 0.05,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        // Implement Buy Now functionality
                      },
                      buttonText: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price}',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Buy Now',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.height * 0.05),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('No product details found'));
        },
      ),
    );
  }
}
