import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/profiles_page_controller.dart';
import 'package:flutter_calory_calculator/pages/detailed_registration_page.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:get/get.dart';

class ProfilesPage extends GetView<ProfilesPageController> {
  static const pageName = "/profiles-page";
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Get.toNamed(DetailedRegistrationPage.pageName),
        child: Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/auth_background.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                "Список спортсменов",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(32),
                          itemCount: controller.profiles.length,
                          itemBuilder: (_, i) {
                            final profile = controller.profiles[i];
                            return InkWell(
                              onTap: () => controller.selectProfile(profile),
                              child: Text(
                                "${i + 1}. ${profile.firstName} ${profile.lastName} ${profile.birthday}",
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
