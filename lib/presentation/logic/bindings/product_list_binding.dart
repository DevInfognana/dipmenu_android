import 'package:get/get.dart';
import '../controller/sub_category_controller.dart';

class ProductListBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SubCategoryController());
  }

}