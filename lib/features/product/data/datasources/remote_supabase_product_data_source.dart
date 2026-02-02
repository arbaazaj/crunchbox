import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class RemoteSupabaseProductDataSource {
  Future<List<ProductModel>> getProducts();

  Future<List<CategoryModel>> getCategories();
}

class RemoteSupabaseProductDataSourceImpl
    implements RemoteSupabaseProductDataSource {
  final SupabaseClient supabaseClient;

  RemoteSupabaseProductDataSourceImpl(this.supabaseClient);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final data = await supabaseClient.from('products').select();
      return data.map((item) => ProductModel.fromMap(item)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final data = await supabaseClient.from('categories').select();
      return data.map((item) => CategoryModel.fromMap(item)).toList();
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }
}
