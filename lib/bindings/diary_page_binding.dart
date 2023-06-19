import 'package:flutter_calory_calculator/api/activity_api.dart';
import 'package:flutter_calory_calculator/api/favorite_api.dart';
import 'package:flutter_calory_calculator/api/meals_api.dart';
import 'package:flutter_calory_calculator/api/products_api.dart';
import 'package:flutter_calory_calculator/api/reports_api.dart';
import 'package:flutter_calory_calculator/controllers/activities_controller.dart';
import 'package:flutter_calory_calculator/controllers/diary_page_controller.dart';
import 'package:flutter_calory_calculator/controllers/favorite_controller.dart';
import 'package:flutter_calory_calculator/controllers/norm_controller.dart';
import 'package:flutter_calory_calculator/controllers/products_controller.dart';
import 'package:flutter_calory_calculator/controllers/reports_controller.dart';
import 'package:flutter_calory_calculator/controllers/stats_controller.dart';
import 'package:flutter_calory_calculator/controllers/user_products_controller.dart';
import 'package:get/instance_manager.dart';

class DiaryPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ActivityApi());
    Get.put(MealsApi());
    Get.put(ReportsApi());
    Get.put(ReportsController());
    Get.put(StatsController());
    Get.put(NormController());
    Get.put(DiaryPageController());
    Get.put(ProductsApi());
    Get.put(ProductsController());
    Get.put(ActivitiesController());

    Get.lazyPut(() => UserProductsController());
    Get.lazyPut(() => FavoriteApi());
    Get.lazyPut(() => FavoriteController());
  }
}
