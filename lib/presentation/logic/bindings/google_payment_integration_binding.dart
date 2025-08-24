
import 'package:get/get.dart';

import '../controller/google_payment_integration_controller.dart';

class GooglePaymentIntegrationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(GooglePaymentIntegrationController());
  }

}