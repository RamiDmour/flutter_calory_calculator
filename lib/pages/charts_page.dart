import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/charts_page_controller.dart';
import 'package:flutter_calory_calculator/pages/profile_page.dart';
import 'package:flutter_calory_calculator/pages/profiles_page.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/chart.dart';
import 'package:flutter_calory_calculator/widgets/common/custom_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChartsPage extends GetView<ChartsPageController> {
  static const pageName = "/charts-page";
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  final startDate = DateFormat('d MMMM', 'ru').format(controller.datePeriod.value!.startDate);
                  final endDate = DateFormat('d MMMM', 'ru').format(controller.datePeriod.value!.endDate);
                  return Row(
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
                        onPressed: controller.prevPeriod,
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      Text("$startDate-$endDate"),
                      IconButton(
                        onPressed: controller.nextPeriod,
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.toNamed(ProfilePage.pageName),
                        child: Image.asset('assets/images/profile_icon.png'),
                      )
                    ],
                  );
                }),
                Obx(
                  () => Column(
                    children: [
                      Chart(
                        data: controller.stats.map((stat) => ChartData(stat.date, stat.caloryIntake)).toList(),
                        title: "Полученные калории",
                      ),
                      Chart(
                        data: controller.stats.map((stat) => ChartData(stat.date, stat.caloryBurned)).toList(),
                        title: "Затраченные калории",
                      ),
                      Chart(
                        data: controller.stats.map((stat) => ChartData(stat.date, stat.water)).toList(),
                        title: "Выпито воды",
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}
