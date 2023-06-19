import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/splash_controller.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  static const pageName = "/";
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/auth_background.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
