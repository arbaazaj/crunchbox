import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../product/domain/entities/product.dart';
import '../../data/models/cart.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoaded(cart: Cart(items: []))) {
    on<AddToCart>((event, emit) {
      if (state is CartLoaded) {
        final cart = (state as CartLoaded).cart;
        final existingItem = cart.items.firstWhereOrNull(
          (item) => item.product.id == event.product.id,
        );
        if (existingItem != null) {
          final updatedItems = cart.items.map((item) {
            return item.product.id == event.product.id
                ? item.copyWith(quantity: item.quantity! + 1)
                : item;
          }).toList();
          emit(CartLoaded(cart: cart.copyWith(items: updatedItems)));
        } else {
          emit(
            CartLoaded(
              cart: cart.copyWith(
                items: List.from(cart.items)
                  ..add(CartItems(product: event.product)),
              ),
            ),
          );
        }
      }
    });
    on<RemoveFromCart>((event, emit) {
      if (state is CartLoaded) {
        final cart = (state as CartLoaded).cart;
        final existingItem = cart.items.firstWhereOrNull(
          (item) => item.product.id == event.product.id,
        );

        if (existingItem != null) {
          if (existingItem.quantity! > 1) {
            final updatedItems = cart.items.map((item) {
              return item == existingItem
                  ? item.copyWith(quantity: item.quantity! - 1)
                  : item;
            }).toList();
            emit(CartLoaded(cart: cart.copyWith(items: updatedItems)));
          } else {
            final updatedItems = List.of(cart.items)
              ..removeWhere((item) => item.product.id == event.product.id);
            emit(CartLoaded(cart: cart.copyWith(items: updatedItems)));
          }
        }
      }
    });
  }
}
