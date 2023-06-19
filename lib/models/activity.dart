import 'dart:convert';

class Activity {
  final String name;
  final int caloryPerHour;
  Activity({
    required this.name,
    required this.caloryPerHour,
  });

  Activity copyWith({
    String? name,
    int? caloryPerHour,
  }) {
    return Activity(
      name: name ?? this.name,
      caloryPerHour: caloryPerHour ?? this.caloryPerHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'calorie_per_hour': caloryPerHour,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      name: map['name'] ?? '',
      caloryPerHour: map['calorie_per_hour']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source));

  @override
  String toString() => 'Activity(name: $name, calorie_per_hour: $caloryPerHour)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Activity && other.name == name && other.caloryPerHour == caloryPerHour;
  }

  @override
  int get hashCode => name.hashCode ^ caloryPerHour.hashCode;
}
