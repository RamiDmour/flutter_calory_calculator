import 'package:flutter_calory_calculator/models/activity.dart';
import 'package:flutter_calory_calculator/models/report_activity.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';

class ActivityApi {
  static const tableName = "activities";
  static const linkedTableName = "report_activities";

  Future<List<Activity>> getActivities({int count = 20, int offset = 0}) async {
    final activities = await supabase
        .from(tableName)
        .select<List<Map<String, dynamic>>>()
        .range(offset + 1, offset + count)
        .order('name', ascending: true);

    return activities.map((product) => Activity.fromMap(product)).toList();
  }

  Future<ReportActivity> addActivity({required String name, required int minutes, required int reportId}) async {
    final activity = await supabase
        .from(linkedTableName)
        .insert({
          "report_id": reportId,
          "activity": name,
          "minutes": minutes,
        })
        .select('id, minutes, activity:activities!inner(name, calorie_per_hour)')
        .limit(1)
        .single();
    return ReportActivity.fromMap(activity);
  }

  Future<List<Activity>> searchActivities(String name) async {
    final activities =
        await supabase.from(tableName).select<List<Map<String, dynamic>>>().textSearch('name', name).limit(20);

    return activities.map((product) => Activity.fromMap(product)).toList();
  }

  Future<void> removeActivity(int activityId) async {
    await supabase.from(linkedTableName).delete().eq('id', activityId);
  }
}
