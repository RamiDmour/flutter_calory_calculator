import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/add_meal_page_controller.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:flutter_calory_calculator/theme/colors.dart';
import 'package:flutter_calory_calculator/widgets/common/expandable_product.dart';
import 'package:flutter_calory_calculator/widgets/common/input.dart';
import 'package:flutter_calory_calculator/widgets/common/selector.dart';
import 'package:get/get.dart';

class AddMealPage extends GetView<AddMealPageController> {
  static const pageName = "/add_meal_page";
  const AddMealPage({super.key});

  Widget _buildFavoriteProducts() {
    if (controller.favoriteProducts.isEmpty) {
      return const Center(
        child: Text("Продукт не найден"),
      );
    }

    return ListView.builder(
      itemCount: controller.favoriteProducts.length,
      itemBuilder: (_, i) {
        final product = controller.favoriteProducts[i].product;
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: ExpandableProduct(
            product: product,
            onTap: () => controller.addProduct(product),
            onFavorite: () => controller.toggleFavoriteProduct(product),
          ),
        );
      },
    );
  }

  Widget _buildUserProducts() {
    if (controller.userProducts.isEmpty) {
      return const Center(
        child: Text("Список пуст"),
      );
    }

    return ListView.builder(
      itemCount: controller.userProducts.length,
      itemBuilder: (_, i) {
        final product = controller.userProducts[i];

        return ExpandableProduct(
          product: product,
          onTap: () => controller.addProduct(product),
          onFavorite: () => controller.toggleFavoriteProduct(product),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final MealType mealType = Get.arguments;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.createProduct(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
          ),
          child: const Icon(Icons.add),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 35,
            horizontal: 30,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    mealType.toLocaleString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  const Spacer()
                ],
              ),
              const SizedBox(height: 40),
              Obx(
                () => Visibility(
                  visible: controller.selectedCategory.value == "Продукты",
                  child: SizedBox(
                    height: 40,
                    child: Input(
                      controller: controller.searchController,
                      placeholderText: "Найти продукт",
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 35,
                child: Selector(
                  values: const ["Продукты", "Избранное", "Мои продукты"],
                  onChange: (category) => controller.selectCategory(category),
                  initValue: controller.selectedCategory.value,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isProductsLoading.value || controller.isFavoriteLoading.value) {
                      return Center(
                        child: CircularProgressIndicator(color: AppColors.primary),
                      );
                    }

                    if (controller.selectedCategory.value == 'Мои продукты') {
                      return _buildUserProducts();
                    }

                    if (controller.selectedCategory.value == 'Избранное') {
                      return _buildFavoriteProducts();
                    }

                    if (controller.products.isEmpty) {
                      return const Center(
                        child: Text("Продукт не найден"),
                      );
                    }

                    return ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.products.length,
                      itemBuilder: (_, i) {
                        final product = controller.products[i];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: ExpandableProduct(
                            onFavorite: () => controller.toggleFavoriteProduct(product),
                            product: product,
                            onTap: () => controller.addProduct(product),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
