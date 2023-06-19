import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/pages/detailed_registration_page.dart';
import 'package:flutter_calory_calculator/pages/diary_page.dart';
import 'package:flutter_calory_calculator/pages/login_page.dart';
import 'package:flutter_calory_calculator/pages/profiles_page.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final ProfileController _profileController;
  SplashController() : _profileController = Get.find<ProfileController>();

  @override
  void onReady() {
    init();
    super.onReady();
  }

  init() async {
    await Future.delayed(Duration.zero);
    if (supabase.auth.currentSession != null) {
      await _profileController.fetchProfile(supabase.auth.currentUser!.email!);

      if (_profileController.profile.value == null) {
        Get.offAndToNamed(DetailedRegistrationPage.pageName);
      } else {
        Get.offAndToNamed(ProfilesPage.pageName);
      }
    } else {
      Get.offAndToNamed(LoginPage.pageName);
    }
  }
}
