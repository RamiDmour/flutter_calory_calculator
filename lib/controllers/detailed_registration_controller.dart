import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/profile.dart';
import 'package:flutter_calory_calculator/pages/profiles_page.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailedRegistrationController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final birthdayController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  final gender = "Мужской".obs;
  final goal = "Потеря веса".obs;
  final lifeStyle = "Активный".obs;

  final isLoading = false.obs;

  final ProfileController _profileController;
  DetailedRegistrationController() : _profileController = Get.find<ProfileController>();

  pickDate() async {
    final initialDateTime = DateTime.now();

    final birthDay = await showDatePicker(
      context: Get.context!,
      initialDate: initialDateTime,
      firstDate: initialDateTime.subtract(const Duration(days: 366 * 100)),
      lastDate: initialDateTime,
    );
    if (birthDay != null) {
      final formattedDate = DateFormat('dd.MM.yyyy').format(birthDay);
      birthdayController.text = formattedDate;
    }
  }

  selectGender(String gender) => this.gender.value = gender;
  selectGoal(String goal) => this.goal.value = goal;
  selectLifeStyle(String lifeStyle) => this.lifeStyle.value = lifeStyle;

  submitProfileInfo() async {
    isLoading.value = true;
    await _profileController.addProfile(Profile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: supabase.auth.currentUser!.email!,
      gender: gender.value,
      birthday: birthdayController.text,
      weight: double.parse(weightController.text),
      height: int.parse(heightController.text),
      goal: goal.value,
      lifeStyle: lifeStyle.value,
    ));
    Get.offAndToNamed(ProfilesPage.pageName);
    _profileController.fetchProfiles();
    isLoading.value = false;
  }
}
