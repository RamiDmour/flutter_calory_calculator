import 'dart:convert';

import 'package:flutter_calory_calculator/models/product.dart';

enum MealType {
  breakfast,
  lunch,
  dinner,
  supper,
}

extension ConvertMealType on MealType {
  String toLocaleString() {
    switch (this) {
      case MealType.breakfast:
        return "Завтрак";
      case MealType.lunch:
        return "Обед";
      case MealType.dinner:
        return "Ужин";
      case MealType.supper:
        return "Перекус";
    }
  }

  String toApiString() => toString().split('.').last;
}

class Meal {
  final int id;
  final MealType mealType;
  final int gramm;
  final Product product;
  Meal({
    required this.id,
    required this.mealType,
    required this.gramm,
    required this.product,
  });

  Meal copyWith({
    int? id,
    MealType? mealType,
    int? gramm,
    Product? product,
  }) {
    return Meal(
      id: id ?? this.id,
      mealType: mealType ?? this.mealType,
      gramm: gramm ?? this.gramm,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'meal_type': mealType,
      'gramm': gramm,
      'product': product.toMap(),
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      mealType: MealType.values.byName(map['meal_type']),
      gramm: map['gramm']?.toInt() ?? 0,
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Meal.fromJson(String source) => Meal.fromMap(json.decode(source));

  @override
  String toString() => 'Meal(meal_type: ${mealType.toString()}, gramm: $gramm, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Meal && other.mealType == mealType && other.gramm == gramm && other.product == product;
  }

  double get calory => gramm / 100 * product.calory;
  double get proteins => gramm / 100 * product.proteins;
  double get fats => gramm / 100 * product.fats;
  double get carbohydrates => gramm / 100 * product.carbohydrates;

  @override
  int get hashCode => mealType.hashCode ^ gramm.hashCode ^ product.hashCode;
}
