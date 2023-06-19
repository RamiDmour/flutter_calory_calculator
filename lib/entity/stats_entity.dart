import 'dart:convert';

class StatsEntity {
  final double calorieIntake;
  final double proteins;
  final double fats;
  final double carbohydrates;

  StatsEntity({
    this.calorieIntake = 0,
    this.proteins = 0,
    this.fats = 0,
    this.carbohydrates = 0,
  });

  StatsEntity copyWith({
    double? calorieIntake,
    double? caloryBurned,
    double? proteins,
    double? fats,
    double? carbohydrates,
  }) {
    return StatsEntity(
      calorieIntake: calorieIntake ?? this.calorieIntake,
      proteins: proteins ?? this.proteins,
      fats: fats ?? this.fats,
      carbohydrates: carbohydrates ?? this.carbohydrates,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'calorieIntake': calorieIntake,
      'proteins': proteins,
      'fats': fats,
      'carbohydrates': carbohydrates,
    };
  }

  factory StatsEntity.fromMap(Map<String, dynamic> map) {
    return StatsEntity(
      calorieIntake: map['calorieIntake']?.toDouble() ?? 0.0,
      proteins: map['proteins']?.toDouble() ?? 0.0,
      fats: map['fats']?.toDouble() ?? 0.0,
      carbohydrates: map['carbohydrates']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatsEntity.fromJson(String source) => StatsEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StatsEntity(calorieIntake: $calorieIntake, proteins: $proteins, fats: $fats, carbohydrates: $carbohydrates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatsEntity &&
        other.calorieIntake == calorieIntake &&
        other.proteins == proteins &&
        other.fats == fats &&
        other.carbohydrates == carbohydrates;
  }

  operator +(StatsEntity other) {
    return StatsEntity(
      calorieIntake: calorieIntake + other.calorieIntake,
      carbohydrates: carbohydrates + other.carbohydrates,
      fats: fats + other.fats,
      proteins: proteins + proteins,
    );
  }

  @override
  int get hashCode {
    return calorieIntake.hashCode ^ proteins.hashCode ^ fats.hashCode ^ carbohydrates.hashCode;
  }
}
