part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

final class CartLoaded extends CartState {
  final Cart cart;

  const CartLoaded({required this.cart});

  @override
  List<Object?> get props => [cart];
}

final class CartError extends CartState {
  final String error;

  const CartError({required this.error});

  @override
  List<Object?> get props => [error];
}
