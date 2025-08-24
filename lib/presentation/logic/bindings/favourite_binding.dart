import 'package:dip_menu/presentation/logic/controller/favourite_controller.dart';
import 'package:get/get.dart';




class FavouriteBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(FavouriteController());
  }

}