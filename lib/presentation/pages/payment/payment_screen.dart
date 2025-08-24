import 'package:dip_menu/core/config/icon_config.dart';
import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:dip_menu/presentation/logic/controller/payment_controller.dart';
import 'package:dip_menu/presentation/pages/payment/widget/card_month_input_formater.dart';
import 'package:dip_menu/presentation/pages/payment/widget/card_number_validator.dart';
import 'package:dip_menu/presentation/pages/payment/widget/payment_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import '../../../core/config/app_textstyle.dart';
import '../../../core/static/stactic_values.dart';
import '../../../extra/common_widgets/back_button.dart';
import '../../../extra/common_widgets/leading_space_handle.dart';
import '../../routes/routes.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({Key? key}) : super(key: key);
  final paymentController = Get.find<PaymentController>();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
         paymentController.status.isLoading ? value = false : value = true;
         Get.offAllNamed(Routes.cartScreen);
        return value;
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                  leading: const SizedBox(),
                  centerTitle: true,
                  title: TextScaleFactorClamper(child: AuthTitleText(text: NameValues.payment)))),
          resizeToAvoidBottomInset: false,
          backgroundColor: ThemesApp.light.scaffoldBackgroundColor,
          body: TextScaleFactorClamper(
            child: GetBuilder<PaymentController>(
              builder: (controller) {
                return controller.status.isLoading
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(ImageAsset.loadingFailed,
                              height: 40.h,
                              width: 12.w,
                              reverse: true,
                              fit: BoxFit.fill),
                        ],
                      )
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child:
                                Column(mainAxisSize: MainAxisSize.min, children:
                                <Widget>[
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: AuthTitleText(
                                      text: NameValues.paymentMethod)),
                              SizedBox(height: 1.h),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: AuthTitleText(
                                      text: NameValues.creditCardOrDebitCard)),
                              SizedBox(height: 1.h),
                              Form(
                                key: controller.fromKey,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                child: Column(
                                  children: [
                                    paymentTextFromField(
                                      controller: controller.cardNumberController,
                                      labelText: 'Card Number',
                                      obscureText: false,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(16),
                                        CardNumberInputFormatter(),
                                      ],
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please Card Number'.tr;
                                        } else if (value.length < 22) {
                                          return 'Please enter Card Number'.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        if (value.length >= 20) {
                                          controller.cardCheckingApi(value);
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      suffixIcon: controller.cardType != null
                                          ? Padding(
                                              padding: EdgeInsets.all(1.w),
                                              child: Image.asset(
                                                controller.cardType!,
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.all(1.w),
                                              child: Image.asset(
                                                ImageAsset.emptyCardView,
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: paymentTextFromField(
                                        controller: controller.cardNameController,
                                        labelText: 'Full Name',
                                        obscureText: false,
                                        validator: (value) {
                                          if (value.toString().trim().isEmpty) {
                                            return NameValues
                                                .pleaseEnterFullName.tr;
                                          } else if(!ValidationRegex.validCharacters
                                              .hasMatch(value.toString().trim())) {
                                            return NameValues
                                                .pleaseEnterFullName.tr;
                                          }else{
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.name,
                                        textInputAction: TextInputAction.next,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                          // FilteringTextInputFormatter.deny(RegExp(r'\s')),
                                          LengthLimitingTextInputFormatter(35),
                                          NoLeadingSpaceFormatter(),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: paymentTextFromField(
                                            controller:
                                                controller.cardCvvController,
                                            labelText: 'CVC',
                                            obscureText: true,
                                            keyboardType: const TextInputType.numberWithOptions(
                                              decimal: true,
                                              signed: true,
                                            ),
                                            textInputAction: TextInputAction.next,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(4),
                                            ],
                                            validator: (value) {
                                              if (value
                                                  .toString()
                                                  .trim()
                                                  .isEmpty) {
                                                return 'Please CVC Number'.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Expanded(
                                          child: paymentTextFromField(
                                            controller:
                                                controller.cardDateController,
                                            labelText: 'MM/YY',
                                            obscureText: false,
                                            keyboardType: const TextInputType.numberWithOptions(
                                              decimal: true,
                                              signed: true,
                                            ),
                                            textInputAction: TextInputAction.done,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(4),
                                              CardMonthInputFormatter(),
                                              // CreditCardExpirationDateFormatter()
                                            ],
                                            validator: (value) {
                                              if (value!
                                                  .toString()
                                                  .trim()
                                                  .isEmpty) {
                                                return 'Please enter valid date';
                                              }
                                              final DateTime now = DateTime.now();
                                              final List<String> date =
                                                  value.split(RegExp(r'/'));
                                              final int month =
                                                  int.parse(date.first);
                                              final int year =
                                                  int.parse('20${date.last}');
                                              final int lastDayOfMonth = month <
                                                      12
                                                  ? DateTime(year, month + 1, 0)
                                                      .day
                                                  : DateTime(year + 1, 1, 0).day;
                                              final DateTime cardDate = DateTime(
                                                  year,
                                                  month,
                                                  lastDayOfMonth,
                                                  23,
                                                  59,
                                                  59,
                                                  999);

                                              if (cardDate.isBefore(now) ||
                                                  month > 12 ||
                                                  month == 0) {
                                                return 'Please enter valid date';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ])));
              },
            ),
          ),
          bottomNavigationBar: TextScaleFactorClamper(
            child: GetBuilder<PaymentController>(
              builder: (controller) {
                return controller.status.isLoading
                    ? Container(height: 10.h)
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 11.w, vertical: 2.h),
                        child: Container(
                          width: double.infinity,
                          color: ThemesApp.light.scaffoldBackgroundColor,
                          child: ElevatedButton(
                              onPressed: () {
                                // print('cardName:${paymentController.cardNameController.text.trim()}');
                                if (paymentController.fromKey.currentState!
                                    .validate()) {
                                  // controller.cardNameController.text.trim();
                                  paymentController.paymentOrder();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  fixedSize: Size(2.w, 6.h)),
                              child: Text(
                                'Pay \$ ${paymentController.argumentData['Total'].toString()}',
                                style: TextStore.textTheme.headlineMedium!
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                      );
              },
            ),
          )),
    );
  }
}