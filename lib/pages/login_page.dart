import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_calory_calculator/controllers/login_controller.dart';
import 'package:flutter_calory_calculator/pages/registration_page.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/button.dart';
import 'package:flutter_calory_calculator/widgets/common/input.dart';

class LoginPage extends GetView<LoginController> {
  static const pageName = "/auth";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/auth_background.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Вход",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Obx(
                      () => controller.error.isEmpty
                          ? const SizedBox()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    controller.error.value,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Input(
                      placeholderText: "Почта",
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    Input(
                      isPassword: true,
                      placeholderText: "Пароль",
                      controller: controller.passwordController,
                    ),
                    const SizedBox(height: 50),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        child: Button(
                          isLoading: controller.loading.value,
                          onPressed: controller.logIn,
                          text: "Войти",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Забыли пароль?",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "У вас ещё нет акканта?",
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () => Get.toNamed(RegistrationPage.pageName),
                    child: Text(
                      "Создать",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
