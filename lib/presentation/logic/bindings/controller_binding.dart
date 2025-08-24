import 'package:dip_menu/presentation/logic/controller/connection_manager_controller.dart';
import 'package:dip_menu/presentation/logic/controller/splash_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
            () => ConnectionManagerController());

    Get.lazyPut<SplashScreenController>(
            () => SplashScreenController());

  }
}