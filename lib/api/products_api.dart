import 'package:flutter_calory_calculator/models/product.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductsApi {
  static const tableName = 'products';

  Future<List<Product>> getProducts({
    int count = 20,
    int offset = 0,
    required int userId,
  }) async {
    final products = await supabase
        .from(tableName)
        .select<List<Map<String, dynamic>>>()
        .or('user_id.is.null,user_id.eq.$userId')
        .range(offset + 1, offset + count)
        .order('name', ascending: true);
    return products.map((product) => Product.fromMap(product)).toList();
  }

  Future<List<Product>> getUserProducts(int userId) async {
    final products = await supabase.from(tableName).select<List<Map<String, dynamic>>>().eq('user_id', userId);

    return products.map((product) => Product.fromMap(product)).toList();
  }

  Future<List<Product>> searchProducts(String name, int userId) async {
    final products = await supabase
        .from(tableName)
        .select<List<Map<String, dynamic>>>()
        .or('user_id.is.null,user_id.eq.$userId')
        .textSearch(
          'name',
          "'$name'",
        )
        .limit(20);
    print(name);
    return products.map((product) => Product.fromMap(product)).toList();
  }

  Future<Product> createProduct(Product product) async {
    final productMap = product.toMap();
    productMap.remove("id");

    final createdProduct =
        await supabase.from(tableName).insert(productMap).select<Map<String, dynamic>>().limit(1).single();

    return Product.fromMap(createdProduct);
  }
}
