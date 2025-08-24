import 'package:get/get.dart';

import '../controller/product_preview_controller.dart';

class ProductPreviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductPreviewController());
  }

}


class ProductOperationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ProductPreviewController());
  }

}