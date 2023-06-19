import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/entity/stats_entity.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ExpandableItem extends StatelessWidget {
  final StatsEntity? stats;
  final String header;
  final List<Meal>? meals;
  final Function(int mealId) onMealRemove;
  final Function() onAdd;

  const ExpandableItem({
    super.key,
    required this.stats,
    required this.header,
    required this.meals,
    required this.onAdd,
    required this.onMealRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: GradientBoxBorder(
          gradient: AppColors.primaryGradient,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: onAdd,
                  child: const Icon(Icons.add),
                )
              ],
            ),
          ),
          if (meals != null)
            if (meals!.isNotEmpty && stats != null)
              ...{
                Divider(
                  color: AppColors.grey,
                  thickness: 1.5,
                ),
                ExpandablePanel(
                  theme: ExpandableThemeData(
                    iconColor: AppColors.black,
                    iconPadding: const EdgeInsets.only(left: 5, right: 15, top: 15),
                  ),
                  header: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${stats!.calorieIntake.toInt()} ккал",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Б-${stats!.proteins.toInt()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          "Ж-${stats!.fats.toInt()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          "У-${stats!.carbohydrates.toInt()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  collapsed: const SizedBox(),
                  expanded: Column(
                    children: [
                      ...meals!.map(
                        (meal) => Column(
                          children: [
                            Divider(
                              color: AppColors.grey,
                              thickness: 1.5,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              child: Row(
                                children: [
                                  Text(meal.product.name),
                                  const Spacer(),
                                  Text("${meal.calory.toInt()} ккал"),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () => onMealRemove(meal.id),
                                    child: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              }.toList()
        ],
      ),
    );
  }
}
