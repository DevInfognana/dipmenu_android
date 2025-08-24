import 'package:dip_menu/presentation/logic/controller/favourite_controller.dart';
import 'package:get/get.dart';

import '../controller/connection_manager_controller.dart';
import '../controller/home_controller.dart';
import '../controller/main_controller.dart';
import '../controller/profile_controller.dart';
import '../controller/rewards_controller.dart';



class MainBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ConnectionManagerController());
    Get.lazyPut(()=>MainController(),fenix: true);
    Get.lazyPut(()=>FavouriteController(),fenix: true);
    Get.lazyPut(()=>ProfileController(),fenix: true);
    // Get.lazyPut(()=>DipMenuSearchController(),fenix: true);
    Get.lazyPut(()=>RewardsController(),fenix: true);

    Get.lazyPut(()=>HomeController(),fenix: true);
    // Get.put(HomeController());
  }

}