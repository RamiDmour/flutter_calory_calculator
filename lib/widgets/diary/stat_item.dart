import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:gradient_borders/gradient_borders.dart';

class StatItem extends StatelessWidget {
  final String name;
  final String value;
  const StatItem({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: GradientBoxBorder(gradient: AppColors.primaryGradient),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 7),
          Text(
            value,
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            name,
            style: TextStyle(color: AppColors.grey),
          ),
          const SizedBox(height: 7),
        ],
      ),
    );
  }
}
