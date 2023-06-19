import 'package:flutter_calory_calculator/api/products_api.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:get/get.dart';

class UserProductsController extends GetxController {
  final userProducts = RxList<Product>();
  final isLoading = RxBool(false);

  final ProductsApi _api;
  final ProfileController _profileController;
  UserProductsController()
      : _api = Get.find(),
        _profileController = Get.find();

  fetchUserProducts() async {
    isLoading.value = true;

    final userId = _profileController.selectedProfile.value!.id!;
    userProducts.value = await _api.getUserProducts(userId);

    isLoading.value = false;
  }

  createProduct(Product product) async {
    isLoading.value = true;

    final userId = _profileController.selectedProfile.value!.id!;
    final userProduct = await _api.createProduct(product.copyWith(userId: userId));
    userProducts.add(userProduct);

    isLoading.value = false;
  }

  @override
  void onReady() {
    fetchUserProducts();
    super.onReady();
  }
}
