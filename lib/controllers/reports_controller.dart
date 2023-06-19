import 'package:flutter_calory_calculator/api/activity_api.dart';
import 'package:flutter_calory_calculator/api/meals_api.dart';
import 'package:flutter_calory_calculator/api/reports_api.dart';
import 'package:flutter_calory_calculator/controllers/diary_page_controller.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/entity/report_entity.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  final currentDate = Rx<DateTime>(DateTime.now());
  final Rx<ReportEntity?> report = Rx(null);
  final loading = false.obs;

  final ProfileController _profileController;
  final MealsApi _mealsApi;
  final ActivityApi _activityApi;
  final ReportsApi _reportsApi;
  ReportsController()
      : _profileController = Get.find<ProfileController>(),
        _activityApi = Get.find<ActivityApi>(),
        _mealsApi = Get.find<MealsApi>(),
        _reportsApi = Get.find<ReportsApi>();

  Future<void> fetchReport(DateTime date) async {
    loading.value = true;
    currentDate.value = date;
    final report = await _reportsApi.getReport(
      date,
      _profileController.selectedProfile.value?.id,
    );

    if (report != null) {
      this.report.value = ReportEntity(
        id: report.id,
        water: report.water,
        date: DateTime.parse(report.date),
        meals: report.meals,
        mass: report.mass,
        activities: report.activities,
      );
    } else {
      this.report.value = null;
    }
    loading.value = false;
  }

  Future<void> addProduct(MealType mealType, int gramm, int productId) async {
    if (report.value == null) {
      final profileId = _profileController.selectedProfile.value!.id;

      final report = await _reportsApi.createReport(
        profileId!,
        currentDate.value,
        _profileController.selectedProfile.value!.weight,
      );

      this.report.value = ReportEntity(
        id: report.id,
        water: report.water,
        date: DateTime.parse(report.date),
        meals: report.meals,
        activities: report.activities,
        mass: report.mass,
      );
    }
    final meal = await _mealsApi.addMeal(
      reportId: report.value!.id,
      productId: productId,
      gramm: gramm,
      mealType: mealType,
    );
    report.value = report.value!.copyWith(
      meals: [...report.value!.meals, meal],
    );
  }

  Future<void> addActivity(String name, int minutes) async {
    if (report.value == null) {
      final profileId = _profileController.selectedProfile.value!.id;

      final report = await _reportsApi.createReport(
        profileId!,
        currentDate.value,
        _profileController.selectedProfile.value!.weight,
      );

      this.report.value = ReportEntity(
        id: report.id,
        water: report.water,
        date: DateTime.parse(report.date),
        meals: report.meals,
        activities: report.activities,
        mass: report.mass,
      );
    }
    final meal = await _activityApi.addActivity(reportId: report.value!.id, minutes: minutes, name: name);
    report.value = report.value!.copyWith(
      activities: [...report.value!.activities, meal],
    );
  }

  Future<void> removeMeal(MealType mealType, int mealId) async {
    report.value = report.value!.copyWith(
      meals: report.value!.meals.where((meal) => meal.id != mealId).toList(),
    );
    _mealsApi.removeMeal(mealId);
  }

  Future<void> removeActivity(int activityId) async {
    report.value = report.value!.copyWith(
      activities: report.value!.activities.where((activity) => activity.id != activityId).toList(),
    );
    _activityApi.removeActivity(activityId);
  }
}
