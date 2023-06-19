import 'package:flutter_calory_calculator/api/profile_api.dart';
import 'package:flutter_calory_calculator/models/profile.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final profile = Rx<Profile?>(null);
  final selectedProfile = Rx<Profile?>(null);
  final profiles = RxList<Profile>();
  final loading = false.obs;

  final ProfileApi _api;
  ProfileController() : _api = Get.find<ProfileApi>();

  fetchProfile(String email) async {
    loading.value = true;

    final profile = await _api.getProfile(email);
    this.profile.value = profile;

    loading.value = false;
  }

  fetchProfiles() async {
    loading.value = true;

    profiles.value = await _api.getProfiles();

    loading.value = false;
  }

  addProfile(Profile profile) async {
    loading.value = true;

    await _api.addProfile(profile);

    this.profile.value = profile;

    loading.value = true;
  }
}
