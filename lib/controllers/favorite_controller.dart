import 'package:flutter_calory_calculator/api/favorite_api.dart';
import 'package:flutter_calory_calculator/controllers/profile_controller.dart';
import 'package:flutter_calory_calculator/models/favorite.dart';
import 'package:flutter_calory_calculator/models/product.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final isLoading = false.obs;
  final favoriteProducts = <Favorite>[].obs;

  final ProfileController _profileController;
  final FavoriteApi _api;
  FavoriteController()
      : _profileController = Get.find<ProfileController>(),
        _api = Get.find<FavoriteApi>();

  fetchFavorite() async {
    isLoading.value = true;

    final userId = _profileController.selectedProfile.value!.id;
    favoriteProducts.value = await _api.getFavoriteProductsByUserId(userId!);

    isLoading.value = false;
  }

  toggleFavoriteProduct(Product product) async {
    final userId = _profileController.selectedProfile.value!.id!;

    final favoriteProductIndex = favoriteProducts.indexWhere((favorite) => favorite.product.id == product.id);

    if (favoriteProductIndex != -1) {
      favoriteProducts.removeAt(favoriteProductIndex);
    } else {
      favoriteProducts.add(Favorite(id: 0, userId: userId, product: product));
    }
    favoriteProducts.refresh();
    _api.toggleFavoriteProduct(userId, product.id);
  }
}
