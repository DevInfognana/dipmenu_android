import 'package:get/get.dart';

import '../controller/rewards_product_view_controller.dart';
class RewardsProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RewardsProductController());
  }

}