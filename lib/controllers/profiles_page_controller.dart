import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/profile.dart';
import 'package:flutter_calory_calculator/pages/diary_page.dart';
import 'package:get/get.dart';

class ProfilesPageController extends GetxController {
  final ProfileController _profileController;

  ProfilesPageController() : _profileController = Get.find<ProfileController>();

  selectProfile(Profile profile) {
    _profileController.selectedProfile.value = profile;
    Get.toNamed(DiaryPage.pageName);
  }

  @override
  void onInit() {
    _profileController.fetchProfiles();
    super.onInit();
  }

  RxBool get isLoading => _profileController.loading;
  RxList<Profile> get profiles => _profileController.profiles;
}
