import 'package:flutter_calory_calculator/controllers/detailed_registration_controller.dart';
import 'package:get/instance_manager.dart';

class DetailedRegistrationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailedRegistrationController());
  }
}
