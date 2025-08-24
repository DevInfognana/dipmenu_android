import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/favourite_model.dart';
import '../../../domain/reporties/favourite_api.dart';

class FavouriteController extends GetxController {
   StatusRequest? statusRequestBanner;
  // late StatusRequest statusRequestCategory;
  var favouriteProductList = <FavouriteDataValue>[].obs;

  @override
  void onInit() async {
    super.onInit();
    if (SharedPrefs.instance.getString('token') != null) {
      viewFavourites();
      update();
    }
  }


  Future<void> refreshLocalGallery() async {
    await Future.delayed(const Duration(seconds: 1));
    imageCache.clear();
    favouriteProductList.clear();
    viewFavourites();
  }


  viewFavourites() async {
    statusRequestBanner = StatusRequest.loading;
    var response = await FavouiteServices.viewFavouirteProductRequest();
    statusRequestBanner = handlingData(response);
    if (StatusRequest.success == statusRequestBanner) {
      favouriteProductList.clear();
      final dataList = (response['data'] as List)
          .map((e) => FavouriteDataValue.fromJson(e))
          .toList();
      favouriteProductList.addAll(dataList);

    } else {
      statusRequestBanner = StatusRequest.failure;
    }
    update();
  }
}
