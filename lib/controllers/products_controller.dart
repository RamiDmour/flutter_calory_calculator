import 'package:flutter_calory_calculator/api/products_api.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final products = <Product>[].obs;
  final searchedProducts = <Product>[].obs;
  final isLoading = false.obs;
  final isLoadingMore = false.obs;
  final error = Rx<String?>(null);
  final offset = 0.obs;

  final ProductsApi _api;
  final ProfileController _profileController;
  ProductsController()
      : _api = Get.find<ProductsApi>(),
        _profileController = Get.find<ProfileController>();

  @override
  void onReady() {
    initFetch();
    super.onReady();
  }

  initFetch() async {
    isLoading.value = true;
    await loadMore();
    isLoading.value = false;
  }

  loadMore() async {
    try {
      isLoadingMore.value = true;
      final userId = _profileController.selectedProfile.value!.id!;
      products.addAll(await _api.getProducts(
        offset: offset.value,
        userId: userId,
      ));
      offset.value += 20;
    } catch (e) {
      printError(info: e.toString());
      error.value = e.toString();
    }
    isLoadingMore.value = false;
  }

  searchProducts(String name) async {
    try {
      isLoading.value = true;
      final userId = _profileController.selectedProfile.value!.id!;
      searchedProducts.clear();
      searchedProducts.addAll(await _api.searchProducts(
        name,
        userId,
      ));
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
