import 'package:flutter_calory_calculator/controllers/norm_controller.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/controllers/reports_controller.dart';
import 'package:flutter_calory_calculator/controllers/stats_controller.dart';
import 'package:flutter_calory_calculator/entity/report_entity.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:get/get.dart';

class DiaryPageController extends GetxController {
  final currentDate = Rx(DateTime.now());

  final StatsController statsController;
  final ReportsController reportsController;
  final NormController _normController;
  final ProfileController _profileController;
  DiaryPageController()
      : reportsController = Get.find<ReportsController>(),
        _normController = Get.find<NormController>(),
        statsController = Get.find<StatsController>(),
        _profileController = Get.find<ProfileController>();

  nextReport() {
    currentDate.value = currentDate.value.add(const Duration(days: 1));
  }

  prevReport() {
    currentDate.value = currentDate.value.subtract(const Duration(days: 1));
  }

  @override
  void onReady() {
    reportsController.fetchReport(DateTime.now());
    ever(currentDate, (d) {
      reportsController.fetchReport(d);
    });
    ever(_profileController.selectedProfile, (callback) => reportsController.fetchReport(currentDate.value));
    super.onReady();
  }

  removeMeal(MealType mealType, int mealId) {
    reportsController.removeMeal(mealType, mealId);
  }

  removeActivity(int activityId) {
    reportsController.removeActivity(activityId);
  }

  Rx<double> get caloryNorm => _normController.caloryNorm;
  Rx<ReportEntity?> get report => reportsController.report;
  Rx<bool> get isReportLoading => reportsController.loading;
}
