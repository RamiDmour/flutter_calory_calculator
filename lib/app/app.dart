import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_calory_calculator/bindings/add_activity_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/add_meal_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/app_binding.dart';
import 'package:flutter_calory_calculator/bindings/charts_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/detailed_registration_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/diary_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/login_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/measurements_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/profiles_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/registration_page_binding.dart';
import 'package:flutter_calory_calculator/bindings/splash_page_binding.dart';
import 'package:flutter_calory_calculator/pages/add_activity_page.dart';
import 'package:flutter_calory_calculator/pages/add_meal_page.dart';
import 'package:flutter_calory_calculator/pages/charts_page.dart';
import 'package:flutter_calory_calculator/pages/detailed_registration_page.dart';
import 'package:flutter_calory_calculator/pages/diary_page.dart';
import 'package:flutter_calory_calculator/pages/login_page.dart';
import 'package:flutter_calory_calculator/pages/measurements_page.dart';
import 'package:flutter_calory_calculator/pages/profile_page.dart';
import 'package:flutter_calory_calculator/pages/profiles_page.dart';
import 'package:flutter_calory_calculator/pages/registration_page.dart';
import 'package:flutter_calory_calculator/pages/splash_page.dart';
import 'package:get/route_manager.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: ChartsPage.pageName,
          page: () => const ChartsPage(),
          binding: ChartsPageBinding(),
        ),
        GetPage(
          name: MeasurementsPage.pageName,
          page: () => const MeasurementsPage(),
          binding: MeasurementsPageBinding(),
        ),
        GetPage(
          name: ProfilesPage.pageName,
          page: () => const ProfilesPage(),
          binding: ProfilesPageBinding(),
        ),
        GetPage(
          name: LoginPage.pageName,
          page: () => const LoginPage(),
          binding: LoginPageBinding(),
        ),
        GetPage(
          name: SplashPage.pageName,
          page: () => const SplashPage(),
          binding: SplashPageBinding(),
        ),
        GetPage(
          name: DiaryPage.pageName,
          page: () => const DiaryPage(),
          binding: DiaryPageBinding(),
        ),
        GetPage(
          name: RegistrationPage.pageName,
          page: () => const RegistrationPage(),
          binding: RegistrationPageBinding(),
        ),
        GetPage(
          name: DetailedRegistrationPage.pageName,
          page: () => const DetailedRegistrationPage(),
          binding: DetailedRegistrationPageBinding(),
        ),
        GetPage(
          name: AddMealPage.pageName,
          page: () => const AddMealPage(),
          binding: AddMealPageBinding(),
        ),
        GetPage(
          name: AddActivityPage.pageName,
          page: () => const AddActivityPage(),
          binding: AddActivityPageBinding(),
        ),
        GetPage(
          name: ProfilePage.pageName,
          page: () => const ProfilePage(),
          binding: AddActivityPageBinding(),
        ),
      ],
      initialRoute: SplashPage.pageName,
    );
  }
}
