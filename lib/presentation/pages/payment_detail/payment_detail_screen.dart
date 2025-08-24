import 'package:dip_menu/core/config/theme.dart';
// import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:dip_menu/presentation/logic/controller/payment_detail_controller.dart';
import 'package:dip_menu/presentation/pages/payment_detail/widget/values_show.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../core/config/app_textstyle.dart';
// import '../../../core/static/stactic_values.dart';
import '../../../extra/common_widgets/back_button.dart';
// import '../../../extra/common_widgets/discount_operations.dart';
import '../../logic/controller/controller_Index.dart';

class PaymentDetailScreen extends StatelessWidget {
  PaymentDetailScreen({Key? key}) : super(key: key);

  final paymentDetailController = Get.find<PaymentDetailController>();
  late FocusNode applyCodeFocusNode;
  final numberFormat = NumberFormat("#,##0.00", "en_US");
  bool? isWalletOptionShow;

  sizedBoxValues() {
    return SizedBox(height: 2.h);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
              leading: AuthBackButton(
                press: () {
                  Get.back();
                },
              ),
              centerTitle: true,
              title: TextScaleFactorClamper(
                  child: AuthTitleText(text: NameValues.checkout))),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor:   Theme.of(Get.context!).scaffoldBackgroundColor,
        body: TextScaleFactorClamper(
          child: GetBuilder<PaymentDetailController>(builder: (controller) {
            return controller.status.isError
                ? Container(
                    alignment: Alignment.center,
                    child:
                        Text('Api error - ${controller.status.errorMessage}'))
                : controller.status.isLoading
                    ? Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(color: mainColor))
                    : SingleChildScrollView(
                        reverse: false,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(NameValues.yourOrders,
                                    style: context
                                        .theme.textTheme.displayMedium),
                                  ],
                                ),
                                DividerView(values: 0,colorValues: Colors.grey),
                                Flexible(
                                  child: ListView.builder(
                                      itemCount: controller.cardList.length,
                                      scrollDirection: Axis.vertical,
                                      physics: const ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text(
                                            '${controller.cardList[index].product!.name}',
                                            style:  context
                                                .theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Column(
                                            children: [
                                              /* Text('Prod and reward products',style: TextStyle(color: Colors.black)) else
                                                Text('only reward prod',style: TextStyle(color: Colors.black)),*/
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Qty : ${controller.cardList[index].quantity}',
                                                    style: context
                                                        .theme.textTheme.headlineSmall
                                                  ),
                                                  Text(
                                                    '${controller.cardList[index].sizeDescription}',
                                                    style: context
                                                        .theme.textTheme.titleLarge?.copyWith( color: Colors.grey),
                                                  ),
                                                  if (controller.cardList[index]
                                                          .reward ==
                                                      0)
                                                    Text(
                                                      '\$ ${numberFormat.format(((controller.cardList[index].totalCost! / controller.cardList[index].quantity!) * controller.cardList[index].quantity!))}',
                                                      style: context
                                                          .theme.textTheme.headlineSmall?.copyWith(
                                                        fontWeight:  FontWeight.bold,
                                                      ),
                                                    )
                                                  else
                                                    Text(
                                                      '${(controller.cardList[index].totalCost! / controller.cardList[index].quantity!).round() * controller.cardList[index].quantity!} pts',
                                                      style: context
                                                          .theme.textTheme.headlineSmall?.copyWith(
                                                        fontWeight:  FontWeight.bold,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              controller.cardList[index]
                                                      .itemNames!.isNotEmpty
                                                  ? Row(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            richTextFactor(controller.cardList[index].defaultCustom!,controller.cardList[index].reward!,controller.cardList[index].itemNames)+'  : ${controller.cardList[index].itemNames}',
                                                            style: context
                                                                .theme.textTheme.bodyLarge
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                Text(NameValues.orderTotal,
                                    style: context
                                        .theme.textTheme.displayMedium
                                ),
                                DividerView(values: 0,colorValues: Colors.grey),
                                sizedBoxValues(),
                                rowValues(
                                    value1: 'You will earn',
                                    value2:
                                    '${controller.totalCost.value.round()} pts'),
                                rowValues(
                                    value1: 'Order Subtotal',
                                    value2:
                                        '\$ ${numberFormat.format(controller.totalCost.value)}'),
                                sizedBoxValues(),
                                rowValues(
                                    value1: 'Online Order Savings',
                                    value2:
                                        '\$ ${numberFormat.format(controller.totalAndTaxValue.value*(int.parse(SharedPrefs.instance.getString('discount')!)/100))}'),
                                sizedBoxValues(),
                                //'${controller.totalValue.value.round()} pts'
                                rowValues(
                                    value1: NameValues.rewardPointsPurchasedFor,
                                    value2:
                                        '${controller.rewardValue.value.toInt()} pts'),
                                sizedBoxValues(),
                                rowValues(
                                    value1:
                                        'Sales Tax (${controller.salesTax}%)',
                                    value2:
                                        '\$ ${numberFormat.format(controller.totalCostWithTax.value)}'),
                                sizedBoxValues(),
                                DividerView(values: 0,colorValues: Colors.grey),
                                SizedBox(height: 1.h),
                                rowValues(
                                    value1: 'Total',
                                    value2:
                                        '\$ ${numberFormat.format(controller.totalAndTaxValue.value)}'),
                                // SizedBoxValues(),
                                DividerView(values: 0,colorValues: Colors.grey),

                                // SizedBox(
                                //   height: 10.h,
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text(
                                //         'GiftCard',
                                //         style: TextStore.textTheme.headlineSmall!
                                //             .copyWith(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //       GiftCard(controller: controller)
                                //     ],
                                //   ),
                                // ),
                                // SizedBoxValues(),
                                // divider(),
                                // rowValues(
                                //     value1: NameValues.discount,
                                //     value2:
                                //         '\$ ${numberFormat.format(controller.discountValue.value)}'),

                                // controller.rewardValue.value.toInt()==0 ?
                                // controller.checkBoxValues() : SizedBox(width: 0.01),
                                // Text('dip wallet bal:${controller.cardList.length}-->${controller.walletValue}',
                                //     style: TextStyle(color: Colors.black)),
                                // controller.rewardValue.value.toInt()==0 ?divider(): SizedBox(),

                                if (controller.totalAndTaxValue.value > 0)
                                  Column(
                                    children: [
                                      controller.checkBoxValues(),
                                      DividerView(values: 0,colorValues: Colors.grey),

                                    ],
                                  ),
                                rowValues(
                                    value1: NameValues.finalTotal,
                                    value2:
                                        '\$ ${numberFormat.format(controller.finalTotalValue.value)}'),
                                SizedBox(height: 1.h),
                              ]),
                        ));
          }),
        ),
        bottomNavigationBar:
            GetBuilder<PaymentDetailController>(builder: (controller) {
          return TextScaleFactorClamper(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
              child: ElevatedButton(
                  onPressed: () {
                    //  isTotalValueZero = true;
                    // if(isTotalValueZero == true){
                    //    print('isTotalValueZero:${isTotalValueZero}');
                    //  }
                    // print('check Total val:->${controller.finalTotalValue.value}');
                    //disclaimer
                    if (paymentDetailController.oneTimeShowValues == 1) {
                      if (paymentDetailController.paymentConfirmationValues ==
                          true) {
                        // print("welcome");
                      } else {
                        paymentDetailController.discliamerDialog(context);
                      }
                    } else {
                      paymentDetailController.showAlertDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                      padding: EdgeInsets.symmetric(
                          vertical: 2.h, horizontal: 24.w)),
                  //controller.rewardValue.value.toInt()!=0 &&
                  child: Text(
                      (paymentDetailController.isTotalValueZero! == true)
                          ? NameValues.orderNow
                          : NameValues.proceedToPay,
                      style: TextStore.textTheme.headlineMedium!
                          .copyWith(color: Colors.white))),
            ),
          );
        }),
      ),
    );
  }



  richTextFactor(int defaultValues, int reward, String? names) {
    if (reward == 1) {
      return defaultValues == 0
          ? 'Reward Customized Items '
          : 'Reward Default Items';
    } else {
      return defaultValues == 0
          ? 'Customized Items'
          : (names!.isNotEmpty ? 'Default Items' : '');
    }
  }
}
