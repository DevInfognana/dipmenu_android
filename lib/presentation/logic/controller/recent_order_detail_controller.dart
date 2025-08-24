import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dip_menu/data/model/recent_order_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:get/get.dart';
import '../../../data/model/tax_value_model.dart';
import '../../../domain/reporties/recent_order.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../pages/index.dart';

class RecentOrderDetailController extends GetxController with StateMixin {
  RecentOrderData? recentOrderData;
  StatusRequest? statusRequestCategory;
  DateTime shopOpenTimevalue = DateTime.now();
  var istanbulTimeZone;



  @override
  void onInit() async {
    super.onInit();
    try {
      await Dio().post(BaseAPI.recentOrder,
          options: Options(headers: {
            'x-access-token': SharedPrefs.instance.getString('token')
          }),
          data: {
            "postData": {"id": Get.arguments ?? 0}
          }).then((response) {
        if (response.statusCode == 200) {
          // log('order detail response:--->$response');
          recentOrderData = RecentOrderData.fromJson(response.data);
          // debugPrint('api res:--->$recentOrderData');
          if (recentOrderData!.data!.isEmpty) {
            change(null, status: RxStatus.empty());
          } else {
            for (var element in recentOrderData!.data!) {
              if (element.customer!.driveThruDetails != null) {
                // print(element.customer!.driveThruDetails);
                SharedPrefs.instance.setString(
                    'drive_thru', element.customer!.driveThruDetails!);
                Map<String, dynamic> decoded =
                    json.decode(element.customer!.driveThruDetails!);
                SharedPrefs.instance
                    .setString('vehicleModel', decoded['vehicleModel']);
                SharedPrefs.instance
                    .setString('vehicleColor', decoded['vehicleColor']);
                SharedPrefs.instance
                    .setString('vehicleNo', decoded['vehicleNo']);
              }
            }
            change(recentOrderData, status: RxStatus.success());
          }
        } else {
          change(null, status: RxStatus.error(response.statusMessage));
        }
      });
    } catch (e) {
      change(null, status: RxStatus.error('Something went to wrong'));
    }
    taxEncyptGetApi();
  }



  recreateOrder(String? orderId) async {
    change(null, status: RxStatus.loading());
    var response = await RecentOrder.recentOrderApi(values: orderId!);

    statusRequestCategory = handlingData(response);

    if (StatusRequest.success == statusRequestCategory) {
      Get.offAndToNamed(Routes.cartScreen);
      change("", status: RxStatus.success());
    } else {
      change(recentOrderData, status: RxStatus.error('something went wrong'));
      showSnackBar("Oops! Something went wrong.");
      Get.back();
    }
  }

  taxEncyptGetApi() async {
    change(null, status: RxStatus.loading());
    await Dio().get(BaseAPI.cartListTaxGetApi).then((response) {
      if (response.statusCode == 200) {
        if (response.data['datas'].isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          taxValueApi(encryptedValues: response.data['datas']);
        }
      } else {
        Get.snackbar('', 'Something went wrong');
        change(null, status: RxStatus.error('Something went wrong'));
      }
    });
  }

  taxValueApi({required encryptedValues}) async {
    await Dio().post(
      BaseAPI.cartListTaxDecryptApi,
      data: {"payload": encryptedValues},
    ).then((response) {
      if (response.statusCode == 200) {
        var taxValueData = TaxValueData.fromJson(response.data);
        for (var element in taxValueData.datas!.response!) {
          istanbulTimeZone = tz.getLocation(element.timezone!);
          shopOpenTimevalue = tz.TZDateTime.now(istanbulTimeZone);
          change("", status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error(response.statusMessage));
      }
    });
  }



  void reorderAlertDialog({required int selectedIndex}) {
    ShowDialogBox.showAlertDialog(
      content: 'Are you sure you want to Reorder?',
      context: Get.context,
      textBackButton: "No",
      textOkButton: "Yes",
      title: "Reorder Confirmation",
      onButtonTapped: () async {
        Get.back();
        await recreateOrder(selectedIndex.toString());
      },
    );
  }
}

