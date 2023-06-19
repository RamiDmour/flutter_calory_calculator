import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/activities_controller.dart';
import 'package:flutter_calory_calculator/controllers/products_controller.dart';
import 'package:flutter_calory_calculator/controllers/reports_controller.dart';
import 'package:flutter_calory_calculator/entity/report_entity.dart';
import 'package:flutter_calory_calculator/models/activity.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:flutter_calory_calculator/widgets/common/input_dialog.dart';
import 'package:get/get.dart';

class AddActivityPageController extends GetxController {
  final ActivitiesController _activitiesController;
  final ReportsController _reportsController;

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final minutesInput = Rx("0");
  final _searchValue = Rx<String?>(null);
  AddActivityPageController()
      : _activitiesController = Get.find<ActivitiesController>(),
        _reportsController = Get.find<ReportsController>();

  @override
  void onInit() {
    searchController.addListener(() {
      _searchValue.value = searchController.text;
    });
    debounce(
      _searchValue,
      (value) {
        if (value != null && value.isNotEmpty) {
          _activitiesController.searchActivities(value);
        }
      },
      time: const Duration(seconds: 1),
    );
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 500 && !isLoadingMore.value) {
        _activitiesController.loadMore();
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  addActivity(Activity activity) async {
    await Get.dialog(
      InputDialog(
        onSave: () async {
          _reportsController.addActivity(
            activity.name,
            int.parse(minutesInput.value),
          );
          Get.back();
          Get.snackbar("Активность была успешно добавлена", "");
        },
        onDecline: () => Get.back(),
        titleText: "Введите время (минуты)",
        onChanged: (text) => minutesInput.value = text!,
        placeholderText: minutesInput.value.toString(),
      ),
    );
  }

  RxBool get isLoadingMore => _activitiesController.isLoadingMore;
  RxBool get isLoading => _activitiesController.isLoading;
  RxList<Activity> get activities => _searchValue.value != null && _searchValue.value!.isNotEmpty
      ? _activitiesController.searchedActivities
      : _activitiesController.activities;
  Rx<ReportEntity?> get report => _reportsController.report;
}
