import 'dart:convert';

class Product {
  final int id;
  final String name;
  final double calory;
  final double proteins;
  final double fats;
  final double carbohydrates;
  final int? userId;
  Product({
    required this.id,
    required this.name,
    required this.calory,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
    this.userId,
  });

  Product copyWith({
    int? id,
    String? name,
    double? calory,
    double? proteins,
    double? fats,
    double? carbohydrates,
    int? userId,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      calory: calory ?? this.calory,
      proteins: proteins ?? this.proteins,
      fats: fats ?? this.fats,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calory': calory,
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates,
      'user_id': userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      calory: map['calory']?.toDouble() ?? 0.0,
      proteins: map['proteins']?.toDouble() ?? 0.0,
      fats: map['fats']?.toDouble() ?? 0.0,
      carbohydrates: map['carbohydrates']?.toDouble() ?? 0.0,
      userId: map['user_id']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, calory: $calory, proteins: $proteins, fats: $fats, carbohydrates: $carbohydrates, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.calory == calory &&
        other.proteins == proteins &&
        other.fats == fats &&
        other.carbohydrates == carbohydrates &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        calory.hashCode ^
        proteins.hashCode ^
        fats.hashCode ^
        carbohydrates.hashCode ^
        userId.hashCode;
  }
}
