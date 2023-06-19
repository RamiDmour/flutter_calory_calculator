import 'package:flutter_calory_calculator/controllers/registration_controller.dart';
import 'package:get/instance_manager.dart';

class RegistrationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegistraionController());
  }
}
