import 'package:crunchbox/features/product/domain/entities/product.dart';

class Cart {
  final List<CartItems> items;

  Cart({required this.items});

  Cart copyWith({List<CartItems>? items}) {
    return Cart(items: items ?? this.items);
  }

  double get totalPrice {
    return items.fold<double>(
      0,
          (sum, item) => sum + (item.product.price * item.quantity!),
    );
  }

}

class CartItems {
  final Product product;
  int? quantity;

  CartItems({required this.product, this.quantity = 1});

  CartItems copyWith({Product? product, int? quantity}) {
    return CartItems(
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

}