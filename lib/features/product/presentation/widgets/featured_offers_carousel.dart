// Carousel for featured items
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'featured_product_card.dart';

class FeaturedOffersCarousel extends StatelessWidget {
  final List<Product> products;

  const FeaturedOffersCarousel({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SizedBox(
        height: 180,
        child: Center(child: Text("No special offers today!")),
      );
    }
    return CarouselSlider.builder(
      itemCount: products.length,
      itemBuilder: (context, index, realIndex) {
        final product = products[index];
        return FeaturedProductCard(product: product);
      },
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}
