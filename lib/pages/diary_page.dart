import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/diary_page_controller.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:flutter_calory_calculator/pages/add_activity_page.dart';
import 'package:flutter_calory_calculator/pages/add_meal_page.dart';
import 'package:flutter_calory_calculator/pages/profile_page.dart';
import 'package:flutter_calory_calculator/pages/profiles_page.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/custom_bottom_navigation_bar.dart';
import 'package:flutter_calory_calculator/widgets/common/expandable_activity_item.dart';
import 'package:flutter_calory_calculator/widgets/common/expandable_item.dart';
import 'package:flutter_calory_calculator/widgets/diary/stat_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DiaryPage extends GetView<DiaryPageController> {
  static const pageName = "/diary-page";
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statsController = controller.statsController;

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Get.toNamed(ProfilesPage.pageName),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: controller.prevReport,
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Text(DateFormat('EEEE, d MMMM', 'ru').format(controller.currentDate.value)),
                      IconButton(
                        onPressed: controller.nextReport,
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.toNamed(ProfilePage.pageName),
                        child: Image.asset('assets/images/profile_icon.png'),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Калории и БЖУ",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 25),
                  controller.isReportLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: StatItem(
                                    name: "Потреблено",
                                    value: "${statsController.result.calorieIntake.toInt()} ккал",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: StatItem(
                                    name: "Норма",
                                    value: "${controller.caloryNorm.toInt()} ккал",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: StatItem(
                                    name: "Сожжено",
                                    value: "${statsController.coloryBurned.value} ккал",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: StatItem(
                                    name: "Белки",
                                    value: "${statsController.result.proteins.toInt()} г",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: StatItem(
                                    name: "Жиры",
                                    value: "${statsController.result.fats.toInt()} г",
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: StatItem(
                                    name: "Углеводы",
                                    value: "${statsController.result.carbohydrates.toInt()} г",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            ExpandableItem(
                              stats: statsController.breakfast.value,
                              header: "Завтрак",
                              meals: controller.report.value?.meals
                                  .where((meal) => meal.mealType == MealType.breakfast)
                                  .toList(),
                              onAdd: () => Get.toNamed(
                                AddMealPage.pageName,
                                arguments: MealType.breakfast,
                              ),
                              onMealRemove: (id) => controller.removeMeal(MealType.breakfast, id),
                            ),
                            const SizedBox(height: 10),
                            ExpandableItem(
                              stats: statsController.lunch.value,
                              header: "Обед",
                              meals: controller.report.value?.meals
                                  .where((meal) => meal.mealType == MealType.lunch)
                                  .toList(),
                              onAdd: () => Get.toNamed(
                                AddMealPage.pageName,
                                arguments: MealType.lunch,
                              ),
                              onMealRemove: (id) => controller.removeMeal(MealType.lunch, id),
                            ),
                            const SizedBox(height: 10),
                            ExpandableItem(
                              stats: statsController.dinner.value,
                              header: "Ужин",
                              meals: controller.report.value?.meals
                                  .where((meal) => meal.mealType == MealType.dinner)
                                  .toList(),
                              onAdd: () => Get.toNamed(
                                AddMealPage.pageName,
                                arguments: MealType.dinner,
                              ),
                              onMealRemove: (id) => controller.removeMeal(MealType.dinner, id),
                            ),
                            const SizedBox(height: 10),
                            ExpandableItem(
                              stats: statsController.supper.value,
                              header: "Перекус",
                              meals: controller.report.value?.meals
                                  .where((meal) => meal.mealType == MealType.supper)
                                  .toList(),
                              onAdd: () => Get.toNamed(
                                AddMealPage.pageName,
                                arguments: MealType.supper,
                              ),
                              onMealRemove: (id) => controller.removeMeal(MealType.supper, id),
                            ),
                            const SizedBox(height: 10),
                            ExpandableActivityItem(
                              header: "Активности",
                              activities: controller.report.value?.activities,
                              onAdd: () => Get.toNamed(AddActivityPage.pageName),
                              onReportRemove: (id) => controller.removeActivity(id),
                              minutes: statsController.minutes.value,
                              caloryBurned: statsController.coloryBurned.value,
                              weight: Get.find<ProfileController>().profile.value!.weight,
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
