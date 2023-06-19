import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/models/report_activity.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ExpandableActivityItem extends StatelessWidget {
  final String header;
  final List<ReportActivity?>? activities;
  final Function(int activityId) onReportRemove;
  final Function() onAdd;
  final int minutes;
  final int caloryBurned;
  final double weight;
  const ExpandableActivityItem({
    super.key,
    required this.header,
    this.activities,
    required this.onAdd,
    required this.onReportRemove,
    required this.minutes,
    required this.caloryBurned,
    required this.weight,
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
          if (activities != null)
            if (activities!.isNotEmpty && minutes != 0)
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
                          "Сожжено",
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "$minutes минут",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: AppColors.black,
                          ),
                        ),
                        Text(
                          "$caloryBurned ккал",
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
                      ...activities!.map(
                        (reportActivity) => Column(
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
                                  Expanded(child: Text(reportActivity!.activity.name)),
                                  Expanded(child: Text("${reportActivity.minutes} минут")),
                                  Expanded(
                                    child: Text(
                                        "${(reportActivity.activity.caloryPerHour / 60 * reportActivity.minutes * weight).round()} ккал"),
                                  ),
                                  InkWell(
                                    onTap: () => onReportRemove(reportActivity.id),
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
