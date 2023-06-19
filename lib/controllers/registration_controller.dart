import 'package:flutter/cupertino.dart';
import 'package:flutter_calory_calculator/pages/detailed_registration_page.dart';
import 'package:flutter_calory_calculator/pages/diary_page.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistraionController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final error = "".obs;
  final loading = false.obs;

  void logIn() async {
    if (!emailController.text.isEmail) {
      error.value = "Введите корректный email";
      return;
    }
    if (passwordController.text.isEmpty) {
      error.value = "Введите пароль";
      return;
    }
    if (passwordController.text.length < 6) {
      error.value = "Минимальная длинна пароля - 6 символов";
    }
    loading.value = true;

    try {
      final res = await supabase.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
      );
      if (res.user != null) {
        Get.toNamed(DetailedRegistrationPage.pageName);
      }
    } catch (e) {
      printError(info: e.toString());
      if (e is AuthException) {
        if (e.statusCode == "400") {
          error.value = "Введены неккоректные данные ";
        }
      }
    }
    loading.value = false;
  }
}
