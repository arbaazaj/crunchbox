import '../entities/category.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();

  Future<List<Category>> getCategories();
}
