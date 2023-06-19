import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/activity.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ExpandableActivity extends StatelessWidget {
  final Activity activity;
  final Function() onTap;
  final Icon icon;
  const ExpandableActivity({
    super.key,
    required this.activity,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final weight = Get.find<ProfileController>().profile.value!.weight;

    return Container(
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: AppColors.primaryGradient,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'минута',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    "${(activity.caloryPerHour / 60 * weight).round()} ккал",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: AppColors.black,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              InkWell(
                onTap: onTap,
                child: icon,
              )
            ],
          ),
        ));
  }
}
