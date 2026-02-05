import 'package:crunchbox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:crunchbox/features/cart/presentation/pages/cart_page.dart';
import 'package:crunchbox/features/product/domain/entities/product.dart';
import 'package:crunchbox/features/product/presentation/widgets/animated_background_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/themes/colors.dart';
import '../widgets/custom_button_with_border.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
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
          IconButton(onPressed: () {
            Get.to(() => CartPage());
          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Stack(
        children: [
          AnimatedBackgroundGradient(context: context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Hero(
                tag: 'P_IMAGE',
                child: Image.network(
                  widget.product.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Image.asset('assets/non_veg.png', width: 26, height: 26),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '\$${widget.product.price}',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '🗒️ Description:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  widget.product.description,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '🥦 Ingredient:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'mutton, tomatoes, garlic, onion, spices',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '💪 Nutrition:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '450 calories, 11g energy, 10g protein, 10g fat, 10g carbs',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomButtonWithBorder(buttonText:
                      'ADD TO CART', iconData: Icons.shopping_cart, onPressed: () {
                        context.read<CartBloc>().add(
                          AddToCart(product: widget.product),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
