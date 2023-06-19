import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/pages/diary_page.dart';
import 'package:flutter_calory_calculator/pages/splash_page.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
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
    loading.value = true;

    try {
      final res = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (res.session != null) {
        Get.offAndToNamed(SplashPage.pageName);
      }
    } catch (e) {
      if (e is AuthException) {
        if (e.statusCode == "400") {
          error.value = "Введены неккоректные данные ";
        }
      }
    }
    loading.value = false;
  }
}
