import 'package:get/get.dart';

import '../controller/gift_card_payment_controller.dart';

class GiftCardPaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(GiftCardPaymentController());
  }

}