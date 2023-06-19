import 'dart:convert';

import 'package:flutter_calory_calculator/models/activity.dart';

class ReportActivity {
  final int id;
  final int minutes;
  final Activity activity;
  ReportActivity({
    required this.id,
    required this.minutes,
    required this.activity,
  });

  ReportActivity copyWith({
    int? id,
    int? minutes,
    Activity? activity,
  }) {
    return ReportActivity(
      id: id ?? this.id,
      minutes: minutes ?? this.minutes,
      activity: activity ?? this.activity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'minutes': minutes,
      'activity': activity.toMap(),
    };
  }

  factory ReportActivity.fromMap(Map<String, dynamic> map) {
    return ReportActivity(
      id: map['id']?.toInt() ?? 0,
      minutes: map['minutes']?.toInt() ?? 0,
      activity: Activity.fromMap(map['activity']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportActivity.fromJson(String source) => ReportActivity.fromMap(json.decode(source));

  @override
  String toString() => 'ReportActivity(id: $id, minutes: $minutes, activity: $activity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReportActivity && other.id == id && other.minutes == minutes && other.activity == activity;
  }

  @override
  int get hashCode => id.hashCode ^ minutes.hashCode ^ activity.hashCode;
}
