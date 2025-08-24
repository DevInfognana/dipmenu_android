import 'package:dip_menu/presentation/logic/controller/privacy_policy_controller.dart';
import 'package:get/get.dart';

class PrivacyPolicyBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PrivacyPolicyController());
  }

}