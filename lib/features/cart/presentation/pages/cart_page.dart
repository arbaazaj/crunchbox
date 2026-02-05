import 'package:crunchbox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:crunchbox/features/product/presentation/widgets/animated_background_gradient.dart';
import 'package:crunchbox/features/product/presentation/widgets/custom_button_with_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
      ),
      body: Stack(
        children: [
          AnimatedBackgroundGradient(context: context),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoaded) {
                if (state.cart.items.isEmpty) {
                  return Center(
                    child: Text(
                      '🛒 Your cart is empty',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart.items.length,
                        itemBuilder: (context, index) {
                          final item = state.cart.items[index];
                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                item.product.imageUrl,
                                height: 50,
                                width: 50,
                              ),
                              title: Text(
                                item.product.name,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '\$${item.product.price * item.quantity!}',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                        RemoveFromCart(product: item.product),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    '${item.quantity}',
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                        AddToCart(product: item.product),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (state.cart.items.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomButtonWithBorder(
                          buttonText:
                              'Total: \$${state.cart.totalPrice.round()} | Checkout',
                          iconData: Icons.payment,
                          onPressed: () {},
                        ),
                      ),
                  ],
                );
              } else if (state is CartError) {
                return Text('Error loading cart: ${state.error}');
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
