import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/add_activity_controlller.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/expandable_activity.dart';
import 'package:flutter_calory_calculator/widgets/common/expandable_product.dart';
import 'package:flutter_calory_calculator/widgets/common/input.dart';
import 'package:get/get.dart';

class AddActivityPage extends GetView<AddActivityPageController> {
  static const pageName = "/add_activity_page";
  const AddActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 35,
            horizontal: 30,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
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
                ],
              ),
              const SizedBox(height: 80),
              SizedBox(
                height: 40,
                child: Input(
                  controller: controller.searchController,
                  placeholderText: "Найти активность",
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }
                  if (controller.activities.isEmpty) {
                    return const Center(
                      child: Text("Активности не найдены"),
                    );
                  }
                  return ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.activities.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: ExpandableActivity(
                        activity: controller.activities[i],
                        onTap: () => controller.addActivity(controller.activities[i]),
                        icon: const Icon(Icons.add),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
