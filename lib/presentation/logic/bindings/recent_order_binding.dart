import 'package:dip_menu/presentation/logic/controller/recent_order_controller.dart';
import 'package:get/get.dart';

class RecentOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RecentOrderController());
  }

}