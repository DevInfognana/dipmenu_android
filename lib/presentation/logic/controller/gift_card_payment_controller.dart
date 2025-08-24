import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../../core/config/app_textstyle.dart';
import '../../../core/config/theme.dart';
import '../../../data/model/card_image_model.dart';
import '../../../data/model/gift_card_coupon_model.dart';
import '../../../data/model/payment_response.dart';
import '../../../domain/entities/dio_exception.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import '../../../domain/reporties/gift_card_api.dart';
import '../../../domain/reporties/payment_api.dart';

class GiftCardPaymentController extends GetxController with StateMixin {
  dynamic argumentData = Get.arguments;

  // String? totalValues;
  // String? taxValues;
  // String? subtotalValues;
  bool loading = false;
  // dynamic token;
  final numberFormat = NumberFormat("#,##0.00", "en_US");
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();
  TextEditingController cardDateController = TextEditingController();

  String? cardType;
  String? uniqueReferenceId;
  String? giftCardAmount;
  String? giftEmail;
  String? giftMessage;
  String? giftView;
  String? paymentUrl;
  DateTime now = DateTime.now();

  // int? orderId;

  final fromKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    cardType = ImageAsset.emptyCardView;
    change(null, status: RxStatus.success());
    giftCardAmount = argumentData['points'].toString();
    giftEmail = argumentData['email'].toString();
    giftMessage = argumentData['message'].toString();
    giftView = argumentData['view'].toString();
    urlChanges();
  }

  Future paymentAPi() async {
    var url = BaseAPI.paymentAPI;
    var cardInput = jsonEncode({
      "payload": {
        "channel": "WEB",
        "autoCapture": true,
        "order": {
          "orderId": "buy",
          "currency": "USD",
          "description": "buy gift cards for the user",
          "totalAmount": giftCardAmount,
          "orderBreakdown": {
            "items": [
              {"quantity": 1, "unitPrice": giftCardAmount}
            ],
            "subtotalAmount": giftCardAmount
          }
        },
        "customerAccount": {
          "payloadType": "KEYED",
          "accountType": "CHECKING",
          "cardDetails": {
            "dataFormat": "PLAIN_TEXT",
            "cardNumber":
                cardNumberController.text.replaceAll(' ', '').toString(),
            "cvv": int.parse(cardCvvController.text),
            "expiryDate": cardDateController.text.replaceAll('/', '')
          }
        },
        "processAsSale": false
      }
    });
    // print(cardInput);
    change(null, status: RxStatus.loading());
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
          if (giftView == 'TopUpWallet') {
            addWalletValues(
                amountValues: giftCardAmount,
                uniqueReference: uniqueReferenceId);
          } else {
            addCouponValues(
                uniqueReference: uniqueReferenceId,
                amountValues: giftCardAmount,
                emailValues: giftEmail,
                messageValues: giftMessage);
          }
        } else {
          if (values1.message == 'Invalid Card details') {
            failedPayment(Get.context!, values1.message, 0);
          } else {
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

  Future addCouponValues(
      {String? amountValues,
      String? uniqueReference,
      String? emailValues,
      String? messageValues}) async {
    final uservalues = await GiftCardAPi.addCouponApi(
        amount: amountValues!,
        code: uniqueReference!,
        email: emailValues!,
        message: messageValues);
    // print('payment detail:-->$uservalues');
    if (uservalues != null) {
      final values = GiftCardModelSuccess.fromJson(uservalues);
      confirmOrderAlertDialog(
          context: Get.context, orderId: 1, transaction: values.message);
      change(null, status: RxStatus.success());
    } else {
      failedOrderAlertDialog(Get.context!);
      change(null, status: RxStatus.error('something went wrong'));
    }
  }

  Future addWalletValues(
      {String? amountValues, String? uniqueReference}) async {
    final uservalues = await GiftCardAPi.addWalletApi(
        amount: amountValues!,
        code: uniqueReference!,
        userId: SharedPrefs.instance.getString('user_id')!);
    // print('payment detail:-->$uservalues');
    if (uservalues != null) {
      final values = GiftCardModelSuccess.fromJson(uservalues);
      confirmOrderAlertDialog(
          context: Get.context, orderId: 0, transaction: values.message);
      change(null, status: RxStatus.success());
    } else {
      failedOrderAlertDialog(Get.context!);
      change(null, status: RxStatus.error('something went wrong'));
    }
  }

  valuesChanges(bool  values){
    if(values ==true){
     return true;
    }else{
      return false;
    }
  }


  shaEncrypt() {
    // var now = new DateTime.now();
    // var formatter = new DateFormat('dd/MM/yyyy HH:mm');
    // String formattedDate = formatter.format(now);
    //5271001:232:10.00:05-29-2023:21:01:21:906:Test@123456789011

    String orderId = DateFormat('yyyy-MM-dd kkmmssSSS').format(now);
    String dateAndTime = DateFormat('yyyy-MM-dd:kk:mm:ss:SSS').format(now);
    var dataToHash =
        // '5271001:$orderId:${numberFormat.format(double.parse(giftCardAmount!))}:${dateAndTime.toString()}:Test@123456789011';
        '256572001:$orderId:${numberFormat.format(double.parse(giftCardAmount!))}:${dateAndTime.toString()}:Live@123456789011';

    var bytesToHash = utf8.encode(dataToHash);
    var sha512Digest = sha512.convert(bytesToHash);
    return sha512Digest;

  }
  urlChanges(){
    String orderId = DateFormat('yyyy-MM-dd kkmmssSSS').format(now);
    String dateAndTime = DateFormat('yyyy-MM-dd:kk:mm:ss:SSS').format(now);
    // change(paymentUrl='https://testpayments.worldnettps.com/merchant/paymentpage?TERMINALID=5271001&ORDERID=$orderId&CURRENCY=USD&DATETIME=$dateAndTime&AMOUNT=${numberFormat.format(double.parse(giftCardAmount!))}&HASH=${shaEncrypt().toString()}');
    change(paymentUrl='https://payments.worldnettps.com/merchant/paymentpage?TERMINALID=256572001&ORDERID=$orderId&CURRENCY=USD&DATETIME=$dateAndTime&AMOUNT=${numberFormat.format(double.parse(giftCardAmount!))}&HASH=${shaEncrypt().toString()}');
// print(paymentUrl);
  }


}

confirmOrderAlertDialog(
    {BuildContext? context, int? orderId, String? transaction}) {
  showDialog(
    context: context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: TextScaleFactorClamper(
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
              width: 70.w,
              height: 30.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h, width: 200.w,
                    child: Lottie.asset(ImageAsset.paymentSuccess,
                        fit: BoxFit.contain),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children:  [
                  //     Text("Thanks for Order",
                  //         style: TextStore.textTheme.headlineMedium!
                  //             .copyWith(color: Colors.green,fontWeight: FontWeight.bold)),
                  //   ],
                  // ),
                  SizedBox(height: 1.2.h),
                  orderId==1?
                  Text(
                    'Payment Successful. Email has been sent successfully.',
                    textAlign: TextAlign.center,
                    style: TextStore.textTheme.titleLarge!
                        .copyWith(color: Colors.black),
                  ):Text(
                    'The amount has been added successfully to the Dip wallet.',
                    textAlign: TextAlign.center,
                    style: TextStore.textTheme.titleLarge!
                        .copyWith(color: Colors.black),
                  ),
                  // SizedBox(height: 0.9.h),
                  // Wrap(
                  //   crossAxisAlignment: WrapCrossAlignment.center,
                  //   children: [
                  //     Text('Order Id',
                  //         style: TextStore.textTheme.headlineSmall!.copyWith(
                  //             color: Colors.black, fontWeight: FontWeight.bold)),
                  //     Text("  #$orderId",
                  //         style: TextStore.textTheme.headlineSmall!.copyWith(
                  //             color: Colors.black, fontWeight: FontWeight.bold))
                  //   ],
                  // ),
                  SizedBox(height: 1.h),
                  // Text("Please make ensure your order",
                  //     style: TextStore.textTheme.titleLarge!
                  //         .copyWith(color: Colors.black)),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //       backgroundColor: darkSeafoamGreen1,
                  //       fixedSize:  Size(30.w, 4.h),
                  //       textStyle: TextStore.textTheme.headlineSmall!
                  //           .copyWith(color: Colors.white),
                  //       elevation: 6),
                  //   onPressed: () {
                  //     null;
                  //   },
                  //   child: const Text('Check-in'),
                  // ),
                  // Text("Once your order arrive",
                  //     style: TextStore.textTheme.titleLarge!
                  //         .copyWith(color: Colors.black)),
                  //
                  // SizedBox(height: 2.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(Routes.mainScreen, arguments: 3);
                            SharedPrefs.instance.setInt('bottomBar', 3);

                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 10.w)),
                          child: const Text(
                            'Back to Home',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(height: 2.h),
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
          backgroundColor: Colors.white,
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
          backgroundColor: Colors.white,
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

