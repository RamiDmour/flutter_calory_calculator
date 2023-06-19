import 'dart:convert';

import 'package:flutter_calory_calculator/models/product.dart';

class Favorite {
  final int id;
  final int userId;
  final Product product;
  Favorite({
    required this.id,
    required this.userId,
    required this.product,
  });

  Favorite copyWith({
    int? id,
    int? userId,
    Product? product,
  }) {
    return Favorite(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'product': product.toMap(),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      product: Product.fromMap(map['product']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) => Favorite.fromMap(json.decode(source));

  @override
  String toString() => 'Favorite(id: $id, userId: $userId, product: $product)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Favorite && other.id == id && other.userId == userId && other.product == product;
  }

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ product.hashCode;
}
