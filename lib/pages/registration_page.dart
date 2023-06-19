import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/registration_controller.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/button.dart';
import 'package:flutter_calory_calculator/widgets/common/input.dart';
import 'package:get/get.dart';

class RegistrationPage extends GetView<RegistraionController> {
  static const pageName = "/registration";
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: pageName,
      child: Scaffold(
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
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Регистрация",
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
                                      Flexible(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            controller.error.value,
                                            style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                            ),
                                          ),
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
                              text: "Зарегистрироваться",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
