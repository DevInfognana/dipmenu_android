import 'package:dip_menu/presentation/logic/controller/recent_order_detail_controller.dart';
import 'package:get/get.dart';

class RecentOrderDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RecentOrderDetailController());
  }

}