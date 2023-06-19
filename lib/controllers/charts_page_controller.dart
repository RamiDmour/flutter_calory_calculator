import 'package:collection/collection.dart';
import 'package:flutter_calory_calculator/api/reports_api.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/controllers/reports_controller.dart';
import 'package:flutter_calory_calculator/entity/chart_stats_entity.dart';
import 'package:flutter_calory_calculator/entity/date_period_entity.dart';
import 'package:flutter_calory_calculator/models/report.dart';
import 'package:get/get.dart';

class ChartsPageController extends GetxController {
  final datePeriod = Rx<DatePeriodEntity?>(null);
  final reports = RxList<Report>();
  final stats = RxList<ChartStatsEntity>();

  final ReportsApi _reportsApi;
  final ProfileController _profileController;
  final ReportsController _reportsController;
  ChartsPageController()
      : _reportsApi = Get.find<ReportsApi>(),
        _profileController = Get.find<ProfileController>(),
        _reportsController = Get.find<ReportsController>();

  void prevPeriod() {
    datePeriod.value = _getPeriodOfWeekday(datePeriod.value!.startDate.subtract(const Duration(days: 7)));
  }

  void nextPeriod() {
    datePeriod.value = _getPeriodOfWeekday(datePeriod.value!.startDate.add(const Duration(days: 7)));
  }

  DatePeriodEntity _getPeriodOfWeekday(DateTime date) {
    final startDate = date.subtract(Duration(days: date.weekday - 1));
    final endDate = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));

    return DatePeriodEntity(startDate: startDate, endDate: endDate);
  }

  ChartStatsEntity _calculateReport(Report report) {
    final weight = _profileController.selectedProfile.value!.weight;
    final caloryIntake = report.meals.fold(0.0, (accum, meal) => accum + meal.calory);
    final caloryBurned = report.activities.fold(
        0.0,
        (accum, reportActivity) =>
            accum + reportActivity.activity.caloryPerHour / 60 * reportActivity.minutes * weight);
    final fats = report.meals.fold(0.0, (accum, meal) => accum + meal.fats);
    final carbohydrates = report.meals.fold(0.0, (accum, meal) => accum + meal.carbohydrates);
    final proteins = report.meals.fold(0.0, (accum, meal) => accum + meal.proteins);

    return ChartStatsEntity(
      caloryIntake,
      proteins,
      fats,
      carbohydrates,
      report.water.toDouble(),
      DateTime.parse(report.date),
      caloryBurned,
    );
  }

  void _updateReports() async {
    reports.value = await _reportsApi.getReports(
      datePeriod.value!,
      _profileController.selectedProfile.value!.id!,
    );
    stats.value = reports.map((report) => _calculateReport(report)).sorted((a, b) => a.date.compareTo(b.date)).toList();
  }

  @override
  void onInit() async {
    datePeriod.value = _getPeriodOfWeekday(DateTime.now());

    _updateReports();

    ever(datePeriod, (period) => _updateReports());

    ever(_reportsController.report, (callback) => _updateReports());

    super.onInit();
  }
}
