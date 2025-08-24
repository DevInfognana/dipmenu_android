import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dip_menu/presentation/logic/controller/payment_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../core/config/app_textstyle.dart';
import '../../../core/config/theme.dart';
import '../../../data/model/card_image_model.dart';
import '../../../data/model/order_update.dart';
import '../../../data/model/payment_model.dart';
import '../../../data/model/payment_response.dart';
import '../../../domain/entities/dio_exception.dart';
import '../../../domain/reporties/payment_api.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';


class PaymentController extends GetxController with StateMixin {
  dynamic argumentData = Get.arguments;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();
  TextEditingController cardDateController = TextEditingController();
  String? cardType;
  String? uniqueReferenceId;
  int? orderId;
  final paymentDetailController = Get.find<PaymentDetailController>();
  final fromKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    cardType = ImageAsset.emptyCardView;
    change(null, status: RxStatus.success());
  }

  Future paymentAPi(
      {required String cardnumbervalue,
      required int cvv1,
      required String payment,
      required int orernumber1,
      required String expiraydate}) async {
    var url = BaseAPI.paymentAPI;
    var cardInput = jsonEncode({
      "payload": {
        "channel": "WEB",
        "terminal": NameValues.terminalValues,
        "order": {
          "orderId": orernumber1,
          "description": "my values order",
          "currency": "USD",
          "totalAmount": payment,
          "orderBreakdown": {"subtotalAmount": payment}
        },
        "customerAccount": {
          "payloadType": "KEYED",
          "accountType": "CHECKING",
          "cardDetails": {
            "dataFormat": "PLAIN_TEXT",
            "cardNumber": cardnumbervalue,
            "cvv": cvv1,
            "expiryDate": expiraydate
          }
        },
        "autoCapture": true,
        "processAsSale": false
      }
    });
    // print(BaseAPI.paymentAPI);
    // print(cardInput);

    try {
      var response = await Dio().post(
        url,
        data: cardInput,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-access-token': SharedPrefs.instance.getString('token'),
          },
          sendTimeout: Duration(seconds: 120), //sendTimeout: 120 * 1000,
          receiveTimeout: Duration(seconds: 120), //receiveTimeout: 120 * 1000,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final values1 = Failuremessage.fromJson(response.data);
        if (values1.status == true) {
          final values = PaymentResponseAPi.fromJson(response.data);
          change(uniqueReferenceId = values.data!.uniqueReference!);
          change(orderId = orernumber1);
          updatesucessPaymentOrder(
              caseValues: 1,
              orderNUmber: orernumber1,
              paymentMessage: values.message,
              uniqueReference: uniqueReferenceId,
              values: response);
        } else {
          if (values1.message == 'Invalid Card details') {
            updatePaymentOrder(
                caseValues: 0,
                orderNUmber: values1.orderId,
                paymentMessage: values1.message,
                uniqueReference: '0',
                values: '');
            failedPayment(Get.context!, values1.message, 0);
          } else {
            updatePaymentOrder(
                caseValues: 0,
                orderNUmber: values1.orderId,
                paymentMessage: values1.message,
                uniqueReference: '0',
                values: '');
            failedPayment(Get.context!,
                'If any amount has been deducted. Please contact', 1);
          }
          change(null, status: RxStatus.error('something went wrong'));
        }
      } else {
        failedOrderAlertDialog(Get.context!);
        change(null, status: RxStatus.error('something went wrong'));
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      updatePaymentOrder(
          caseValues: 0,
          orderNUmber: orernumber1,
          paymentMessage: errorMessage,
          uniqueReference: '0',
          values: '');
      failedPayment(
          Get.context!, 'If any amount has been deducted. Please contact', 1);
    }
  }

  Future paymentOrder() async {
    change(null, status: RxStatus.loading());
    var url = BaseAPI.newOrder;
    var cardInput = jsonEncode({
      "payload": {
        "transactionid": "0",
        "type": "sale",
        "final_amount": argumentData['Total'].toString(),
        "order_amount": argumentData['Total'].toString(),
        "sub_total": argumentData['order_sub_total'].toString(),
        "tax_percent": int.parse(argumentData['taxPrecent']),
        "tax_amount": argumentData['tax'].toString(),
        "redeem_points": int.parse(argumentData['pointsvalues'].toString()),
        "po_number": 1,
        "payment_method": "CARD",
        "payment_status": "Ready",
        "order_status": 0,
        "print_status": 0,
        "status": 1,
        "gift_card": argumentData['gift_card']==null?null: argumentData['gift_card'].toString(),
        "gift_point": argumentData['gift_point']==null?'0.00': argumentData['gift_point'].toString(),
        "refund": 0,
        "order_response": "",
        "order_number": "",
        // "order_mode": argumentData['ordermodenumber'],
        // "orderMode_details": argumentData['orderModeValues'],

        "schedulePickup": argumentData['orderModeValues'] == null ? '0' : '1',
        "schedulePickup_time": argumentData['orderModeValues'] == null
            ? ''
            : argumentData['orderModeValues'],
        "order_mode": '0',
        "ordered_from" : "mobile",
        "orderMode_details": ""
      }
    });
    // print(BaseAPI.newOrder);
    // print(cardInput);
    // print(SharedPrefs.instance.getString('token'));
    try {
      var response = await Dio().post(
        url,
        data: cardInput,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-access-token': SharedPrefs.instance.getString('token')
          },
        ),
      );

      if (response.statusCode == 200) {
        var user = PaymentModel.fromJson(response.data);
        paymentAPi(
            cardnumbervalue: cardNumberController.text.replaceAll(' ', ''),
            cvv1: int.parse(cardCvvController.text),
            payment: argumentData['Total'].toString(),
            orernumber1: user.orderId!,
            expiraydate: cardDateController.text.replaceAll('/', ''));
      } else {
        failedOrderAlertDialog(Get.context!);
        change(null, status: RxStatus.error('something went wrong'));
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      change(null, status: RxStatus.error(errorMessage));

      failedPayment(
          Get.context!, 'If any amount has been deducted. Please contact', 1);
    }
  }

  Future cardCheckingApi(String? cardNumber) async {
    final user = await PaymentApi().cardtype(cardNumber?.replaceAll(' ', ''));
    if (user != null) {
      final values = Cardimage.fromJson(user);
      if (values.result!.cardType != null) {
        if (values.result!.cardType == 'VISA' ||
            values.result!.cardType == 'VISA DEBIT') {
          cardType = ImageAsset.cardVisa;
        } else if (values.result!.cardType == 'ELECTRON') {
          cardType = ImageAsset.cardVisa;
        } else if (values.result!.cardType == 'MAESTRO') {
          cardType = ImageAsset.cardMastero;
        } else if (values.result!.cardType == 'DEBIT MASTERCARD') {
          cardType = ImageAsset.cardMastero;
        } else if (values.result!.cardType == 'DISCOVER') {
          cardType = ImageAsset.cardDiscover;
        } else if (values.result!.cardType == 'JCB') {
          cardType = ImageAsset.cardJcb;
        } else if (values.result!.cardType == 'DEBIT MASTERCARD') {
          cardType = ImageAsset.cardMastero;
        } else {
          cardType = ImageAsset.emptyCardView;
        }
        change(cardType);
      } else {
        cardType = ImageAsset.emptyCardView;
        change(cardType);
      }
    }
  }

  Future updatePaymentOrder(
      {int? orderNUmber,
      int? caseValues,
      String? paymentMessage,
      String? uniqueReference,
      var values}) async {
    final uservalues = await PaymentApi().updatefailureOrder(
        orderNumber: orderNUmber,
        caseValues: caseValues,
        paymentMessage: paymentMessage,
        paymentUniqueRefernceId: uniqueReference,
        responseValues: values);
    // print('payment detail:-->$uservalues');
    if (uservalues != null) {
      final values = OrderUpdateValues.fromJson(uservalues);
      if (values.orderStatus == 3) {
        // confirmOrderAlertDialog(
        //     context: Get.context,
        //     orderId: orderId,
        //     TranscantionI: uniqueReferenceId);
        change(null, status: RxStatus.success());
      } else {
        // failedOrderAlertDialog(Get.context!);
        change(null, status: RxStatus.error('something went wrong'));
      }
    }
  }

  Future updatesucessPaymentOrder(
      {int? orderNUmber,
      int? caseValues,
      String? paymentMessage,
      String? uniqueReference,
      var values}) async {
    final uservalues = await PaymentApi().updatesucessOrder(
        orderNumber: orderNUmber,
        caseValues: caseValues,
        paymentMessage: paymentMessage,
        paymentUniqueRefernceId: uniqueReference,
        responseValues: values);
    if (uservalues != null) {
      final values = OrderUpdateValues.fromJson(uservalues);
      if (values.orderStatus == 4) {
        confirmOrderAlertDialog(
            context: Get.context,
            orderId: orderId,
            transcantionI: uniqueReferenceId);
        change(null, status: RxStatus.success());
      } else {
        // failedOrderAlertDialog(Get.context!);
        change(null, status: RxStatus.error('something went wrong'));
      }
    }
  }
}

confirmOrderAlertDialog(
    {BuildContext? context, int? orderId, String? transcantionI}) {
  showDialog(
    context: context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: TextScaleFactorClamper(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Container(
              padding: EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 0.5.w),
              width: 70.w,
              height: 52.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h, width: 200.w,
                    child: Lottie.asset(ImageAsset.paymentSuccess,
                        fit: BoxFit.contain),
                  ),
                  TextScaleFactorClamper(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text("Thanks for Order",
                            style: TextStore.textTheme.headlineMedium!
                                .copyWith(color: Colors.green,fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.9.h),
                  TextScaleFactorClamper(
                    child: Text(
                      'Your payment has been confirmed.\n You can check the details.',
                      textAlign: TextAlign.center,
                      style: TextStore.textTheme.titleLarge!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 0.9.h),
                  TextScaleFactorClamper(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('Order Id',
                            style: TextStore.textTheme.headlineSmall!.copyWith(
                                color: Colors.black, fontWeight: FontWeight.bold)),
                        Text("  #$orderId",
                            style: TextStore.textTheme.headlineSmall!.copyWith(
                                color: Colors.black, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  SizedBox(height: 0.9.h),
                  TextScaleFactorClamper(
                    child: Text("Please make ensure your order",
                        style: TextStore.textTheme.titleLarge!
                            .copyWith(color: Colors.black)),
                  ),
                  TextScaleFactorClamper(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: darkSeafoamGreen1,
                          fixedSize:  Size(30.w, 4.h),
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
                  ),
                  // TextScaleFactorClamper(
                  //   child: Text("Once your order arrive",
                  //       style: TextStore.textTheme.titleLarge!
                  //           .copyWith(color: Colors.black)),
                  // ),

                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextScaleFactorClamper(
                        child: ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.mainScreen, arguments: 0);
                              SharedPrefs.instance.setInt('bottomBar', 0);
                              Get.delete<PaymentController>();
                              Get.delete<PaymentDetailController>();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.w),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 10.w)),
                            child: TextScaleFactorClamper(
                              child: Text(
                                'Back to Home',
                                  style: TextStore.textTheme.headlineSmall!
                                      .copyWith(color: Colors.white)
                                // style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

failedOrderAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TextScaleFactorClamper(
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Container(
            padding: const EdgeInsets.all(1.0),
            width: 70.w,
            height: 40.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: Lottie.asset(ImageAsset.paymentFailed,
                      height: 15.h, width: 200.w, fit: BoxFit.fill),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Payment failed", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(height: 1.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(
                        child: Center(
                      child: Text(
                        "Try again later",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 10.w)),
                        child: const Text(
                          'Back to Retry',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}

failedPayment(BuildContext context, String? errormessage, int values) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return TextScaleFactorClamper(
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Container(
            padding: const EdgeInsets.all(1.0),
            width: 70.w,
            height: values == 0 ? 40.h : 50.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.h),
                  child: Lottie.asset(ImageAsset.paymentFailed,
                      height: 15.h, width: 200.w, fit: BoxFit.fill),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Payment failed", style: TextStyle(color: Colors.red)),
                  ],
                ),
                SizedBox(height: 1.5.h),
                values == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(errormessage!,
                              style: TextStore.textTheme.titleLarge!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                              child: Text(
                                  '${errormessage!} \n${'Mobile Number : (662) 429-6540'} \n${'Email ID : velvetcream@gmail.com'}',
                                  style: TextStore.textTheme.titleLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.w),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 10.w)),
                        child: const Text(
                          'Back to Retry',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
