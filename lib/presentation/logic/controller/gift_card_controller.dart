import 'package:dip_menu/extra/common_widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../core/config/app_textstyle.dart';
import '../../../core/config/theme.dart';
import '../../../data/model/getGiftcard.dart';
import '../../../data/model/giftValues.dart';
import '../../../data/model/gift_card_coupon_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import '../../../domain/reporties/gift_card_api.dart';
// import 'package:timezone/timezone.dart' as tz;

class GiftCardController extends GetxController with StateMixin {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController couponCodeController = TextEditingController();
  final TextEditingController emailTextController1 = TextEditingController();
  final TextEditingController amountController1 = TextEditingController();
  dynamic argumentData = Get.arguments;

  final buyGiftCardFromKey = GlobalKey<FormState>();
  final redeemCodeFromKey = GlobalKey<FormState>();
  final topUpWalletFromKey = GlobalKey<FormState>();

  //share alert dialog form key
  final shareFormKey = GlobalKey<FormState>();
  bool? couponCodeValue;
  List<GetGiftCardsData> myTransaction = [];
  List<TopUPValuesData> purchaseListHistory = [];

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  checkCouponCode({String? amountValues, String? uniqueReference}) async {
    change(null, status: RxStatus.loading());
    final uservalues = await GiftCardAPi.checkCouponCodeApi(
        code: couponCodeController.text.toString());

    if (uservalues != null) {
      // print('welcome');
      final values = GiftCardModelSuccess.fromJson(uservalues);
      // print('-coupcodeval:-------${values.status!}');
      change(couponCodeValue = values.status!);
      // print('------------$couponCodeValue');
      if (values.status != false) {
        // showSnackBar('Successfully Redeem');
        emptyListDialog(Get.context!);
      }
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('something went wrong'));
    }
  }

  getGiftCard() async {
    change(null, status: RxStatus.loading());
    final uservalues = await GiftCardAPi.getGiftCardAPi();
    myTransaction.clear();
    if (uservalues != null) {
      final values = GetGiftCards.fromJson(uservalues);
      myTransaction.addAll(values.data!);
      // print(myTransaction.length);
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('something went wrong'));
    }
  }

  getGiftList() async {
    change(null, status: RxStatus.loading());
    final uservalues = await GiftCardAPi.getGiftListAPi();
    purchaseListHistory.clear();
    if (uservalues != null) {
      final values = TopUPValues.fromJson(uservalues);
      purchaseListHistory.addAll(values.data!);
      // print(purchaseListHistory.length);
      change(null, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.error('something went wrong'));
    }
  }

  dateformate(String values){
    // var istanbulTimeZone =
    // tz.getLocation(SharedPrefs.instance.getString('timeZone')!);
    // var now = tz.TZDateTime.now(istanbulTimeZone).toString();


    return DateFormat("MM-dd-yyyy").format(DateTime.parse(values));
   // return DateFormat("MM-dd-yyyy").parse("$now").toString().substring(0,10);
  }

  emptyListDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            padding: const EdgeInsets.all(1.0),
            width: 70.w,
            height: 30.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Lottie.asset(ImageAsset.paymentSuccess,
                      height: 14.h, width: 200.w, fit: BoxFit.contain),
                ),
                SizedBox(height: 1.h),
                Center(
                    child: Text(
                        "The amount added to the Dip Wallet Successfully.",
                        textAlign: TextAlign.center,
                        style: TextStore.textTheme.headlineSmall!
                            .copyWith(color: descriptionColor))),
                SizedBox(height: 1.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      fixedSize: Size(60.w, 2.h),
                      textStyle: TextStore.textTheme.headlineSmall!
                          .copyWith(color: Colors.white),
                      elevation: 6),
                  onPressed: () {
                    // Get.toNamed(Routes.giftCardHistoryScreen,
                    //     preventDuplicates: false,
                    //     arguments: 'TranscationHistory');
                     Get.offAllNamed(Routes.giftCardHistoryScreen,
                         arguments: 'TranscationHistory');
                    // SharedPrefs.instance.setInt('bottomBar', 0);

                  },
                  child: const Text('My Transactions'),
                ),
              ],
            ),
          ),
          titlePadding: const EdgeInsets.all(14),
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
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.5, horizontal: 0.5),
              width: 70.w,
              height: 28.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 14.h, width: 200.w,
                    child: Lottie.asset(ImageAsset.paymentSuccess,
                        fit: BoxFit.contain),
                  ),
                  SizedBox(height: 1.2.h),
                  Text(
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
        );
      },
    );
  }

  failedOrderAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
        );
      },
    );
  }

  failedCouponCodeAlertDialog(context) {
    ShowDialogBox.showAlertDialog(
      content: 'Invalid Coupon Code',
      context: context,
      title: 'Alert',
      //textBackButton: "NO",
      textOkButton: "Back",
      onButtonTapped: () {
        Get.back();
        // Get.offNamed(Routes.loginScreen, arguments: []);
      },
    );
  }

// shareAlertDialog(BuildContext context) {
//   showDialog(
//     barrierDismissible: true,
//     context: context,
//     builder: (BuildContext context) {
//       return WillPopScope(
//         onWillPop: () async => true,
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(5.w)),
//           title:  Text('Gift-card Purchased Successfully',style: TextStore.textTheme.headlineSmall!
//               .copyWith(color: mainColor,fontWeight: FontWeight.bold)),
//           content: SizedBox(
//             width: 85.w,
//             height: 30.h,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 0.2.w, vertical: 2.h),
//               child: Form(
//                 key: shareFormKey,
//                 autovalidateMode: AutovalidateMode.disabled,
//                 child: Column(
//                   children: [
//                   // Wrap(
//                   //   crossAxisAlignment: WrapCrossAlignment.center,
//                   //   children: [
//                   //   Text('Copy and share this code to your loved ones',
//                   //       ),
//                   //   const Icon(Icons.card_giftcard,color: Colors.black,)
//                   //
//                   //
//                   // ],),
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: "Copy and share this code to your loved ones ",
//                               style: TextStore.textTheme.headlineSmall!
//                                        .copyWith(color: Colors.black)
//                           ),
//                           WidgetSpan(
//                             child: Icon(Icons.card_giftcard,color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 1.5.h),
//                     Semantics(
//                       textField: true,
//                       label: 'CouponCodeTextField',
//                       child: AuthTextFromField2(
//                         readOnly: true,
//                         controller: shareCouponCodeController,
//                         obscureText: false,
//                         validator: (value) {
//                         },
//                         labelText: '',
//                         suffixIcon:IconButton(
//                           icon: Icon(Icons.copy,size: 30,color: mainColor),
//                           onPressed: () {
//                             Share.share('I\'m sharing you Velvet Cream Gift coupon with you. \nCoupon code: HGkHKGkBMHFhFyryhfjgfHTFHfhgFTFtFTf \nClick here to redeem the coupon code: https://dipmenu-website-uat.demomywebapp.com/');
//
//                           },
//                         ) ,//NameValues.email,
//                         textInputAction: TextInputAction.done,
//                       ),
//                     ),
//                      SizedBox(height: 2.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ElevatedButton(
//                             onPressed: () {
//                               Get.offAllNamed(Routes.mainScreen, arguments: 3);
//                               SharedPrefs.instance.setInt('bottomBar', 3);
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: mainColor,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(2.w)),
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 2.h, horizontal: 10.w)),
//                             child: const Text('Back to Home',
//                                 style: TextStyle(
//                                     fontSize: 18, color: Colors.white))),
//                       ],
//                     ),
//                     // SizedBox(height: 1.h),
//                     // IconButton(
//                     //   icon: Icon(Icons.copy,size: 30,color: mainColor),
//                     //   onPressed: () {
//                     //     Share.share('I\'m sharing you Velvet Cream Gift coupon with you. \nCoupon code: HGkHKGkBMHFhFyryhfjgfHTFHfhgFTFtFTf \nClick here to redeem the coupon code: https://dipmenu-website-uat.demomywebapp.com/');
//                     //
//                     //   },
//                     // ),
//                     // Text('Share',style: TextStore.textTheme.titleLarge!
//                     //     .copyWith(color: Colors.black)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
}
