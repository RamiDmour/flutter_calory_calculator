import 'package:flutter_calory_calculator/controllers/login_controller.dart';
import 'package:get/instance_manager.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
