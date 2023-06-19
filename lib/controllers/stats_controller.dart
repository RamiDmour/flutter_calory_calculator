import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/controllers/reports_controller.dart';
import 'package:flutter_calory_calculator/entity/stats_entity.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:get/get.dart';

class StatsController extends GetxController {
  final Rx<StatsEntity> breakfast = Rx(StatsEntity());
  final Rx<StatsEntity> lunch = Rx(StatsEntity());
  final Rx<StatsEntity> dinner = Rx(StatsEntity());
  final Rx<StatsEntity> supper = Rx(StatsEntity());
  final minutes = Rx(0);
  final coloryBurned = Rx(0);

  final ReportsController _reportsController;
  final ProfileController _profileController;
  StatsController()
      : _reportsController = Get.find<ReportsController>(),
        _profileController = Get.find<ProfileController>();

  @override
  void onReady() {
    ever(_reportsController.report, (rep) {
      if (rep != null) {
        breakfast.value = _calculateMeal(rep.meals.where((meal) => meal.mealType == MealType.breakfast));
        lunch.value = _calculateMeal(rep.meals.where((meal) => meal.mealType == MealType.lunch));
        dinner.value = _calculateMeal(rep.meals.where((meal) => meal.mealType == MealType.dinner));
        supper.value = _calculateMeal(rep.meals.where((meal) => meal.mealType == MealType.supper));
        coloryBurned.value = rep.activities.fold(
          0,
          (accum, activity) => (accum +
                  activity.minutes * activity.activity.caloryPerHour / 60 * _profileController.profile.value!.weight)
              .round(),
        );
        minutes.value = rep.activities.fold(0, (accum, activity) => accum + activity.minutes);
      } else {
        dinner.value = StatsEntity();
        lunch.value = StatsEntity();
        supper.value = StatsEntity();
        breakfast.value = StatsEntity();
        minutes.value = 0;
        coloryBurned.value = 0;
      }
    });
    super.onReady();
  }

  StatsEntity _calculateMeal(Iterable<Meal> meals) {
    final calory = meals.fold(
      0.0,
      (prev, meal) => prev + meal.calory,
    );
    final proteins = meals.fold(
      0.0,
      (prev, meal) => prev + meal.gramm / 100 * meal.product.proteins,
    );
    final fats = meals.fold(
      0.0,
      (prev, meal) => prev + meal.gramm / 100 * meal.product.fats,
    );
    final carbohydrates = meals.fold(
      0.0,
      (prev, meal) => prev + meal.gramm / 100 * meal.product.carbohydrates,
    );

    return StatsEntity(
      calorieIntake: calory,
      carbohydrates: carbohydrates,
      fats: fats,
      proteins: proteins,
    );
  }

  StatsEntity get result => breakfast.value + lunch.value + dinner.value + supper.value;
}
