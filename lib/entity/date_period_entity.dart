import 'dart:convert';

class DatePeriodEntity {
  final DateTime startDate;
  final DateTime endDate;
  DatePeriodEntity({
    required this.startDate,
    required this.endDate,
  });

  DatePeriodEntity copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return DatePeriodEntity(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  factory DatePeriodEntity.fromMap(Map<String, dynamic> map) {
    return DatePeriodEntity(
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DatePeriodEntity.fromJson(String source) => DatePeriodEntity.fromMap(json.decode(source));

  @override
  String toString() => 'DatePeriodEntity(startDate: $startDate, endDate: $endDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DatePeriodEntity && other.startDate == startDate && other.endDate == endDate;
  }

  @override
  int get hashCode => startDate.hashCode ^ endDate.hashCode;
}
