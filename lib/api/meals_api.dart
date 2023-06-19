import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';

class MealsApi {
  static const tableName = 'meals';

  Future<Meal> addMeal({
    required int reportId,
    required int productId,
    required int gramm,
    required MealType mealType,
  }) async {
    final meal = await supabase
        .from(tableName)
        .insert({
          "product_id": productId,
          "report_id": reportId,
          "gramm": gramm,
          "meal_type": mealType.toApiString(),
        })
        .select('id, meal_type, gramm, product:products!inner(name, calory, proteins, fats, carbohydrates)')
        .limit(1)
        .single();
    return Meal.fromMap(meal);
  }

  Future<void> removeMeal(int mealId) async {
    await supabase.from(tableName).delete().eq('id', mealId);
  }
}
