import 'package:dip_menu/domain/reporties/contact_us_api.dart';
import 'package:get/get.dart';
import '../../../data/model/contact_us_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';


class ContactUsController extends GetxController with StateMixin {
  var contactUsList = <Data>[];
  late StatusRequest statusRequestBanner;
  late StatusRequest statusRequestCategory;

  @override
  void onInit() async {
    super.onInit();
    viewContactUs();
  }

  void viewContactUs() async {
    statusRequestBanner = StatusRequest.loading;
    var response = await ContactUsServices.contactUsRequest();

    statusRequestBanner = handlingData(response);
    if (StatusRequest.success == statusRequestBanner) {
      contactUsList.clear();
      final dataList =
          (response['data'] as List).map((e) => Data.fromJson(e)).toList();
      contactUsList.addAll(dataList);
      change(contactUsList);
    } else {
      statusRequestBanner = StatusRequest.failure;
    }
    update();
  }
}