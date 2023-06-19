import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/pages/charts_page.dart';
import 'package:flutter_calory_calculator/pages/diary_page.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      onTap: (i) {
        switch (i) {
          case 0:
            Get.toNamed(DiaryPage.pageName);
            break;
          case 1:
            Get.toNamed(ChartsPage.pageName);
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: "Дневник",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.insert_chart_outlined_rounded),
          label: "Отчёты",
        ),
      ],
    );
  }
}
