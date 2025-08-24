

import 'package:get/get.dart';

import '../controller/rewards_customize_edit_controller.dart';
class RewardsCustomizeProductBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RewardsCustomizeEditController());
  }

}