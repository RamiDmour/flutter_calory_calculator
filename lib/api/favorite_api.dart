import 'package:flutter_calory_calculator/models/favorite.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';

class FavoriteApi {
  static const tableName = 'favorite';

  Future<List<Favorite>> getFavoriteProductsByUserId(int userId) async {
    final favoriteProducts = await supabase
        .from(tableName)
        .select<List<Map<String, dynamic>>>(
            '*, product:products!inner(id, name, calory, proteins, fats, carbohydrates)')
        .eq('userId', userId);
    return favoriteProducts.map((product) => Favorite.fromMap(product)).toList();
  }

  Future<void> toggleFavoriteProduct(int userId, int productId) async {
    final favoriteProducts = await supabase
        .from(tableName)
        .select<List<Map<String, dynamic>>>(
            '*, product:products!inner(id, name, calory, proteins, fats, carbohydrates)')
        .eq('userId', userId)
        .eq('productId', productId);

    if (favoriteProducts.isEmpty) {
      await supabase.from(tableName).insert({"productId": productId, "userId": userId}).select().single();
    } else {
      await supabase.from(tableName).delete().eq('id', Favorite.fromMap(favoriteProducts.single).id);
    }
  }
}
