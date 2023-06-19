import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/controllers/favorite_controller.dart';
import 'package:flutter_calory_calculator/controllers/products_controller.dart';
import 'package:flutter_calory_calculator/controllers/reports_controller.dart';
import 'package:flutter_calory_calculator/controllers/user_products_controller.dart';
import 'package:flutter_calory_calculator/entity/report_entity.dart';
import 'package:flutter_calory_calculator/models/favorite.dart';
import 'package:flutter_calory_calculator/models/meal.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:flutter_calory_calculator/widgets/common/create_product_dialog.dart';
import 'package:flutter_calory_calculator/widgets/common/input_dialog.dart';
import 'package:get/get.dart';

class AddMealPageController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final grammInput = Rx("0");
  final _searchValue = Rx<String?>(null);
  final selectedCategory = Rx<String>("Продукты");

  final UserProductsController _userProductsController;
  final ProductsController _productsController;
  final ReportsController _reportsController;
  final FavoriteController _favoriteController;
  AddMealPageController()
      : _productsController = Get.find<ProductsController>(),
        _reportsController = Get.find<ReportsController>(),
        _favoriteController = Get.find<FavoriteController>(),
        _userProductsController = Get.find<UserProductsController>();

  @override
  void onInit() async {
    await _favoriteController.fetchFavorite();
    searchController.addListener(() {
      _searchValue.value = searchController.text;
    });
    debounce(
      _searchValue,
      (value) {
        if (value != null && value.isNotEmpty) {
          _productsController.searchProducts(value);
        }
      },
      time: const Duration(seconds: 1),
    );
    scrollController.addListener(() {
      if (scrollController.position.extentAfter < 500 && !isLoadingMore.value) {
        _productsController.loadMore();
      }
    });
    super.onInit();
  }

  selectCategory(String category) {
    selectedCategory.value = category;
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  addProduct(Product product) async {
    final MealType mealType = Get.arguments;

    await Get.dialog(
      InputDialog(
        onSave: () async {
          _reportsController.addProduct(
            mealType,
            int.parse(grammInput.value),
            product.id,
          );
          Get.back();
          Get.snackbar("Продукт был успешно добавлен", "");
        },
        onDecline: () => Get.back(),
        titleText: "Введите вес (граммы)",
        onChanged: (text) => grammInput.value = text!,
        placeholderText: grammInput.value.toString(),
      ),
    );
  }

  createProduct() async {
    await Get.dialog(
      CreateProductDialog(
        onSave: (product) async {
          await _userProductsController.createProduct(product);
          Get.back();
          Get.snackbar("Продукт был успешно создан", "");
        },
        onDecline: Get.back,
      ),
    );
  }

  toggleFavoriteProduct(Product product) {
    _favoriteController.toggleFavoriteProduct(product);
  }

  RxBool get isLoadingMore => _productsController.isLoadingMore;
  RxBool get isProductsLoading => _productsController.isLoading;
  RxBool get isFavoriteLoading => _favoriteController.isLoading;
  RxBool get isUserProductsLoading => _userProductsController.isLoading;
  RxList<Product> get products => _searchValue.value != null && _searchValue.value!.isNotEmpty
      ? _productsController.searchedProducts
      : _productsController.products;
  Rx<ReportEntity?> get report => _reportsController.report;
  RxList<Favorite> get favoriteProducts => _favoriteController.favoriteProducts;
  RxList<Product> get userProducts => _userProductsController.userProducts;
}
