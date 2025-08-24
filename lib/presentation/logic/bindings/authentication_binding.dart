import 'package:get/get.dart';

import '../controller/authentication_controller.dart';


class AuthBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
  }

}