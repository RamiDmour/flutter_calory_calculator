import 'package:flutter_calory_calculator/controllers/add_activity_controlller.dart';
import 'package:flutter_calory_calculator/controllers/add_meal_page_controller.dart';
import 'package:get/instance_manager.dart';

class AddActivityPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddActivityPageController());
  }
}
