import 'package:flutter_calory_calculator/entity/date_period_entity.dart';
import 'package:flutter_calory_calculator/models/report.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';
import 'package:intl/intl.dart';

class ReportsApi {
  static const tableName = "reports";

  Future<Report?> getReport(DateTime date, [int? userId]) async {
    final reports = await supabase
        .from(tableName)
        .select<List<Map<String, dynamic>>>(
            '*, meals(id, meal_type, gramm, product:products!inner(name, calory, proteins, fats, carbohydrates)), activities:report_activities(id, minutes, activity:activities!inner(name, calorie_per_hour))')
        .eq('date', date)
        .eq('userId', userId ?? supabase.auth.currentUser!.id);
    if (reports.isNotEmpty) {
      return Report.fromMap(reports.first);
    }

    return null;
  }

  Future<List<Report>> getReports(DatePeriodEntity period, int userId) async {
    final reports = await supabase
        .from(tableName)
        .select<List<Map<String, dynamic>>>(
            '*, meals(id, meal_type, gramm, product:products!inner(name, calory, proteins, fats, carbohydrates)), activities:report_activities(id, minutes, activity:activities!inner(name, calorie_per_hour))')
        .lt('date', period.endDate.add(const Duration(days: 1)))
        .gt('date', period.startDate.subtract(const Duration(days: 1)))
        .eq('userId', userId);

    return reports.map((report) => Report.fromMap(report)).toList();
  }

  Future<Report> createReport(int userId, DateTime date, double weight) async {
    return Report.fromMap(await supabase
        .from(tableName)
        .insert({
          'userId': userId,
          'date': DateFormat(DateFormat.YEAR_MONTH_DAY).format(date),
          'weight': weight,
        })
        .select(
            "*, meals(id, meal_type, gramm, product:products!inner(name, calory, proteins, fats, carbohydrates)), activities:report_activities(id, minutes, activity:activities!inner(name, calorie_per_hour))")
        .limit(1)
        .single());
  }
}
