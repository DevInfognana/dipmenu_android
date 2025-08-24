import 'package:get/get.dart';

import '../controller/gift_card_controller.dart';

class GiftCardBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(GiftCardController());
  }

}