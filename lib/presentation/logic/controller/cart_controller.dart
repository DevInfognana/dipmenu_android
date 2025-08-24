import 'dart:async';
// import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dip_menu/data/model/cartlist_model.dart';
import 'package:dip_menu/domain/reporties/pos_message_api.dart';
import 'package:dip_menu/extra/common_widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../data/model/sub_category/pos_message_modal.dart';
import '../../../data/model/tax_value_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';

class CartController extends GetxController with StateMixin {
  CartListData? user;
  TaxValueData? taxValueData;
  RxDouble totalValue = 0.0.obs;
  RxDouble actualTotalValue = 0.0.obs;
  RxDouble onineOrderSavingValue = 0.0.obs;
  RxDouble rewardPointValue = 0.0.obs;
  RxDouble taxValue = 0.0.obs;
  RxDouble totalAndTaxValue = 0.0.obs;
  StatusRequest? statusRequestCart;
  var cartProductList = <CartListDataValues>[].obs;
  bool posValues = false;
  String posMessageValues = '';
  RxBool isRewardProducts = false.obs;
  DateTime shopOpenTimevalue = DateTime.now();
  final tipController = SuperTooltipController();
  final tipController1 = SuperTooltipController();


  @override
  void onInit() {
    super.onInit();
    // debugPrint('BaseAPI.headers-------->${BaseAPI.headers}');
    // print(SharedPrefs.instance.getString('tempToken'));
    toGetCartList(data: {
      "payload": {"temp_token": SharedPrefs.instance.getString('tempToken')}
    });
    user?.data!.clear();
    statusRequestCart = StatusRequest.loading;
  }


  Future<void> refreshLocalGallery() async {
    await Future.delayed(const Duration(seconds: 1));
    imageCache.clear();
    user?.data!.clear();
    toGetCartList(data: {
      "payload": {"temp_token": SharedPrefs.instance.getString('tempToken')}
    });
  }

  toGetCartList({required data}) async {
    // print(data);
    // print(SharedPrefs.instance.getString('token'));
    change(null, status: RxStatus.loading());
    await Dio()
        .post(BaseAPI.cartListApi,
            options: Options(headers: {
              'x-access-token': SharedPrefs.instance.getString('token') ?? ''
            }),
            data: data)
        .then((response) {
      // log(response.toString());
          if (response.statusCode == 200) {
        user?.data!.clear();
        // print(response.data);
        user = CartListData.fromJson(response.data);
        user?.data!.sort((a, b) => b.reward!.compareTo(a.reward!));
        // user?.data!.forEach((element) {
        //   if(element.reward!=0){
        //     inRewardProducts=true.obs;
        //   }else{
        //
        //   }
        // });

        user?.data!.any((element) => element.reward != 0
            ? isRewardProducts.value = true
            : isRewardProducts.value = false);

        if (user!.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          taxEncyptGetApi();
        }
      } else {
        change(null, status: RxStatus.error(response.statusMessage));
      }
    });
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

  cartValuesIncrease({int? productId, int? quantity}) async {
    change(null, status: RxStatus.loading());
    final data = {
      "payload": {"id": productId, "quantity": quantity}
    };
    // print(data);
    await Dio().post(BaseAPI.updateQuanity, data: data).then((response) {
      // print(response);
      if (response.statusCode == 200) {
        toGetCartList(data: {
          "payload": {"temp_token": SharedPrefs.instance.getString('tempToken')}
        });
        // change(null, status: RxStatus.success());
      } else {
        Get.snackbar('', 'Something went wrong');
        change(null, status: RxStatus.error('Something went wrong'));
      }
    });
  }

  taxValueApi({required encryptedValues}) async {
    statusRequestCart = StatusRequest.loading;
    await Dio().post(
      BaseAPI.cartListTaxDecryptApi,
      data: {"payload": encryptedValues},
    ).then((response) {
      if (response.statusCode == 200) {
        statusRequestCart = StatusRequest.success;
        taxValueData = TaxValueData.fromJson(response.data);
        // print(response.data);
        taxValueData?.datas!.response!.forEach((element) {
          // print(element);
          SharedPrefs.instance.setString("timeZone", '${element.timezone}');
          SharedPrefs.instance
              .setString("shopLatitude", '${element.shopLatitude}');
          SharedPrefs.instance
              .setString("shopLongitude", '${element.shopLongitude}');
          SharedPrefs.instance.setString("shopRadius", '${element.shopRadius}');
          change(SharedPrefs.instance
              .setString("shopRadius", '${element.shopRadius}'));
          change(SharedPrefs.instance
              .setString("shopLongitude", '${element.shopLongitude}'));
          change(SharedPrefs.instance
              .setString("shopLatitude", '${element.shopLatitude}'));
          SharedPrefs.instance.setString("discount", '${element.discount}');
          var istanbulTimeZone = tz.getLocation(element.timezone!);
          var now = tz.TZDateTime.now(istanbulTimeZone);
          shopOpenTimevalue = DateFormat("yyyy-MM-dd HH:mm").parse("$now");
          SharedPrefs.instance.setString("disclaimer", '${element.disclaimer}');

          // print(SharedPrefs.instance.getString('shopLatitude'));
          // print(SharedPrefs.instance.getString('shopLongitude'));
        });
        SharedPrefs.instance
            .setString("salesTax", '${taxValueData?.datas!.response![0].tax}');
        posMessage();
        calculationProductValues();
      } else {
        change(null, status: RxStatus.error(response.statusMessage));
      }
    });
  }

  void posMessage() async {
    // statusRequestBanner = StatusRequest.loading;
    var response = await PosMessageServices.posMessageRequest();
    List<PosMessagevalueData> posMessageList = [];
    posMessageList.clear();
    final dataList = (response['data'] as List)
        .map((e) => PosMessagevalueData.fromJson(e))
        .toList();
    posMessageList.addAll(dataList);
    posMessageList.forEach((element) async {
      // print(element);
      String? startingTime = element.startTime;
      String? endingTime = element.endTime;
      posMessageValues = element.message!;
      change(posMessageValues);
      SharedPrefs.instance.setString("startingTime", '$startingTime');
      SharedPrefs.instance.setString("endingTime", '$endingTime');

      String formattedCstTime = DateFormat('EEEE').format(shopOpenTimevalue);
      String formatCstTime = DateFormat('yyyy-MM-dd').format(shopOpenTimevalue);
      DateTime shopOpenTime = DateFormat("yyyy-MM-dd hh:mm a")
          .parse("$formatCstTime ${element.startTime}");
      DateTime shopCloseTime = DateFormat("yyyy-MM-dd hh:mm a")
          .parse("$formatCstTime ${element.endTime}");
      // print(shopOpenTime);
      // print(shopCloseTime);
      // print(shopOpenTimevalue);
      // print(shopOpenTimevalue.isBefore(shopCloseTime));
      // print(shopOpenTimevalue.isAfter(shopOpenTime));
      if (element.schedule == 1) {
        if (element.schDay == formattedCstTime) {
          if (shopOpenTimevalue.isAfter(shopOpenTime) &&
              shopOpenTimevalue.isBefore(shopCloseTime)) {
            change(posValues = true);
          } else {
            change(posValues = false);
          }
        }
      }
    });
  }

  void cartCountUpdate(
      {required int selectedIndex,
      required bool isIncreasing,
      required int id}) {
    if (user!.data![selectedIndex].quantity != 0 && !isIncreasing) {
      var tempCount = user!.data![selectedIndex].quantity!;
      tempCount--;
      user!.data![selectedIndex].quantity = tempCount;
      cartValuesIncrease(productId: id, quantity: -1);
    } else {
      var tempCount = user!.data![selectedIndex].quantity!;
      tempCount++;
      user!.data![selectedIndex].quantity = tempCount;
      cartValuesIncrease(productId: id, quantity: 1);
    }
    change(user!.data![selectedIndex].quantity);

    calculationProductValues();
  }

  removeCart({required int selectedIndex}) async {
    change(null, status: RxStatus.loading());
    await Dio().post(BaseAPI.removeCartApi,
        options: Options(headers: {
          'x-access-token': SharedPrefs.instance.getString('token')
        }),
        data: {'id': user!.data![selectedIndex].id}).then((response) {
      if (response.statusCode == 200) {
        user!.data!.removeAt(selectedIndex);
        change(user!.data!);
        toGetCartList(data: {
          "payload": {"temp_token": SharedPrefs.instance.getString('tempToken')}
        });
        calculationProductValues();
        if(user!.data!.isEmpty){
          Get.offAllNamed(Routes.mainScreen, arguments: 0);
        }
      } else {
        Get.snackbar('Cart Remove', 'Something went wrong with cart removing');
      }
      change(null, status: RxStatus.success());
    });
  }

  calculationProductValues() {
    totalValue.value = 0;
    rewardPointValue.value = 0;
    taxValue.value = 0;
    actualTotalValue.value=0;
    // print(SharedPrefs.instance.getString('salesTax'));
    //print('taxCalc:---->${taxValueData?.datas!.response![0].tax}');

    for (var element in user!.data!) {
      if (element.reward == 0) {
        totalValue.value += (element.totalCost);

        // actualTotalValue.value += element.quantity!.toDouble()*(double.parse(element.actualPrice!));
      } else {
        rewardPointValue.value += (element.totalCost);
      }
    }
    change(totalValue.value);
    change(actualTotalValue.value);
    change(rewardPointValue.value);
    change(taxValue.value = totalValue.value *
        int.parse(taxValueData!.datas!.response![0].tax!) /
        100);
    change(totalAndTaxValue.value = totalValue.value + taxValue.value,
        status: RxStatus.success());
    change(onineOrderSavingValue.value= totalAndTaxValue.value*(int.parse(taxValueData!.datas!.response![0].discount!)/100));
    if(onineOrderSavingValue.value.isNegative){
      change(onineOrderSavingValue.value=0.0);
    }
  }

  closeTooltip(){
     Future.delayed( const Duration(seconds: 2), () {
      if (tipController.isVisible) {
        change( tipController.hideTooltip());
      }
      if (tipController1.isVisible) {
        change( tipController1.hideTooltip());
      }
    });


  }

  void cartDeleteAlertDialog({required int selectedIndex}) {
    ShowDialogBox.showAlertDialog(
      content: 'Are you sure you want to remove the product ?',
      context: Get.context,
      textBackButton: "No",
      textOkButton: "Yes",
      title: "Remove Product",
      onButtonTapped: () async {
        Get.back();
        await removeCart(selectedIndex: selectedIndex);
      },
    );
  }
}
