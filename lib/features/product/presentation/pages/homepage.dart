import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/themes/colors.dart';
import '../../../account/presentation/bloc/account_bloc.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../bloc/product_bloc.dart';
import '../widgets/animated_background_gradient.dart';
import '../widgets/category_header.dart';
import '../widgets/featured_offers_carousel.dart';
import '../widgets/horizontal_product_card.dart'; // Add this to pubspec.yaml

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Crunch Box',
          style: TextStyle(
            fontFamily: 'Beyno',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
            onPressed: () {
              context.read<AccountBloc>().add(AccountLogoutRequested());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Animated background gradient shapes
          AnimatedBackgroundGradient(context: context),
          // Main content
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (state is ProductError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              if (state is ProductLoaded) {
                // For the carousel, let's feature the first 3 products
                final featuredProducts = state.products.take(3).toList();

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).padding.top +
                                kToolbarHeight,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              "Today's Special Offers",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FeaturedOffersCarousel(products: featuredProducts),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                    // Generate a list of slivers for each category
                    ..._buildCategorySections(state.categories, state.products),
                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                    // Bottom padding
                  ],
                );
              }
              return const Center(child: Text('Welcome to Crunch Box!'));
            },
          ),
        ],
      ),
    );
  }

  // Helper to build the category sections as a flat list of slivers
  List<Widget> _buildCategorySections(
    List<Category> categories,
    List<Product> allProducts,
  ) {
    final List<Widget> slivers = [];
    for (final category in categories) {
      final categoryProducts = allProducts
          .where((p) => p.categoryId == category.id)
          .toList();
      if (categoryProducts.isNotEmpty) {
        // Add the header sliver
        slivers.add(
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverToBoxAdapter(
              child: CategoryHeader(title: category.name),
            ),
          ),
        );
        // Add the horizontal product list sliver
        slivers.add(
          SliverToBoxAdapter(
            child: SizedBox(
              height: 240, // Height for the horizontal list
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  return HorizontalProductCard(
                    product: categoryProducts[index],
                  );
                },
              ),
            ),
          ),
        );
      }
    }
    return slivers;
  }
}
