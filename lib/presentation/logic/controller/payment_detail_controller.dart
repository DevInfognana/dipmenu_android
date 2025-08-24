import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dip_menu/core/config/app_textstyle.dart';
import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/data/model/cartlist_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'dart:core';

import '../../../data/model/orders_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

import '../../../data/model/pos_time_values.dart';
import '../../../domain/reporties/payment_api.dart';

class PaymentDetailController extends GetxController with StateMixin {
  // DateTime currentDateTime = DateTime.now();
  // StatusRequest? statusRequestCart;
  final dynamic salesTax = SharedPrefs.instance.getString('salesTax');
  RxDouble totalCost = 0.0.obs;
  RxDouble totalCostWithTax = 0.0.obs;
  RxDouble totalAndTaxValue = 0.0.obs;
  // RxDouble discountValue = 0.0.obs;
  // RxDouble totalAndDiscountValue = 0.0.obs;
  RxDouble finalTotalValue = 0.0.obs;
  RxDouble rewardValue = 0.0.obs;
  double walletValue = 0.0;
  double walletValue1 = 0.0;
  List<CartListDataValues> cardList = [];
  RxString orderMode = ''.obs;
  List<DropdownMenuItem<String>> dropdownItems = [];
  List<String> selectedTimevalues = [];

  // int? orderModeNummber;
  String? orderModeNummberValues;
  DateTime currentTIme = DateTime.now();
  final scheduledTimeFormKey = GlobalKey<FormState>();
  int oneTimeShowValues = 0;
  bool checkBoxValue = false;
  bool? paymentConfirmationValues;
  bool? isTotalValueZero = false;
  String deviceType = Platform.isAndroid ? "Android" : "ios";
  @override
  void onInit() {
    super.onInit();
    scheduletime();
    walletValue = double.parse(SharedPrefs.instance.getString('wallet')!);
    walletValue1 = double.parse(SharedPrefs.instance.getString('wallet')!);

    cardList = Get.arguments is List<CartListDataValues> ? Get.arguments : [];
    if (cardList.isNotEmpty) {
      for (var element in cardList) {
        // print('check reward:--> ${element.reward}');
        if (element.reward == 0) {
          totalCost.value += element.totalCost!;
        } else {
          rewardValue.value += element.totalCost!;
        }
      }
      // print('load point:--->');

      change(totalCost);
      change(totalCostWithTax.value =
          totalCost.value * int.parse(salesTax) / 100); //12 / 100);
      change(totalAndTaxValue.value = totalCost.value + totalCostWithTax.value);
// change(discountValue.value); // change(discountValue.value = double.parse(giftCardData!.data!.loadPoints!) ?? 0 );

      change(finalTotalValue.value = totalAndTaxValue.value);
      if (finalTotalValue.value == 0.0) {
        change(isTotalValueZero = true);
      }
    }

    var istanbulTimeZone =
        tz.getLocation(SharedPrefs.instance.getString('timeZone')!);
    var now = tz.TZDateTime.now(istanbulTimeZone);
    currentTIme = DateFormat("yyyy-MM-dd hh:mm").parse("$now");
    var newDate = DateFormat('hh:mm a').format(currentTIme);
    // print('------welcome');
    // print(newDate);

    dropdownTimeCalculation(
        startingTime: newDate,
        endingTime: SharedPrefs.instance.getString('endingTime'));

    WidgetsBinding.instance
        .addPostFrameCallback((_) => showAlertDialog(Get.context!));
  }

  void dropdownTimeCalculation({required startingTime, required endingTime}) {
    dropdownItems = [];
    // DateTime now = DateTime.now();

    DateTime startTime = DateFormat("hh:mm a").parse(startingTime);
    DateTime endTime = DateFormat("hh:mm a").parse(endingTime);

    DateTime startTimeToCheck = DateTime.now().copyWith(
        hour: startTime.hour,
        minute: startTime.minute,
        second: startTime.second,
        microsecond: startTime.microsecond,
        millisecond: startTime.millisecond);
    DateTime endTimeToCheck = DateTime.now().copyWith(
        hour: endTime.hour,
        minute: endTime.minute,
        second: endTime.second,
        microsecond: endTime.microsecond,
        millisecond: endTime.millisecond);
    getTheTime(
        endTimeToCheck: endTimeToCheck, startTimeToCheck: startTimeToCheck);
  }

  getTheTime(
      {required DateTime startTimeToCheck, required DateTime endTimeToCheck}) {
    // DateTime now = DateTime.now();
    if (endTimeToCheck.isAfter(startTimeToCheck)) {
//var tempTime = nearestQuarter(startTimeToCheck);
      var tempTime =
          DateFormat('hh:mm a').format(nearestQuarter(startTimeToCheck));
      dropdownItems
          .add(DropdownMenuItem(value: tempTime, child: Text(tempTime)));
      getTheTime(
          endTimeToCheck: endTimeToCheck,
          startTimeToCheck:
              startTimeToCheck.copyWith(minute: startTimeToCheck.minute + 15));
    } else {
    }
  }

  DateTime nearestQuarter(DateTime val) {
    return DateTime(val.year, val.month, val.day, val.hour,
        [15, 30, 45, 60][(val.minute / 15).floor()]);
  }

  scheduletime() async {
    change(null, status: RxStatus.loading());
    await Dio()
        .get(
      BaseAPI.scheduleTime,
      options: Options(
          headers: {'x-access-token': SharedPrefs.instance.getString('token')}),
    )
        .then((response) {
      if (response.statusCode == 200) {
        if (response.data['order'].isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          // print('welcome');
          final values = PosTimeValues.fromJson(response.data);
          for (var element in values.order!) {
            // print(element.orderModeDetails);
            selectedTimevalues.add(element.orderModeDetails!);
          }
          change(selectedTimevalues);
          change(null, status: RxStatus.success());
        }
      } else {
        Get.snackbar('', 'Something went wrong');
        change(null, status: RxStatus.error('Something went wrong'));
      }
    });
  }

  giftCardApi(double pointsValues) async {
    change(null, status: RxStatus.loading());
    var body = jsonEncode({
      "payload": {
        "transactionid": "0",
        "type": "0",
        "final_amount": "0.00",
        "order_amount": "0.00",
        "sub_total":
            checkBoxValue == true ? totalCost.value.toStringAsFixed(2) : "0.00",
        "tax_percent": checkBoxValue == true
            ? int.parse(SharedPrefs.instance.getString('salesTax')!)
            : 0,
        "tax_amount": checkBoxValue == true
            ? totalCostWithTax.value.toStringAsFixed(2)
            : "0.00",
        "redeem_points": pointsValues != 0.0
            ? pointsValues
                .toString()
                .substring(0, pointsValues.toString().length - 2)
            : '',
        "po_number": 1,
        "payment_method": "CASHLESS",
        "payment_status": "READY",
        "order_status": 4,
        "print_status": 0,
        "status": 1,
        "gift_card": checkBoxValue == true ? 'Wallet' : null,
        "gift_point": checkBoxValue == true
            ? totalAndTaxValue.toDouble().toStringAsFixed(2)
            : null,
        "refund": 0,
        "order_response": "0",
        "order_number": "",
        "schedulePickup": orderModeNummberValues != null ? "1" : '0',
        "schedulePickup_time":
            orderModeNummberValues ?? '',
        "order_mode": '',
        "ordered_from" : "mobile",
        "mobile_type" : deviceType,
        "orderMode_details": ""
      }
    });
    // print("payent_detail_Payload: $body");

    await Dio()
        .post(BaseAPI.newOrder,
            data: body,
            options: Options(headers: {
              'x-access-token': SharedPrefs.instance.getString('token')
            }))
        .then((response) {
      if (response.statusCode == 200) {
        // print(response);
        var user = OrderIDGenereate.fromJson(response.data);
        confirmOrderAlertDialog(Get.context!, user.orderId);
        createPdf(orderId: user.orderId.toString());
        change("", status: RxStatus.success());
      } else {
        faildedOrderAlertDialog(Get.context!);
        change(null, status: RxStatus.error('Something went wrong'));
      }
    });
  }

  Future createPdf({var orderId}) async {
    final uservalues = await PaymentApi().createPdf(orderId);
    if (uservalues != null) {
      // final values = OrderUpdateValues.fromJson(uservalues);
      // if (values.orderStatus == 4) {
      //   change(null, status: RxStatus.success());
      // } else {
      //   // failedOrderAlertDialog(Get.context!);
      //   change(null, status: RxStatus.error('something went wrong'));
      // }
    }
  }

  confirmOrderAlertDialog(BuildContext context, int? orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: TextScaleFactorClamper(
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 0.5.w),
                width: 70.w,
                height: 52.h,
                child: TextScaleFactorClamper(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                        width: 200.w,
                        child: Lottie.asset(ImageAsset.paymentSuccess,
                            fit: BoxFit.contain),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Thanks for Order",
                              style: TextStore.textTheme.headlineMedium!.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 0.9.h),
                      Text(
                        'Your payment has been confirmed.\n You can check the details.',
                        textAlign: TextAlign.center,
                        style: TextStore.textTheme.titleLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 0.9.h),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('Order Id',
                              style: TextStore.textTheme.headlineSmall!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text("  #$orderId",
                              style: TextStore.textTheme.headlineSmall!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 0.9.h),
                      Text("Please make ensure your order",
                          style: TextStore.textTheme.titleLarge!
                              .copyWith(color: Colors.black)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: darkSeafoamGreen1,
                            fixedSize: Size(30.w, 4.h),
                            textStyle: TextStore.textTheme.headlineSmall!
                                .copyWith(color: Colors.white),
                            elevation: 6),
                        onPressed: () {
                          null;
                        },
                        child: Text('Check-in',
                          style: TextStore.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 11.sp, // Use scalable pixels (sp) if available
                            fontWeight: FontWeight.w500,
                          ),),
                      ),
                      // Text("Once your order arrive",
                      //     style: TextStore.textTheme.titleLarge!
                      //         .copyWith(color: Colors.black)),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.offAllNamed(Routes.mainScreen,
                                    arguments: 0);
                                SharedPrefs.instance.setInt('bottomBar', 0);
                                Get.delete<PaymentDetailController>();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2.w),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 10.w)),
                              child: Text('Back to Home',
                                  style: TextStore.textTheme.headlineSmall!
                                      .copyWith(color: Colors.white)
                                  //style: TextStyle(fontSize: 18, color: Colors.white),
                                  )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  faildedOrderAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.w))),
          title: TextScaleFactorClamper(
            child: Center(
                child: Lottie.asset(ImageAsset.paymentFailed,
                    height: 20.h, width: 70.w, fit: BoxFit.cover)),
          ),
          content: TextScaleFactorClamper(
            child: SizedBox(
              width: 70.w,
              height: 20.h,
              child: Column(
                children: [
                  const Center(
                    child: Text("Retry order",
                        style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(height: 1.h),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 14.w)),
                      child: const Text(
                        'Back to Retry',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  SizedBox(height: 0.1.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // alert dialog for after proceed to pay
  showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Platform.isIOS
              ? CupertinoAlertDialog(
                  // title: Text('', style: TextStore.textTheme.displaySmall!
                  //     .copyWith(color: borderColor,fontWeight: FontWeight.bold),
                  //     textAlign: TextAlign.center),
                  content: TextScaleFactorClamper(
                    child: Text(
                        'Do you want to schedule this order at a particular time ?',
                        textAlign: TextAlign.justify,
                        style: TextStore.textTheme.headlineSmall!
                            ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Get.back();
                          scheduledPickUpAlertDialog(Get.context!);
                          change(oneTimeShowValues = 1);
                        },
                        child: Text(
                          "Schedule for later",
                          textAlign: TextAlign.center,
                          style: TextStore.textTheme.headlineSmall!
                              // .copyWith(color: Colors.black),
                        )),
                    TextButton(
                        onPressed: () {
                          Get.back();
                          change(oneTimeShowValues = 1);
                          change(orderModeNummberValues,
                              status: RxStatus.success());
                        },
                        child: Text(NameValues.orderNow,
                            style: TextStore.textTheme.headlineSmall!
                                .copyWith(color: mainColor)))
                  ],
                )
              : AlertDialog(
            backgroundColor: Colors.white,
                  title: Text('Order Type',
                      style: TextStore.textTheme.displaySmall!.copyWith(
                          color: borderColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w)),
                  content: TextScaleFactorClamper(
                    child: Text(
                        'Do you want to schedule this order at a particular time ?',
                        textAlign: TextAlign.justify,
                        style: TextStore.textTheme.headlineSmall!
                            .copyWith(color: Colors.black)),
                  ),
                  actions: [
                    TextScaleFactorClamper(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 0.5.w),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                                scheduledPickUpAlertDialog(Get.context!);
                                change(oneTimeShowValues = 1);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 2.w),
                                // side: BorderSide.none,
                                // fixedSize: Size(
                                //     28.w, getDeviceType == "phone" ? 8.h : 6.h),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(3.w)),
                              ),
                              // child: const Text('Schedule for later')
                              child: Text(NameValues.scheduleLater,
                                  style: TextStore.textTheme.headlineSmall!
                                      .copyWith(color: Colors.white))),
                          SizedBox(width: 0.5.w),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                                change(oneTimeShowValues = 1);
                                change(orderModeNummberValues,
                                    status: RxStatus.success());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 2.w)),
                              child: Text(NameValues.orderNow,
                                  style: TextStore.textTheme.headlineSmall!
                                      .copyWith(color: Colors.white))),
                          SizedBox(width: 0.5.w),
                        ],
                      ),
                    )
                  ],
                ),
        );
      },
    );
  }

  discliamerDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: TextScaleFactorClamper(
            child: Platform.isIOS
                ? CupertinoAlertDialog(
                    title: Text('Confirm Order ',
                        style: TextStore.textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    content: Text(
                      SharedPrefs.instance.getString('disclaimer')!,
                      textAlign: TextAlign.justify,
                      style: TextStore.textTheme.headlineSmall!
                          // .copyWith(color: Colors.black),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: () {
                            Get.back();
                            change(paymentConfirmationValues = false);
                          },
                          child: Text("Back",
                              style: TextStore.textTheme.headlineSmall!
                                 )),
                      TextButton(
                          onPressed: () {
                            Get.back();
                            change(paymentConfirmationValues = true);
                            if (finalTotalValue == 0.0) {
                              walletValue = finalTotalValue.toDouble();
                              giftCardApi(rewardValue.toDouble());
                            } else {
                              double walletValues =
                                  totalAndTaxValue.toDouble() -
                                      finalTotalValue.toDouble();
                              Map value = {
                                'order_sub_total':
                                    totalCost.value.toStringAsFixed(2),
                                'Total':
                                    finalTotalValue.value.toStringAsFixed(2),
                                'tax': totalCostWithTax.toStringAsFixed(2),
                                'taxPrecent': salesTax,
                                'ordermodenumber': orderModeNummberValues,
                                'orderModeValues': orderModeNummberValues,
                                "gift_card":
                                    checkBoxValue == true ? 'Wallet' : null,
                                "gift_point": checkBoxValue == true
                                    ? walletValues.toStringAsFixed(2)
                                    : null,
                                'pointsvalues': rewardValue.round(),
                                'view': 'OrderPage',
                              'mobile_type': deviceType
                              };
                              // print("Running on: ${Platform.isAndroid ? 'Android' : 'iOS'}");
                              // print("Payload_val:$value");
                              print("CupertinoAlert:going to googlePaymentScreen and Payload_val-->:$value");
                              Get.toNamed(Routes.googlePaymentScreen,
                                  arguments: value);

                              // Get.toNamed(Routes.paymentScreen, arguments: value);
                            }
                          },
                          child: Text('Continue',
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: mainColor)))
                    ],
                  )
                : AlertDialog(
              backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.w)),
                    title: Text('Confirm Order ',
                        style: TextStore.textTheme.displaySmall!.copyWith(
                            color: borderColor, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    content: Text(
                      SharedPrefs.instance.getString('disclaimer')!,
                      textAlign: TextAlign.justify,
                      style: TextStore.textTheme.headlineSmall!
                          .copyWith(color: Colors.black),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                                change(paymentConfirmationValues = false);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  side: BorderSide.none,
                                  fixedSize: Size(28.w,
                                      getDeviceType == "phone" ? 8.h : 6.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(3.w))),
                              child: Text('Back',
                                  style: TextStore.textTheme.headlineSmall!
                                      .copyWith(color: Colors.white))),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                                change(paymentConfirmationValues = true);
                                if (finalTotalValue == 0.0) {
                                  walletValue = finalTotalValue.toDouble();
                                  giftCardApi(rewardValue.toDouble());
                                } else {
                                  double walletValues =
                                      totalAndTaxValue.toDouble() -
                                          finalTotalValue.toDouble();
                                  Map value = {
                                    'order_sub_total':
                                        totalCost.value.toStringAsFixed(2),
                                    'Total': finalTotalValue.value
                                        .toStringAsFixed(2),
                                    'tax': totalCostWithTax.toStringAsFixed(2),
                                    'taxPrecent': salesTax,
                                    'ordermodenumber': orderModeNummberValues,
                                    'orderModeValues': orderModeNummberValues,
                                    "gift_card":
                                        checkBoxValue == true ? 'Wallet' : null,
                                    "gift_point": checkBoxValue == true
                                        ? walletValues.toStringAsFixed(2)
                                        : null,
                                    'pointsvalues': rewardValue.round(),
                                    'view': 'OrderPage',
                                    'mobile_type': deviceType,
                                  };
                                  print("Running on: ${Platform.isAndroid ? 'Android' : 'iOS'}");
                                  // print("Payload_val(wallet):$value");
                                  print("AndroidAlert:going to googlePaymentScreen and Payload_val-->:$value");
                                  Get.toNamed(Routes.googlePaymentScreen,
                                      arguments: value);

                                  // Get.toNamed(Routes.paymentScreen, arguments: value);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  side: BorderSide.none,
                                  fixedSize: Size(32.w,
                                      getDeviceType == "phone" ? 8.h : 6.h),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(3.w))),
                              child: Text('Continue',
                                  style: TextStore.textTheme.headlineSmall!
                                      .copyWith(color: Colors.white)))
                        ],
                      )
                    ],
                  ),
          ),
        );
      },
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  //Alert dialog for scheduled pickup
  scheduledPickUpAlertDialog(BuildContext context) {
    String? selectedValue = '';
    if (dropdownItems.isNotEmpty) {
      selectedValue = dropdownItems[0].value!;
    }
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return TextScaleFactorClamper(
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              title: Container(
                  padding: const EdgeInsets.all(1.0),
                  width: 70.w,
                  height: 40.h,
                  child: Form(
                      key: scheduledTimeFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextScaleFactorClamper(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("SCHEDULED-PICK UP",
                                    style:
                                        TextStyle(color: scheduledpickuporder)),
                                GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      showAlertDialog(Get.context!);
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                            color: Colors.red, //black54,
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.close,
                                            color: Colors.white, size: 26))),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.h),
                          if (dropdownItems.isNotEmpty)
                            TextScaleFactorClamper(
                              child: DropdownButtonFormField(
                                dropdownColor: Colors.white,
                                validator: (value) {
                                  if (selectedTimevalues.contains(value) !=
                                      false) {
                                    return 'Timeslot already booked';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      10.0, 1.0, 10.0, 1.0),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Select Time',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: borderColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              authTextFromFieldErrorBorderColor
                                                  .withOpacity(.5)),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: borderColor),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                value: selectedValue,
                                onChanged: (String? Value) {
                                  // print('selectedTimevalues:---> ${selectedTimevalues}');
                                  if (selectedTimevalues.contains(Value) ==
                                      false) {
                                    setState(() {
                                      selectedValue = Value;
                                    });
                                  } else {
// print('-----welcome');
                                  }
                                },
                                items: dropdownItems
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                      value: value.value,
                                      child: Text(
                                        value.value!,
                                        style: TextStyle(
                                            color: selectedTimevalues
                                                    .contains(value.value)
                                                ? Colors.grey
                                                : Colors.black),
                                      ));
                                }).toList(),
                              ),
                            ),
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    if (scheduledTimeFormKey.currentState!
                                        .validate()) {
                                      orderModeNummberValues = selectedValue;
                                      // orderMode.value = 'Scheduled Pick Up Order';
                                      change(orderMode.value);

                                      change(orderModeNummberValues,
                                          status: RxStatus.success());
                                      Get.back();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.h, horizontal: 14.w)),
                                  child: Text('Submit',
                                      style: TextStore.textTheme.headlineSmall!
                                          .copyWith(color: Colors.white))),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          SizedBox(height: 3.h),
                          const Text("*Kindly select your preferred check-in options for scheduling a pick-up within 30 minutes of food preparation initiation",
                              style:
                              TextStyle(color: scheduledpickuporder)),
                        ],
                      ))),
              titlePadding: const EdgeInsets.all(16),
            ),
          );
        });
      },
    ).then((value) {
      change(orderMode);
    });
  }

  checkBoxValues() {
    return CheckboxListTile(
      checkColor: Colors.white,
      activeColor: mainColor,
      title: TextScaleFactorClamper(
        child: RichText(
          text: TextSpan(
              text: "Dip wallet Balance : ",
              style: Get.context?.theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: '\$ ${walletValue.toStringAsFixed(2)}',
                    style: TextStore.textTheme.headlineSmall!.copyWith(
                        color: Colors.redAccent, fontWeight: FontWeight.bold))
              ]),
        ),
      ),
      value: double.parse(SharedPrefs.instance.getString('wallet')!) != 0.0
          ? checkBoxValue
          : false,
      onChanged: (value) {
        change(checkBoxValue = value!);
        if (kDebugMode) {
          print('checkbxval:$checkBoxValue');
        }
        if (checkBoxValue == false) {
          change(walletValue = walletValue1);
          change(finalTotalValue.value = totalAndTaxValue.value);
          change(isTotalValueZero = false);
          if (kDebugMode) {
            print('normal :${finalTotalValue.value}');
          }
        } else {
          if (walletValue1 > finalTotalValue.value.toDouble()) {
            change(walletValue = walletValue - finalTotalValue.toDouble());
            change(finalTotalValue.value = 0.0);
            change(isTotalValueZero = true);
            if (kDebugMode) {
              print('walVal>fintotalVal:${finalTotalValue.value}');
            }
          } else {
            change(finalTotalValue.value =
                finalTotalValue.toDouble() - walletValue);
            change(walletValue = 0.0);
            change(isTotalValueZero = false);
            if (kDebugMode) {
              print('fintotalVal - walVal:${finalTotalValue.value}');
            }
          }
        }
      },
    );
  }
}
