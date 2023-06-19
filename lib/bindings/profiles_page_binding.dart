import 'package:flutter_calory_calculator/controllers/profiles_page_controller.dart';
import 'package:get/get.dart';

class ProfilesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfilesPageController());
  }
}
