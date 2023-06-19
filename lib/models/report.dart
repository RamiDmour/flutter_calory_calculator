import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:flutter_calory_calculator/models/report_activity.dart';

class Report {
  final int id;
  final int water;
  final double mass;
  final String date;
  final List<Meal> meals;
  final List<ReportActivity> activities;
  Report({
    required this.id,
    required this.water,
    required this.mass,
    required this.date,
    required this.meals,
    required this.activities,
  });

  Report copyWith({
    int? id,
    int? water,
    double? mass,
    String? date,
    List<Meal>? meals,
    List<ReportActivity>? activities,
  }) {
    return Report(
      id: id ?? this.id,
      water: water ?? this.water,
      mass: mass ?? this.mass,
      date: date ?? this.date,
      meals: meals ?? this.meals,
      activities: activities ?? this.activities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'water': water,
      'mass': mass,
      'date': date,
      'meals': meals.map((x) => x.toMap()).toList(),
      'activities': activities.map((x) => x.toMap()).toList(),
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id']?.toInt() ?? 0,
      water: map['water']?.toInt() ?? 0,
      mass: map['mass']?.toDouble() ?? 0.0,
      date: map['date'] ?? '',
      meals: List<Meal>.from(map['meals']?.map((x) => Meal.fromMap(x))),
      activities: List<ReportActivity>.from(map['activities']?.map((x) => ReportActivity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Report(id: $id, water: $water, mass: $mass, date: $date, meals: $meals, activities: $activities)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Report &&
        other.id == id &&
        other.water == water &&
        other.mass == mass &&
        other.date == date &&
        listEquals(other.meals, meals) &&
        listEquals(other.activities, activities);
  }

  @override
  int get hashCode {
    return id.hashCode ^ water.hashCode ^ mass.hashCode ^ date.hashCode ^ meals.hashCode ^ activities.hashCode;
  }
}
