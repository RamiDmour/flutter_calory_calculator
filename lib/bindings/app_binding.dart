import 'package:flutter_calory_calculator/api/profile_api.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileApi());
    Get.put(ProfileController());
  }
}
