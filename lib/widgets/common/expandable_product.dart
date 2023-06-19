import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/favorite_controller.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';

class ExpandableProduct extends StatelessWidget {
  final Product product;
  final Function() onTap;
  final Function() onFavorite;
  final int gramm;
  const ExpandableProduct({
    super.key,
    required this.product,
    required this.onTap,
    this.gramm = 100,
    required this.onFavorite,
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
      child: ExpandablePanel(
        theme: const ExpandableThemeData(hasIcon: false),
        header: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$grammг',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "${product.calory} ккал",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 20),
              Obx(() {
                final favorites = Get.find<FavoriteController>().favoriteProducts;
                final isFavorite = favorites.indexWhere((favorite) => favorite.product.id == product.id) != -1;
                return InkWell(
                  onTap: onFavorite,
                  child: isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.pinkAccent,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.pinkAccent,
                        ),
                );
              }),
              const SizedBox(width: 20),
              InkWell(
                onTap: onTap,
                child: const Icon(Icons.add),
              )
            ],
          ),
        ),
        collapsed: const SizedBox(),
        expanded: Column(
          children: [
            Divider(
              color: AppColors.grey,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${product.proteins} г",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Белки",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${product.fats} г",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Жиры",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${product.carbohydrates} г",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Углеводы",
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
