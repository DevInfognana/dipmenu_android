import 'package:dip_menu/presentation/logic/controller/payment_detail_controller.dart';
import 'package:get/get.dart';

class PaymentDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PaymentDetailController());
  }

}