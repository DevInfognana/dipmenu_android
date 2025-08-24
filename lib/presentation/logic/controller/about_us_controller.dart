import 'package:dip_menu/data/model/about_us_model.dart';
import 'package:dip_menu/domain/reporties/about_us_api.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';

class AboutUsController extends GetxController with StateMixin {
  var aboutUsList = <Data>[];
  late StatusRequest statusRequestBanner;
  late StatusRequest statusRequestCategory;


  @override
  void onInit() async {
    super.onInit();
    viewAboutUs();
  }

  void viewAboutUs() async {
    statusRequestBanner = StatusRequest.loading;
    var response = await AboutUsServices.aboutUsRequest();

    statusRequestBanner = handlingData(response);
    if (StatusRequest.success == statusRequestBanner) {
      aboutUsList.clear();
      //print('response:------>${response['data'].runtimeType}');
      final dataList =
          (response['data'] as List).map((e) => Data.fromJson(e)).toList();
      aboutUsList.addAll(dataList);
     //  aboutUsList.forEach((element) {
     //    // String htmltag = '${element.content}';
     //    // String htmltagcontent = Bidi.stripHtmlIfNeeded(htmltag);
     // });
      change(aboutUsList);
    } else {
      statusRequestBanner = StatusRequest.failure;
    }
    update();
  }
}
