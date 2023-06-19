import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/detailed_registration_controller.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/background_wrapper.dart';
import 'package:flutter_calory_calculator/widgets/common/button.dart';
import 'package:flutter_calory_calculator/widgets/common/input.dart';
import 'package:flutter_calory_calculator/widgets/common/selector.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DetailedRegistrationPage extends GetView<DetailedRegistrationController> {
  static const pageName = "/detailed-registration";
  const DetailedRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWrapper(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  "Введите свои данные",
                  style: TextStyle(
                    fontSize: 22,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 40,
                  child: Selector(
                    initValue: controller.gender.value,
                    values: const ["Мужской", "Женский"],
                    onChange: controller.selectGender,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 40,
                        child: Input(
                          controller: controller.firstNameController,
                          placeholderText: "Имя",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: SizedBox(
                        height: 40,
                        child: Input(
                          controller: controller.lastNameController,
                          placeholderText: "Фамилия",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 40,
                  child: Input(
                    keyboardType: TextInputType.datetime,
                    controller: controller.birthdayController,
                    placeholderText: "Дата рождения",
                    onTap: controller.pickDate,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: 40,
                        child: Input(
                          controller: controller.weightController,
                          placeholderText: "Вес, кг",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: SizedBox(
                        height: 40,
                        child: Input(
                          controller: controller.heightController,
                          placeholderText: "Рост, см",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  "Ваша цель",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 40,
                  child: Selector(
                    initValue: controller.goal.value,
                    values: const ["Потеря веса", "Поддержание веса", "Набор веса"],
                    onChange: controller.selectGoal,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Ваша образ жизни",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 40,
                  child: Selector(
                    initValue: controller.lifeStyle.value,
                    values: const ["Малоактивный", "Активный"],
                    onChange: controller.selectLifeStyle,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => Button(
                    isLoading: controller.isLoading.value,
                    onPressed: controller.submitProfileInfo,
                    text: "Далее",
                    textSize: 16,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
