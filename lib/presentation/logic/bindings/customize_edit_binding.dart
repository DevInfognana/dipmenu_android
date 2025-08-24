import 'package:get/get.dart';

import '../controller/customize_edit_controller.dart';

class CustomizeEditBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(CustomizeEditController());
  }

}