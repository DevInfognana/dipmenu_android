import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/core/static/stactic_values.dart';
import 'package:dip_menu/extra/common_widgets/back_button.dart';
import 'package:dip_menu/extra/common_widgets/snack_bar.dart';
import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:dip_menu/presentation/logic/controller/gift_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import '../../../../extra/common_widgets/empty_widget.dart';
import '../../../routes/routes.dart';

class GiftCardHistoryScreen extends StatefulWidget {
  const GiftCardHistoryScreen({Key? key}) : super(key: key);

  @override
  State<GiftCardHistoryScreen> createState() => GiftCardHistoryScreenState();
}

class GiftCardHistoryScreenState extends State<GiftCardHistoryScreen>
    with TickerProviderStateMixin {
  final giftCardController = Get.find<GiftCardController>();

  @override
  void initState() {
    super.initState();
    if (giftCardController.argumentData == 'PurchaseHistory') {
      giftCardController.getGiftList();
    } else {
      giftCardController.getGiftCard();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(Routes.mainScreen, arguments: 3);
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
                leading: AuthBackButton(
                  press: () {
                    Get.offAllNamed(Routes.mainScreen, arguments: 3);
                  },
                ),
                centerTitle: true,
                title: TextScaleFactorClamper(
                    child: AuthTitleText(
                        text:
                            giftCardController.argumentData == 'PurchaseHistory'
                                ? NameValues.purchasedGiftCards
                                : NameValues.myTransactions))),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: GetBuilder<GiftCardController>(builder: (controller) {
              return controller.status.isLoading
                  ? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(color: mainColor),
                    )
                  : TextScaleFactorClamper(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.h),
                        child: giftCardController.argumentData ==
                                'PurchaseHistory'
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: giftCardController
                                        .purchaseListHistory.isNotEmpty
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(width: 2.h),
                                          Flexible(
                                            child: Container(
                                              padding: EdgeInsets.all(0.2.h),
                                              child: ListView.builder(
                                                  itemCount: giftCardController
                                                      .purchaseListHistory
                                                      .length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return showValues(
                                                        context: context,
                                                        amount: giftCardController
                                                            .purchaseListHistory[
                                                                index]
                                                            .amount,
                                                        couponCode:
                                                            giftCardController
                                                                .purchaseListHistory[
                                                                    index]
                                                                .code,
                                                        date: giftCardController
                                                            .dateformate(
                                                                giftCardController
                                                                    .purchaseListHistory[
                                                                        index]
                                                                    .createdAt!));
                                                  }),
                                            ),
                                          ),
                                        ],
                                      )
                                    : emptyWidget(
                                        'Nothing in Purchase History'),
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: giftCardController
                                          .myTransaction.isNotEmpty
                                      ? Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(width: 2.h),
                                            Flexible(
                                              child: Container(
                                                padding: EdgeInsets.all(0.2.h),
                                                child: ListView.builder(
                                                    itemCount:
                                                        giftCardController
                                                            .myTransaction
                                                            .length,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return showValues1(
                                                          context: context,
                                                          amount:
                                                              giftCardController
                                                                  .myTransaction[
                                                                      index]
                                                                  .amount,
                                                          couponCode:
                                                              giftCardController
                                                                  .myTransaction[
                                                                      index]
                                                                  .redeemFlag,
                                                          date: giftCardController
                                                              .dateformate(
                                                                  giftCardController
                                                                      .myTransaction[
                                                                          index]
                                                                      .createdAt!));
                                                    }),
                                              ),
                                            ),
                                          ],
                                        )
                                      : emptyWidget(
                                          'Nothing in Transaction History'),
                                ),
                              ),
                      ),
                    );
            })),
      ),
    );
  }
}

Widget showValues(
    {String? amount,
    String? couponCode,
    String? date,
    required BuildContext context}) {
  return Card(
    elevation: 0,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Padding(
      padding:
          EdgeInsets.only(left: 0.4.h, top: 0.8.w, bottom: 0.8.w, right: 0.4.h),
      child: TextScaleFactorClamper(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      changetext(
                          value1: 'Amount : ',
                          value2: '\$ $amount',
                          colorvalues: mainColor),
                      changetext(
                          value1: 'Coupon Code : ',
                          value2: '$couponCode',
                          colorvalues: descriptionColor),
                      changetext(
                          value1: 'Date : ',
                          value2: date!,
                          colorvalues: descriptionColor)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(
                        ClipboardData(text: couponCode.toString()));
                    showSnackBar('Coupon code copied');
                  },
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                      child: SizedBox(
                          height: 5.h,
                          width: 10.w,
                          child: Center(
                              child: Icon(Icons.copy,
                                  color: Colors.black, size: 6.w))),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final Size size1 = MediaQuery.of(Get.context!).size;
                    Share.share(
                        sharePositionOrigin:
                            Rect.fromLTWH(0, 0, size1.width, size1.height / 2),
                        "I'm sharing a VelvetCream gift coupon with you. \nCoupon code: ${couponCode.toString()} \nClick here to redeem the coupon code: https://dipmenu-website-uat.demomywebapp.com/");
                  },
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                      child: SizedBox(
                          height: 5.h,
                          width: 10.w,
                          child: Center(
                              child: Icon(Icons.share,
                                  color: Colors.black, size: 6.w))),
                    ),
                  ),
                ),
              ],
            ),
            DividerView(values: 0),
          ],
        ),
      ),
    ),
  );
}

changetext({String? value1, String? value2, Color? colorvalues}) {
  Color textColor = Get.isDarkMode ? Colors.white : borderColor;
  return Row(
    children: [
      Text(
        value1!,
        textAlign: TextAlign.left,
        style: Get.context?.theme.textTheme.headlineSmall
            ?.copyWith(color: textColor, fontWeight: FontWeight.w900),
      ),
      Text(value2!,
          textAlign: TextAlign.justify,
          style: Get.context?.theme.textTheme.headlineSmall
              ?.copyWith(color: colorvalues, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget showValues1(
    {String? amount,
    int? couponCode,
    String? date,
    required BuildContext context}) {
  return Card(
    elevation: 0,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: Padding(
      padding:
          EdgeInsets.only(left: 0.4.h, top: 0.8.w, bottom: 0.8.w, right: 0.4.h),
      child: TextScaleFactorClamper(
        child: Column(
          children: [
            changetext(
                value1: 'Amount  : ',
                value2: '\$ $amount',
                colorvalues: mainColor),
            changetext(
                value1: 'Redeem value : ',
                value2: couponCode == 0 ? ' DipWallet' : ' Redeem Code',
                colorvalues: descriptionColor),
            changetext(
                value1: 'Date  : ',
                value2: date!,
                colorvalues: descriptionColor),
            DividerView(values: 0),
          ],
        ),
      ),
    ),
  );
}

