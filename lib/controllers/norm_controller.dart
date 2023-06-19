import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/profile.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NormController extends GetxController {
  final caloryNorm = 0.0.obs;
  final ProfileController _profileController;
  NormController() : _profileController = Get.find<ProfileController>();

  _calculateCaloryNorm(Profile profile) {
    final age = DateTime.now().year - DateFormat('dd.MM.yyyy').parse(profile.birthday).year;
    final weight = profile.weight;
    final height = profile.height;
    final gender = profile.gender;
    final physicalActivityCoef = profile.lifeStyle == "Малоактивный" ? 1.4 : 2;
    final goal = profile.goal;

    late double bmr;

    if (gender == "Мужской") {
      bmr = 66.4730 + 13.7516 * weight + 5.0033 * height - 6.7550 * age;
    } else if (gender == "Женский") {
      bmr = 655.0955 + 9.5634 * weight + 1.8496 * height - 4.6756 * age;
    }

    final caloryNorm = bmr * physicalActivityCoef;

    if (goal == "Потеря веса") {
      return caloryNorm * 0.85;
    } else if (goal == "Набор веса") {
      return caloryNorm * 1.15;
    } else {
      return caloryNorm;
    }
  }

  @override
  void onReady() {
    caloryNorm.value = _calculateCaloryNorm(_profileController.selectedProfile.value!);
    ever(_profileController.selectedProfile, (profile) {
      if (profile != null) {
        caloryNorm.value = _calculateCaloryNorm(profile);
      }
    });
    super.onReady();
  }
}
