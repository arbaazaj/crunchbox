import 'package:crunchbox/model/response.dart';

class Cart {
  late final List<CartItem> products;

  Cart({required this.products});

  Map<String, dynamic> toMap() {
    return {'products': products};
  }

  Cart.fromMap(dynamic map) {
    products = map['product'];
  }

  Cart toEntity() => Cart(products: products);
}

class CartItem {
  late final Product product;
  late final int quantity;

  CartItem({required this.product, required this.quantity});

  Map<String, dynamic> toMap() {
    return {'product': product, 'quantity': quantity};
  }

  CartItem.fromMap(dynamic map) {
    product = map['product'];
    quantity = map['quantity'];
  }

  CartItem toEntity() => CartItem(product: product, quantity: quantity);
}
