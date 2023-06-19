import 'package:flutter_calory_calculator/controllers/charts_page_controller.dart';
import 'package:get/get.dart';

class ChartsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChartsPageController());
  }
}
