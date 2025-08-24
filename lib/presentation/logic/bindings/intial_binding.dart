import 'package:get/get.dart';

import '../controller/intial_controller.dart';



class InitialBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashInitalController());
  }

}