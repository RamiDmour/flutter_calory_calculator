import 'package:flutter_calory_calculator/controllers/splash_controller.dart';
import 'package:get/instance_manager.dart';

class SplashPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
