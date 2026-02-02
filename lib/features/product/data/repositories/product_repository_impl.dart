import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/remote_supabase_product_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RemoteSupabaseProductDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDataSource.getProducts();
  }

  @override
  Future<List<Category>> getCategories() async {
    return await remoteDataSource.getCategories();
  }
}
