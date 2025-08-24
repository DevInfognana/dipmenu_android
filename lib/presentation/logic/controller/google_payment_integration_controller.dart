import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:dip_menu/presentation/logic/controller/payment_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/config/app_textstyle.dart';
import '../../../core/config/theme.dart';
import '../../../data/model/gift_card_coupon_model.dart';
import '../../../data/model/mobile_payment_checking.dart';
import '../../../data/model/order_update.dart';
import '../../../data/model/payment_model.dart';
import '../../../data/model/recent_order_model.dart';
import '../../../domain/entities/dio_exception.dart';
import '../../../domain/reporties/gift_card_api.dart';
import '../../../domain/reporties/payment_api.dart';
import '../../../extra/common_widgets/text_form_field_2.dart';
import 'gift_card_payment_controller.dart';
import 'dart:io' show Platform;
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';




const webviewChannel = MethodChannel('com.demo.webview_channel');


class GooglePaymentIntegrationController extends GetxController
    with StateMixin {
  dynamic argumentData = Get.arguments;

  String? totalValues;
  String? taxValues;
  String? subtotalValues;
  bool loading = false;
  dynamic token;
  String? totalAmount;
  String? orderId;

  // final paymentDetailController = Get.find<PaymentDetailController>();
  DateTime now = DateTime.now();
  final numberFormat = NumberFormat("#,##0.00", "en_US");
  String? paymentUrl;
  String? responseUrl;
  String? pageView;
  String? giftEmail;
  String? giftMessage;
  final TextEditingController shareCouponCodeController =
      TextEditingController();
  InAppWebViewController? webViewController;
  InAppWebViewController? webViewPopController;
  String? randomToken;
  Timer? timer;
  RecentOrderData? recentOrderData;

  @override
  void onInit() {
    super.onInit();
    pageView = argumentData['view'].toString();
    pageDependView();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  String generateRandomString() {
    Random random = Random();
    String characters = '0123456789abcdefghijklmnopqrstuvwxyz';
    String randomString = '';
    for (int i = 0; i < 15; i++) {
      randomString += characters[random.nextInt(characters.length)];
    }
    randomToken=randomString;
    return randomString;
  }

  pageDependView() {
    if (pageView == 'OrderPage') {


      generateRandomString();
      validateToken(tempToken: randomToken);
    } else {
      generateRandomString();
      validateToken(tempToken: randomToken);
      giftEmail = argumentData['email'].toString();
      giftMessage = argumentData['message'].toString();
       change(orderId = DateFormat('yyyy-MM-dd kkmmssSSS').format(now));
      change(totalAmount =
          numberFormat.format(double.parse(argumentData['points'].toString())));

      change(null, status: RxStatus.success());
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
        "gift_card": argumentData['gift_card'] == null
            ? null
            : argumentData['gift_card'].toString(),
        "gift_point": argumentData['gift_point'] == null
            ? '0.00'
            : argumentData['gift_point'].toString(),
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
        "orderMode_details": "",
        "ordered_from" : "mobile",
        "mobileToken":Platform.isIOS?randomToken:''
      }
    });
    // print('--temptoken---${randomToken!}');

    // print(cardInput);

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
        change(orderId = user.orderId.toString());
        change(totalAmount = numberFormat
            .format(double.parse(argumentData['Total'].toString())));
        change(null, status: RxStatus.success());
        // paymentAPi(
        //     cardnumbervalue: cardNumberController.text.replaceAll(' ', ''),
        //     cvv1: int.parse(cardCvvController.text),
        //     payment: argumentData['Total'].toString(),
        //     orernumber1: user.orderId!,
        //     expiraydate: cardDateController.text.replaceAll('/', ''));
        urlChanges();
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

  shaEncrypt() {
    // var now = new DateTime.now();
    // var formatter = new DateFormat('dd/MM/yyyy HH:mm');
    // String formattedDate = formatter.format(now);
    //5271001:232:10.00:05-29-2023:21:01:21:906:Test@123456789011
    // String orderId = DateFormat('yyyy-MM-dd kkmmssSSS').format(now);
    String dateAndTIme = DateFormat('yyyy-MM-dd:kk:mm:ss:SSS').format(now);
    var
    dataToHash =
    '256572001:${orderId.toString()}:$totalAmount:${dateAndTIme.toString()}:Live@123456789011';
    // '5271001:${orderId.toString()}:$totalAmount:${dateAndTIme.toString()}:Test@123456789011';
    // if(pageView == 'OrderPage'){
    //
    // }else{
    //    dataToHash =
    //       '5271001:$totalAmount:${dateAndTIme.toString()}:Test@123456789011';
    // }


    var bytesToHash = utf8.encode(dataToHash);
    var sha512Digest = sha512.convert(bytesToHash);
    return sha512Digest;
  }

  urlChanges() {

    if (Platform.isAndroid) {
      String dateAndTIme = DateFormat('yyyy-MM-dd:kk:mm:ss:SSS').format(now);
      change(paymentUrl =
      'https://payments.worldnettps.com/merchant/paymentpage?TERMINALID=256572001&ORDERID=${orderId.toString()}&PAGES=ORDER&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
      // 'https://testpayments.worldnettps.com/merchant/paymentpage?TERMINALID=5271001&ORDERID=${orderId.toString()}&PAGES=ORDER&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
      // print(paymentUrl);
      // launchInWebViewOrVC(Uri.parse(paymentUrl!));
      change(null, status: RxStatus.success());
    } else if (Platform.isIOS) {
      String dateAndTIme = DateFormat('yyyy-MM-dd:kk:mm:ss:SSS').format(now);
      if(pageView == 'OrderPage'){
        // change(paymentUrl ='${BaseAPI.mobilePayment}${SharedPrefs.instance.getString('user_id')!}/${randomToken!}/TERMINALID=5271001&ORDERID=${orderId.toString()}&PAGES=ORDER&DEVICE=MOBILE&MOBILETOKEN=$randomToken&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
        change(paymentUrl ='${BaseAPI.mobilePayment}${SharedPrefs.instance.getString('user_id')!}/${randomToken!}/TERMINALID=256572001&ORDERID=${orderId.toString()}&PAGES=ORDER&DEVICE=MOBILE&MOBILETOKEN=$randomToken&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
      }else if (pageView == 'TopUpWallet') {
        change(paymentUrl ='${BaseAPI.mobilePayment}${SharedPrefs.instance.getString('user_id')!}/${randomToken!}/TERMINALID=256572001&ORDERID=${orderId.toString()}&PAGES=DIPWALLET&DEVICE=MOBILE&MOBILETOKEN=$randomToken&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
        // change(paymentUrl ='${BaseAPI.mobilePayment}${SharedPrefs.instance.getString('user_id')!}/${randomToken!}/TERMINALID=5271001&ORDERID=${orderId.toString()}&PAGES=DIPWALLET&DEVICE=MOBILE&MOBILETOKEN=$randomToken&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
      }
      else if (pageView == 'buyGiftCard') {
        change(paymentUrl ='${BaseAPI.mobilePayment}${SharedPrefs.instance.getString('user_id')!}/${randomToken!}/TERMINALID=256572001&ORDERID=${orderId.toString()}&PAGES=BUYGIFTCARD&MESSAGE=$giftMessage&DEVICE=MOBILE&MOBILETOKEN=$randomToken&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
        // change(paymentUrl ='${BaseAPI.mobilePayment}${SharedPrefs.instance.getString('user_id')!}/${randomToken!}/TERMINALID=5271001&ORDERID=${orderId.toString()}&PAGES=BUYGIFTCARD&MESSAGE=$giftMessage&DEVICE=MOBILE&MOBILETOKEN=$randomToken&CURRENCY=USD&DATETIME=$dateAndTIme&AMOUNT=$totalAmount&HASH=${shaEncrypt().toString()}');
      }
      change(null, status: RxStatus.loading());
      // print(paymentUrl);
      openWebView(paymentUrl!);
      startTimer();
    }
  }

  Future<void> openWebView(String url) async {
    try {
      final Map<String, dynamic>? result = await webviewChannel.invokeMethod('openWebView', {'url': url});

    } on PlatformException catch (e) {
      print('Error opening WebView: ${e.message}');
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (t) {
      if(pageView == 'OrderPage'){
        recentOrder(orderId: orderId);
      }else if (pageView == 'TopUpWallet') {
        mobilewalletCheck(tempToken:randomToken );
      }
      else if (pageView == 'buyGiftCard') {
        // mobilewalletCheck(tempToken:randomToken );
        mobileGiftCardCheck(tempToken:randomToken );
      }

    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Future<void> closeWebViewAfterDelay() async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      await webviewChannel.invokeMethod('closeWebView');

    } on PlatformException catch (e) {
      print('Error closing WebView: ${e.message}');
    }
  }

  viewOfPage(String url) {
    change(null, status: RxStatus.loading());
    final Uri myUri = Uri.parse(url);
    final Map<String, dynamic> result = myUri.queryParameters;
    if (result['RESPONSECODE'] == 'A') {
      if (pageView == 'OrderPage') {
        updatesucessPaymentOrder(
            caseValues: 1,
            orderNUmber: int.parse(orderId!),
            paymentMessage: "payment sucess",
            uniqueReference: result['UNIQUEREF'],
            values: "");
      } else if (pageView == 'TopUpWallet') {
        addWalletValues(
            amountValues: totalAmount, uniqueReference: result['UNIQUEREF']);
      } else if (pageView == 'buyGiftCard') {
        addCouponValues(
            uniqueReference: result['UNIQUEREF'],
            amountValues: totalAmount,
            emailValues: '',
            messageValues: giftMessage);
      }
      webViewController!.goBack();
      webViewPopController!.goBack();
    } else if (result['RESPONSECODE'] == 'D') {
      if (pageView == 'OrderPage') {
        updatePaymentOrder(
            caseValues: 0,
            orderNUmber: int.parse(orderId!),
            paymentMessage: 'Payment Failed',
            uniqueReference: result['UNIQUEREF'],
            values: '');
      }

      failedOrderAlertDialog(Get.context!);
      change(null, status: RxStatus.error('PaymentFailed'));
      webViewController!.goBack();
      webViewPopController!.goBack();
    }
    change(null, status: RxStatus.error('PaymentFailed'));
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
    if (uservalues != null) {
      final addCouponValues = AddCouponCode.fromJson(uservalues);
      // print(addCouponValues);
      shareCouponCodeController.text = addCouponValues.couponcode!;
      // change(shareCouponCodeController.text=values.payload!.code!);
      shareAlertDialog(Get.context!);

      change(null, status: RxStatus.success());
    } else {
      failedOrderAlertDialog(Get.context!);
      change(null, status: RxStatus.error('something went wrong'));
    }
  }


  Future validateToken({String? tempToken}) async {
    final uservalues = await PaymentApi().validateMobileToken(tempToken:tempToken );
    change(null, status: RxStatus.loading());
    // print('payment detail:-->$uservalues');
    if (uservalues != null) {
      if(pageView == 'OrderPage'){
        paymentOrder();
      }else{
         urlChanges();
      }
    }
  }


  Future recentOrder({String? orderId}) async {
    final uservalues = await PaymentApi().recentOrderDetails(orderId:orderId );
    change(null, status: RxStatus.loading());
    if (uservalues != null) {
      recentOrderData=  RecentOrderData.fromJson(uservalues);

      recentOrderData!.data?.forEach((element) {
        // print(element.orderStatus);
        if(element.orderStatus == 4){
          closeWebViewAfterDelay();
          stopTimer();
          confirmOrderAlertDialog(
              context: Get.context,
              orderId: int.parse(orderId!),
              transaction: element.transactionid);
        }else if(element.orderStatus == 3){
          failedOrderAlertDialog(Get.context!);
        }

      });
    }
  }

  Future mobileGiftCardCheck({String? tempToken}) async {
    final uservalues = await PaymentApi().mobileGiftCardCheck(temptoken:tempToken );
    change(null, status: RxStatus.loading());
    if (uservalues != null) {
      final values = MobileWalletModel.fromJson(uservalues);
      if(values.mobileWalletData !=null){
        closeWebViewAfterDelay();
        stopTimer();
        // print(values.mobileWalletData);
        if (values.mobileWalletData?.code != null ) {
          final sharvalues=MobileWalletData.fromJson(uservalues['data']);
           shareCouponCodeController.text =sharvalues.code!;
        }
        shareAlertDialog(Get.context!);

      }
    }
  }


  Future mobilewalletCheck({String? tempToken}) async {
    final uservalues = await PaymentApi().mobileWalletCheck(temptoken:tempToken );
    change(null, status: RxStatus.loading());
    if (uservalues != null) {
      final values = MobileWalletModel.fromJson(uservalues);
      if(values.mobileWalletData !=null){
        closeWebViewAfterDelay();
        stopTimer();

        giftConfirmOrderAlertDialog(
          context: Get.context,
          orderId: 0,
        );

        // change(shareCouponCodeController.text=values.payload!.code!);
      }
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
      // final values = GiftCardModelSuccess.fromJson(uservalues);
      giftConfirmOrderAlertDialog(
        context: Get.context,
        orderId: 0,
      );
      change(null, status: RxStatus.success());
    } else {
      failedOrderAlertDialog(Get.context!);
      change(null, status: RxStatus.error('something went wrong'));
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
        change(null, status: RxStatus.success());
        failedOrderAlertDialog(Get.context!);
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
            orderId: int.parse(orderId!),
            transaction: uniqueReference);

        // if(kReleaseMode){
        createPdf(orderId: orderId);
        // }
        change(null, status: RxStatus.success());
      } else {
        // failedOrderAlertDialog(Get.context!);
        change(null, status: RxStatus.error('something went wrong'));
      }
    }
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
                      Text("Payment failed",
                          style: TextStyle(color: Colors.red)),
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

  shareAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w)),
            title: Text('Gift-card Purchased Successfully',
                style: TextStore.textTheme.headlineSmall!
                    .copyWith(color: mainColor, fontWeight: FontWeight.bold)),
            content: SizedBox(
              width: 85.w,
              height: 34.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.2.w, vertical: 2.h),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  "Copy and share this code to your loved ones ",
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.black)),
                          const WidgetSpan(
                            child:
                                Icon(Icons.card_giftcard, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Semantics(
                      textField: true,
                      label: 'CouponCodeTextField',
                      child: AuthTextFromField2(
                        readOnly: true,
                        controller: shareCouponCodeController,
                        obscureText: false,
                        validator: (value) {},
                        labelText: '',
                        values: 0,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.copy, size: 30, color: mainColor),
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(
                                text:
                                    shareCouponCodeController.text.toString()));
                            showSnackBar('Coupon code copied');
                            // Share.share('I\'m sharing you Velvet Cream Gift coupon with you. \nCoupon code: ${shareCouponCodeController.text.toString()} \nClick here to redeem the coupon code: https://dipmenu-website-uat.demomywebapp.com/');
                          },
                        ),
                        //NameValues.email,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWithFont().textWithPoppinsFont(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w300,
                            text: 'Share coupon code ',
                            color: Colors.black),
                        InkWell(
                          onTap: () {
                            // RenderObject? renderBox = shareButtonKey.currentContext?.findRenderObject();
                            final Size size1 = MediaQuery.of(context).size;
                            Share.share(
                                sharePositionOrigin: Rect.fromLTWH(
                                    0, 0, size1.width, size1.height / 2),
                                'I\'m sharing you Velvet Cream Gift coupon with you. \nCoupon code: ${shareCouponCodeController.text.toString()} \nClick here to redeem the coupon code: https://dipmenu-website-uat.demomywebapp.com/');
                          },
                          child: TextWithFont().textWithPoppinsFont(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                              text: ' here',
                              color: Colors.lightBlue),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
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
                                    borderRadius: BorderRadius.circular(2.w)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 10.w)),
                            child: const Text('Back to Home',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  giftConfirmOrderAlertDialog(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
                width: 70.w,
                height: 30.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 10.h,
                        width: 200.w,
                        child: Lottie.asset(ImageAsset.paymentSuccess,
                            fit: BoxFit.contain)),
                    SizedBox(height: 1.2.h),
                    orderId == 1
                        ? Text(
                            'Payment Successful. Email has been sent successfully.',
                            textAlign: TextAlign.center,
                            style: TextStore.textTheme.titleLarge!
                                .copyWith(color: Colors.black),
                          )
                        : Text(
                            'The amount has been added successfully to the Dip wallet.',
                            textAlign: TextAlign.center,
                            style: TextStore.textTheme.headlineSmall!
                                .copyWith(color: Colors.black),
                          ),
                    SizedBox(height: 1.h),
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
                                    borderRadius: BorderRadius.circular(2.w)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 10.w)),
                            child: const Text('Back to Home',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
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

  confirmOrderAlertDialog(
      {BuildContext? context, int? orderId, String? transaction}) {
    showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: TextScaleFactorClamper(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.1.h, horizontal: 0.5.w),
                  width: 70.w,
                  height: 52.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                        width: 200.w,
                        child: Lottie.asset(ImageAsset.paymentSuccess,
                            fit: BoxFit.contain),
                      ),
                      TextScaleFactorClamper(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Thanks for Order",
                                style: TextStore.textTheme.headlineMedium!.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold)),
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            Text("  #$orderId",
                                style: TextStore.textTheme.headlineSmall!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))
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
                              fixedSize: Size(30.w, 4.h),
                              textStyle: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white),
                              elevation: 6),
                          onPressed: () {
                            null;
                          },
                          child: const Text('Check-in'),
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
                                  Get.offAllNamed(Routes.mainScreen,
                                      arguments: 0);
                                  SharedPrefs.instance.setInt('bottomBar', 0);
                                  Get.delete<
                                      GooglePaymentIntegrationController>();
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
                                  child: Text('Back to Home',
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
          ),
        );
      },
    );
  }
}
