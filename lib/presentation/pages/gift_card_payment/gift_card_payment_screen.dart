import 'dart:collection';

import 'package:dip_menu/extra/common_widgets/leading_space_handle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../core/config/app_textstyle.dart';
import '../../../core/config/icon_config.dart';
import '../../../core/config/theme.dart';
import '../../../core/static/stactic_values.dart';
import '../../../extra/common_widgets/back_button.dart';
import '../../logic/controller/gift_card_payment_controller.dart';
import '../payment/widget/card_month_input_formater.dart';
import '../payment/widget/card_number_validator.dart';
import '../payment/widget/payment_textfiled.dart';

// ignore: must_be_immutable
class GiftPaymentScreen extends StatelessWidget {
  GiftPaymentScreen({Key? key}) : super(key: key);
  final paymentController = Get.find<GiftCardPaymentController>();
  final numberFormat = NumberFormat("#,##0.00", "en_US");
  final GlobalKey expansionTileKey = GlobalKey();

  bool value = false;
  InAppWebViewController? webViewController;
  ContextMenu? contextMenu;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        paymentController.status.isLoading ? value = false : value = true;
        Get.back();
        return value;
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: AppBar(
                  leading: const SizedBox(),
                  centerTitle: true,
                  title: AuthTitleText(text: NameValues.payment))),
          resizeToAvoidBottomInset: false,
          backgroundColor: ThemesApp.light.scaffoldBackgroundColor,
          body: GetBuilder<GiftCardPaymentController>(
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
                              Column(mainAxisSize: MainAxisSize.min, children: <
                                  Widget>[
                            Align(
                                alignment: Alignment.topLeft,
                                child: AuthTitleText(
                                    text: NameValues.paymentMethod)),
                            SizedBox(height: 1.h),
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.grey,
                                // here for close state
                                colorScheme: ColorScheme.light(
                                  primary: mainColor,
                                ),
                                dividerColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                title: AuthTitleText(
                                    text: NameValues.creditCardOrDebitCard),
                                children: [
                                  SizedBox(height: 1.h),
                                  Form(
                                    key: controller.fromKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Column(
                                      children: [
                                        paymentTextFromField(
                                          controller:
                                              controller.cardNumberController,
                                          labelText: 'Card Number',
                                          obscureText: false,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                                16),
                                            CardNumberInputFormatter(),
                                          ],
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please Card Number'.tr;
                                            } else if (value.length < 22) {
                                              return 'Please enter Card Number'
                                                  .tr;
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
                                          suffixIcon: controller.cardType !=
                                                  null
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
                                            controller:
                                                controller.cardNameController,
                                            labelText: 'Full Name',
                                            obscureText: false,
                                            validator: (value) {
                                              if (value
                                                      .toString()
                                                      .trim()
                                                      .isEmpty ||
                                                  !ValidationRegex
                                                      .validCharacters
                                                      .hasMatch(value)) {
                                                return NameValues
                                                    .pleaseEnterFullName.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.next,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                              NoLeadingSpaceFormatter(),
                                              LengthLimitingTextInputFormatter(35),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: paymentTextFromField(
                                                controller: controller
                                                    .cardCvvController,
                                                labelText: 'CVC',
                                                obscureText: true,
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                  decimal: true,
                                                  signed: true,
                                                ),
                                                textInputAction:
                                                    TextInputAction.next,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      4),
                                                ],
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .trim()
                                                      .isEmpty) {
                                                    return 'Please CVC Number'
                                                        .tr;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 4.w),
                                            Expanded(
                                              child: paymentTextFromField(
                                                controller: controller
                                                    .cardDateController,
                                                labelText: 'MM/YY',
                                                obscureText: false,
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                  decimal: true,
                                                  signed: true,
                                                ),
                                                textInputAction:
                                                    TextInputAction.done,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  LengthLimitingTextInputFormatter(
                                                      4),
                                                  CardMonthInputFormatter()
                                                ],
                                                validator: (value) {
                                                  if (value!
                                                      .toString()
                                                      .trim()
                                                      .isEmpty) {
                                                    return 'Please enter valid date';
                                                  }
                                                  final DateTime now =
                                                      DateTime.now();
                                                  final List<String> date =
                                                      value.split(RegExp(r'/'));
                                                  final int month =
                                                      int.parse(date.first);
                                                  final int year = int.parse(
                                                      '20${date.last}');
                                                  final int lastDayOfMonth =
                                                      month < 12
                                                          ? DateTime(year,
                                                                  month + 1, 0)
                                                              .day
                                                          : DateTime(year + 1,
                                                                  1, 0)
                                                              .day;
                                                  final DateTime cardDate =
                                                      DateTime(
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
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.grey,
                                // here for close state
                                colorScheme: ColorScheme.light(
                                  primary: mainColor,
                                ),
                                dividerColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                onExpansionChanged: (values) {},
                                title: AuthTitleText(text: NameValues.gPay),
                                children: [
                                  SizedBox(
                                    height: 90.h,
                                    width: MediaQuery.of(context).size.width,
                                    child: InAppWebView(

                                      initialUrlRequest: URLRequest(
                                          // url: Uri.parse(
                                          //     paymentController.paymentUrl!)),
                                          url: WebUri(paymentController.paymentUrl!)),
                                      initialUserScripts:
                                          UnmodifiableListView<UserScript>([]),
                                      contextMenu: contextMenu,
                                      initialOptions: InAppWebViewGroupOptions(
                                        crossPlatform: InAppWebViewOptions(
                                          clearCache: true,
                                          javaScriptCanOpenWindowsAutomatically: true, // I thought this will help, but not working
                                          mediaPlaybackRequiresUserGesture: false,
                                        ),
                                        android: AndroidInAppWebViewOptions(supportMultipleWindows: true),
                                        ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
                                      ),
                                      onWebViewCreated: (controller) async {
                                        controller = controller;
                                        controller.clearCache();
                                        webViewController = controller;
                                      },
                                      onCreateWindow: (controller, createWindowRequest) async {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: 400,
                                                child: InAppWebView(
                                                  // Setting the windowId property is important here!
                                                  windowId: createWindowRequest.windowId,
                                                  initialOptions: InAppWebViewGroupOptions(
                                                    crossPlatform: InAppWebViewOptions(
                                                    
                                                    ),
                                                  ),
                                                  // onWebViewCreated: (InAppWebViewController controller) {
                                                  //   _webViewPopupController = controller;
                                                  // },
                                                  // onLoadStart: (InAppWebViewController controller, String url) {
                                                  //   print("onLoadStart popup $url");
                                                  // },
                                                  // onLoadStop: (InAppWebViewController controller, String url) {
                                                  //   print("onLoadStop popup $url");
                                                  // },
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                        return true;
                                      },

                                      shouldOverrideUrlLoading:
                                          (controller, navigationAction) async {
                                        var uri = navigationAction.request.url!;
                                        if (![
                                          "http",
                                          "https",
                                          "file",
                                          "chrome",
                                          "data",
                                          "javascript",
                                          "about",
                                          "ch-ua-form-factor"
                                        ].contains(uri.scheme)) {}
                                    return NavigationActionPolicy.ALLOW;
                                      },
                                      onLoadStart: (controller, url) async {
                                        // print('loading values ---->${controller.android}');

                                      },
                                      onLoadStop: (controller, url) async {
                                        // print('loading stop ---->${controller.android}');
                                      },
                                      onConsoleMessage:
                                          (controller, consoleMessage) {
                                        // print('message ---->$consoleMessage');
                                        // print(consoleMessage);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            // SizedBox(height: 1.h),
                            // Align(
                            //     alignment: Alignment.topLeft,
                            //     child: AuthTitleText(
                            //         text: NameValues.creditCardOrDebitCard)),
                            // SizedBox(height: 1.h),
                          ])));
            },
          ),
          bottomNavigationBar: GetBuilder<GiftCardPaymentController>(
            builder: (controller) {
              return controller.status.isLoading
                  ? SizedBox(height: 10.h)
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 11.w, vertical: 2.h),
                      child: Container(
                        width: double.infinity,
                        color: ThemesApp.light.scaffoldBackgroundColor,
                        child: ElevatedButton(
                            onPressed: () {
                              if (paymentController.fromKey.currentState!
                                  .validate()) {
                                paymentController.paymentAPi();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                fixedSize: Size(2.w, 6.h)),
                            child: Text(
                              'Pay  \$${numberFormat.format(double.parse(paymentController.giftCardAmount!))}',
                              style: TextStore.textTheme.headlineMedium!
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                    );
            },
          )),
    );
  }
}
