import 'package:dip_menu/extra/common_widgets/empty_widget.dart';
import 'package:dip_menu/presentation/pages/cart/widget/cart_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../../extra/common_widgets/snack_bar.dart';
import '../../logic/controller/cart_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final numberFormat = NumberFormat("#,##0.00", "en_US");
  final dynamic isPosMessageVal =
      SharedPrefs.instance.getString("isPosMessageVal");

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.mainScreen);
        Get.delete<CartController>();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(8.h),
                child: AppBar(
                    leading: AuthBackButton(press: () {
                      Get.offAllNamed(Routes.mainScreen);
                      Get.delete<CartController>();
                    }),
                    centerTitle: true,
                    title: TextScaleFactorClamper(
                        child: AuthTitleText(text: NameValues.cart)))),
            body: TextScaleFactorClamper(
              child: GetBuilder<CartController>(builder: (controller) {
                return controller.status.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(ImageAsset.emptyResult,
                              height: 40.h,
                              width: 12.w,
                              reverse: true,
                              fit: BoxFit.fill)
                        ],
                      )
                    : controller.status.isError
                        ? Container(
                            alignment: Alignment.center,
                            child: Text(
                                'Api error - ${controller.status.errorMessage}'))
                        : controller.status.isLoading
                            ? Container(
                                alignment: Alignment.center,
                                child:
                                    CircularProgressIndicator(color: mainColor))
                            : RefreshIndicator(
                                onRefresh: controller.refreshLocalGallery,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.h),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        CartScreenCard(
                                            data: controller.user!.data!,
                                            controller: controller),
                                        controller.user!.data!.isNotEmpty
                                            ? SizedBox(
                                                height: controller.user!.data!
                                                            .length ==
                                                        3
                                                    ? 6.h
                                                    : (controller.user!.data!
                                                                .length ==
                                                            2
                                                        ? 14.h
                                                        : (controller
                                                                    .user!
                                                                    .data!
                                                                    .length ==
                                                                1
                                                            ? 30.h
                                                            : 1.h)))
                                            : Container(),
                                        controller.user!.data!.isNotEmpty
                                            ? SizedBox(
                                                height: 30.h,
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // SizedBox(
                                                    //   width: 200,
                                                    //   height: 200,
                                                    //   child: Card(
                                                    //     elevation: 12,
                                                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                    //     child: Stack(
                                                    //       children: <Widget>[
                                                    //         Positioned(
                                                    //           top: 0,
                                                    //           child: Container(
                                                    //             padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                                    //             decoration: BoxDecoration(
                                                    //                 color: Colors.green,
                                                    //                 borderRadius: BorderRadius.only(
                                                    //                   topLeft: Radius.circular(8),
                                                    //                   bottomRight: Radius.circular(8),
                                                    //                 ) // green shaped
                                                    //             ),
                                                    //             child: Text("CHOCOLATE"),
                                                    //           ),
                                                    //         )
                                                    //       ],
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    // Container(
                                                    //   child:   ,
                                                    //   padding:EdgeInsets.all(1.w),
                                                    //   decoration: BoxDecoration(
                                                    //     borderRadius: BorderRadius.circular(10),
                                                    //     color: Colors.white,
                                                    //     boxShadow: const [
                                                    //       BoxShadow(color: Colors.black, spreadRadius: 1),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    rowValuesDifferent1(
                                                        values1:
                                                            'Reward Points Earned',
                                                        values2:
                                                            '${controller.totalValue.value.round()} pts',
                                                        controller1: controller
                                                            .tipController,
                                                        cartController1:
                                                            controller,
                                                        colorValues:
                                                            Colors.lightBlue),
                                                    SizedBox(height: 1.h),
                                                    rowValues(
                                                        values1:
                                                            'Order Subtotal',
                                                        values2:
                                                            '\$ ${numberFormat.format(controller.totalValue.value)}'),
                                                    SizedBox(height: 1.h),
                                                    rowValuesDifferent(
                                                        values1:
                                                            'Online Order Savings',
                                                        values2:
                                                            '\$ ${numberFormat.format(controller.onineOrderSavingValue.value)}',
                                                        controller1: controller
                                                            .tipController1,
                                                        cartController1:
                                                            controller,
                                                        colorValues:
                                                            Colors.green),
                                                    SizedBox(height: 1.h),
                                                    controller.isRewardProducts ==
                                                            true
                                                        ? rowValues(
                                                            values1: NameValues
                                                                .rewardPointsPurchasedFor,
                                                            values2:
                                                                '${controller.rewardPointValue.toInt()} pts')
                                                        : const SizedBox(),
                                                    SizedBox(height: 1.h),
                                                    rowValues(
                                                        values1:
                                                            'Sales Tax (${controller.taxValueData?.datas?.response?[0].tax ?? ''}%)',
                                                        values2:
                                                            '\$ ${numberFormat.format(controller.taxValue.value)}'),
                                                    SizedBox(height: 1.h),
                                                    rowValues(
                                                        values1: 'Total',
                                                        values2:
                                                            '\$ ${numberFormat.format(controller.totalAndTaxValue.value)}')
                                                  ],
                                                ),
                                              )
                                            : emptyWidget('empty Cart'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
              }),
            ),
            bottomNavigationBar: TextScaleFactorClamper(
              child: GetBuilder<CartController>(builder: (controller) {
                return controller.status.isEmpty
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 2.w),
                        child: ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed(Routes.mainScreen, arguments: 0);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.w)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 24.w)),
                            child: Text(
                              NameValues.browseProduct,
                              style: context.theme.textTheme.headlineMedium!
                                  .copyWith(color: Colors.white),
                            )))
                    : (controller.posValues == true
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.h, vertical: 2.w),
                            child: ElevatedButton(
                                onPressed: () {
                                  int? tempvalues = SharedPrefs.instance.getInt('rewards') ?? 0;
                                  RxDouble rewardsValues =
                                      RxDouble(tempvalues.toDouble());
                                  if (SharedPrefs.instance.getString('token') ==
                                      null) {
                                    showAlertDialog(context);
                                  } else if (cartController
                                      .user!.data!.isEmpty) {
                                    showSnackBar("Cart Empty");
                                  } else if (rewardsValues <
                                      cartController.rewardPointValue
                                          .toDouble()) {
                                    dismissAlertDialog(context);
                                  } else {
                                    Get.toNamed(Routes.paymentDetailScreen,
                                        arguments: controller.user!.data);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.w)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 24.w)),
                                child: Text(NameValues.checkout,
                                    style: context.theme.textTheme.headlineMedium!
                                        .copyWith(color: Colors.white))))
                        : Padding(
                            padding: EdgeInsets.all(0.8.h),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(controller.posMessageValues,
                                        style: context.theme.textTheme.titleLarge!
                                            .copyWith(color: Colors.red)))
                              ],
                            ),
                          ));

                // return Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   child: ElevatedButton(
                //       onPressed: () {
                //
                //         // int? tempvalues =
                //         // SharedPrefs.instance.getInt('rewards') == null
                //         //     ? 0
                //         //     : SharedPrefs.instance.getInt('rewards');
                //         // RxDouble rewardsValues = RxDouble(tempvalues!.toDouble());
                //         // if (SharedPrefs.instance.getString('token') == null) {
                //         //   showAlertDialog(context);
                //         // } else if (cartController.user!.data!.isEmpty) {
                //         //   showSnackBar("Cart Empty");
                //         // } else if (rewardsValues <
                //         //     cartController.rewardPointValue.toDouble()) {
                //         //   DismissAlertDialog(context);
                //         // } else {
                //         //   Get.toNamed(Routes.paymentDetailScreen,
                //         //       arguments: controller.user!.data);
                //         // }
                //       },
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor: mainColor,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(18),
                //           ),
                //           padding: EdgeInsets.symmetric(
                //               vertical: 2.h, horizontal: 24.w)),
                //       child: const Text(
                //         'Check out',
                //         style: TextStyle(fontSize: 18, color: Colors.white),
                //       )),
                // );
              }),
            )),
      ),
    );
  }

  rowValues({String? values1, String? values2}) {
    Color? color = Get.isDarkMode ? Colors.white : Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(values1!,
            style: TextStore.textTheme.headlineMedium!
                .copyWith(color: color, fontWeight: FontWeight.w600)),
        Text(values2!,
            style: TextStore.textTheme.headlineMedium!
                .copyWith(color: color, fontWeight: FontWeight.w600)),
      ],
    );
  }

  rowValuesDifferent(
      {String? values1,
      String? values2,
      Color? colorValues,
      SuperTooltipController? controller1,
      CartController? cartController1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SuperTooltip(
          controller: controller1,
          hasShadow: false,
          content: const Text(
            "The Sample Text",
            softWrap: true,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          onShow: () {
            cartController1!.closeTooltip();
          },
          popupDirection: TooltipDirection.up,
          barrierColor: Colors.transparent,
          child: Text(values1!,
              style: TextStore.textTheme.headlineMedium!
                  .copyWith(color: colorValues, fontWeight: FontWeight.bold)),
        ),
        // Text(values1!,
        //     style: TextStore.textTheme.headlineMedium!
        //         .copyWith(color: colorValues, fontWeight: FontWeight.bold)),
        Text(values2!,
            style: TextStore.textTheme.headlineMedium!
                .copyWith(color: colorValues, fontWeight: FontWeight.bold)),
      ],
    );
  }

  rowValuesDifferent1(
      {String? values1,
      String? values2,
      Color? colorValues,
      SuperTooltipController? controller1,
      CartController? cartController1}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FittedBox(
          child: SizedBox(
            child: Image.asset(ImageAsset.giftImage, height: 5.h, width: 9.w,fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 1.w),
        SuperTooltip(
          controller: controller1,
          hasShadow: false,
          content:  Text(
            "The reward points depend on the value of your orders.",
            softWrap: true,
            style: TextStyle(
              color:Get.isDarkMode? Colors.white:Colors.black,
            ),
          ),
          onShow: () {
            cartController1!.closeTooltip();
          },
          popupDirection: TooltipDirection.up,
          barrierColor: Colors.transparent,
          child: Text(values1!,
              style: TextStore.textTheme.headlineMedium!
                  .copyWith(color: colorValues, fontWeight: FontWeight.bold)),
        ),
        const Spacer(),
        Text(values2!,
            style: TextStore.textTheme.headlineMedium!
                .copyWith(color: colorValues, fontWeight: FontWeight.bold)),
      ],
    );
  }

  showAlertDialog(context) {
    ShowDialogBox.showAlertDialog(
      content:
          'Please log in to the application before proceeding to the checkout.',
      context: context,
      title: 'Log in !',
      textBackButton: "NO",
      textOkButton: "Yes",
      onButtonTapped: () {
        Get.offNamed(Routes.loginScreen, arguments: []);
      },
    );
  }

  dismissAlertDialog(context) {
    ShowDialogBox.alertDialogBox(
      content: 'Insufficient Reward Points',
      context: context,
      title: 'Alert',
      textOkButton: "Back",
      cartScreen: 0,
      categoryId: 0,
      onButtonTapped: () {
        Get.back();
      },
    );
  }
}
