import 'package:dio/dio.dart';
import 'package:dip_menu/data/model/recent_order_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class RecentOrderController extends GetxController with StateMixin {
  RecentOrderData? recentOrderData;

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    try {
      await Dio()
          .post(BaseAPI.recentOrder,
              options: Options(headers: {
                'x-access-token': SharedPrefs.instance.getString('token')
              }))
          .then((response) {
        if (response.statusCode == 200) {
          try {
            recentOrderData = RecentOrderData.fromJson(response.data);
          } catch (e) {
            // print('----->$e');
          }
          if (recentOrderData!.data!.isEmpty) {
            change(null, status: RxStatus.empty());
          } else {
            change(recentOrderData, status: RxStatus.success());
          }
        } else {
          change(null, status: RxStatus.error(response.statusMessage));
        }
      });
    } catch (e) {
      change(null, status: RxStatus.error('Something went to wrong'));
    }
  }

  timezoneValues(String dataTime) {
    var istanbulTimeZone =
        tz.getLocation(SharedPrefs.instance.getString('timeZone')!);
    DateTime tempDate = DateTime.parse(dataTime);

    var now = tz.TZDateTime.from(tempDate, istanbulTimeZone);
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    String string = dateFormat.format(now);
    // print(string);

    // shopOpenTimevalue = DateFormat("yyyy-MM-dd HH:mm").parse("$now");
    // String formatCstTime = DateFormat('yyyy-MM-dd').format(shopOpenTimevalue);
    // DateTime shopOpenTime = DateFormat("yyyy-MM-dd")
    //     .parse("$formatCstTime $dataTime");
    // print(dataTime);

    // print(shopOpenTime);
    return string;
  }
}
