import 'package:get/get.dart';

import '../controller/dim_menu_search_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(DipMenuSearchController());
  }

}