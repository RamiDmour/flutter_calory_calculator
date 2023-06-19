import 'package:flutter_calory_calculator/api/favorite_api.dart';
import 'package:flutter_calory_calculator/controllers/add_meal_page_controller.dart';
import 'package:flutter_calory_calculator/controllers/favorite_controller.dart';
import 'package:flutter_calory_calculator/controllers/user_products_controller.dart';
import 'package:get/instance_manager.dart';

class AddMealPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserProductsController());
    Get.put(FavoriteApi());
    Get.put(FavoriteController());
    Get.put(AddMealPageController());
  }
}
