import 'package:flutter_calory_calculator/api/activity_api.dart';
import 'package:flutter_calory_calculator/models/activity.dart';
import 'package:get/get.dart';

class ActivitiesController extends GetxController {
  final activities = <Activity>[].obs;
  final searchedActivities = <Activity>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final error = Rx<String?>(null);
  final offset = 0.obs;

  final ActivityApi _api;
  ActivitiesController() : _api = Get.find<ActivityApi>();

  @override
  void onReady() {
    initFetch();
    super.onReady();
  }

  initFetch() async {
    isLoading.value = true;
    await loadMore();
    isLoading.value = false;
  }

  loadMore() async {
    try {
      isLoadingMore.value = true;

      activities.addAll(await _api.getActivities(offset: offset.value));
      offset.value += 20;
    } catch (e) {
      error.value = e.toString();
    }
    isLoadingMore.value = false;
  }

  searchActivities(String name) async {
    try {
      isLoading.value = true;

      searchedActivities.clear();
      searchedActivities.addAll(await _api.searchActivities(name));
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
