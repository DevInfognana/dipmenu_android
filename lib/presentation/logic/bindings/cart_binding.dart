
import 'package:dip_menu/presentation/logic/controller/cart_controller.dart';
import 'package:get/get.dart';


class CartBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>CartController(), fenix: true);
  }
  void initState(){
    Get.lazyPut(()=>CartController(), fenix: true);
  }

}