import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
    : _productRepository = productRepository,
      super(ProductInitial()) {
    on<FetchProductsAndCategories>(_onFetchProductsAndCategories);
  }

  Future<void> _onFetchProductsAndCategories(
    FetchProductsAndCategories event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      // Fetch both concurrently for better performance
      final results = await Future.wait([
        _productRepository.getProducts(),
        _productRepository.getCategories(),
      ]);

      final products = results[0] as List<Product>;
      final categories = results[1] as List<Category>;

      emit(ProductLoaded(products: products, categories: categories));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
