import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/core/static/stactic_values.dart';
import 'package:dip_menu/extra/common_widgets/back_button.dart';
// import 'package:dip_menu/extra/common_widgets/text_form_field_2.dart';
import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:dip_menu/presentation/logic/controller/gift_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_textstyle.dart';
import '../../../../domain/local_handler/Local_handler.dart';
import '../../../../extra/common_widgets/text_form_field.dart';
import '../../../routes/routes.dart';

class GiftCardScreen extends StatefulWidget {
  const GiftCardScreen({Key? key}) : super(key: key);

  @override
  State<GiftCardScreen> createState() => _GiftCardScreenState();
}

class _GiftCardScreenState extends State<GiftCardScreen>
    with TickerProviderStateMixin {
  // final giftCardController = Get.put(GiftCardController());
  final giftCardController = Get.find<GiftCardController>();
  late TabController tabController;
  String? userEmail = SharedPrefs.instance.getString('Email');

  // bool couponCodeValue = false;

  @override
  void initState() {
    super.initState();
    giftCardController.emailTextController1.text =
        SharedPrefs.instance.getString('Email')!;
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void clearText() {
    giftCardController.couponCodeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: AuthBackButton(
                press: () {
                  Get.back();
                },
              ),
              centerTitle: true,
              title: TextScaleFactorClamper(
                  child: AuthTitleText(text: NameValues.giftCard))),
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: TextScaleFactorClamper(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25.0)),
                      child: TabBar(
                        controller: tabController,
                        onTap: (value) {
                          if (value == 0) {
                            giftCardController.buyGiftCardFromKey.currentState!
                                .reset();
                          } else if (value == 1) {
                            giftCardController.redeemCodeFromKey.currentState!
                                .reset();
                          } else {
                            giftCardController.topUpWalletFromKey.currentState!
                                .reset();
                          }
                        },
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.redAccent[100]),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        labelPadding: EdgeInsets.symmetric(horizontal: 1.2.w),
                        tabs: const [
                          Tab(text: 'Buy Gift Card'),
                          Tab(text: 'Redeem Code'),
                          Tab(text: 'Dip Wallet'),
                        ],
                      ),
                    ),
                    Expanded(
                        child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 1.5.h),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Form(
                              key: giftCardController.buyGiftCardFromKey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(0.1.h),
                                    height: 26.h,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage("assets/giftcard.png"),
                                      ),
                                    ),
                                  ),
                                  Text('Buy Gift Card',
                                      textAlign: TextAlign.center,
                                      style: TextStore.textTheme.displaySmall!
                                          .copyWith(
                                              color: descriptionColor,
                                              fontWeight: FontWeight.w300)),
                                  SizedBox(height: 2.h),
                                  // AuthTextFromField2(
                                  //   readOnly: false,
                                  //   controller:
                                  //       giftCardController.emailTextController,
                                  //   obscureText: false,
                                  //   validator: (value) {
                                  //     if (value.toString().trim().isEmpty) {
                                  //       return NameValues.pleaseEnterEmail.tr;
                                  //     } else if (!RegExp(
                                  //             ValidationRegex.validationEmail)
                                  //         .hasMatch(value)) {
                                  //       return NameValues
                                  //           .pleaseEnterValidEmail.tr;
                                  //     } else if (value.toString().trim() ==
                                  //         SharedPrefs.instance
                                  //             .getString('Email')) {
                                  //       return NameValues.pleaseUseDipWallet.tr;
                                  //     } else {
                                  //       return null;
                                  //     }
                                  //   },
                                  //   labelText: NameValues.email,
                                  //   textInputAction: TextInputAction.next,
                                  // ),
                                  SizedBox(height: 3.h),
                                  AuthTextFromField(
                                    readOnly: false,
                                    labelStyle: context
                                        .theme.textTheme.headlineMedium!
                                        .copyWith(
                                            color: hintColor,
                                            fontWeight: FontWeight.w500),
                                    controller:
                                        giftCardController.amountController,
                                    obscureText: false,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"),
                                      ),
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    validator: (value) {
                                      if (value.toString().trim().isEmpty) {
                                        return NameValues.pleaseEnterAmount.tr;
                                      } else if (double.parse(value)
                                          .isLowerThan(0.9)) {
                                        return NameValues
                                            .pleaseEnterValidAmount.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    labelText: NameValues.amount,
                                    textInputAction: TextInputAction.next,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: false, signed: true),
                                  ),
                                  SizedBox(height: 3.h),
                                  AuthTextFromField(
                                    readOnly: false,
                                    controller:
                                        giftCardController.messageController,
                                    labelStyle: context
                                        .theme.textTheme.headlineMedium!
                                        .copyWith(
                                        color: hintColor,
                                        fontWeight: FontWeight.w500),

                                    obscureText: false,
                                    validator: (value) {},
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(100),
                                    ],
                                    labelText: NameValues.message,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.1.w, vertical: 4.h),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (giftCardController
                                                .buyGiftCardFromKey
                                                .currentState!
                                                .validate()) {
                                              Map value = {
                                                'email': giftCardController
                                                    .emailTextController.text
                                                    .toString(),
                                                'points': giftCardController
                                                    .amountController.text
                                                    .toString(),
                                                'message': giftCardController
                                                    .messageController.text
                                                    .toString(),
                                                'view': 'buyGiftCard'
                                              };
                                              // print('values$value');
                                              Get.toNamed(
                                                  Routes.googlePaymentScreen,
                                                  arguments: value);
                                            }
                                            // Get.offAllNamed(Routes.mainScreen);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: mainColor,

                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3.w)),
                                            fixedSize: Size(90.w, 6.h),
                                            // fixedSize: Size(2.w, 6.h)
                                          ),
                                          child: Text(
                                            NameValues.proceedToPay,
                                            style: TextStore
                                                .textTheme.headlineMedium!
                                                .copyWith(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<GiftCardController>(builder: (controller) {
                          return controller.status.isError
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'Api error - ${controller.status.errorMessage}'),
                                )
                              : controller.status.isLoading
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(
                                          color: mainColor),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.all(3.h),
                                      child: SingleChildScrollView(
                                        physics: const ScrollPhysics(),
                                        child: Form(
                                          key: giftCardController
                                              .redeemCodeFromKey,
                                          autovalidateMode:
                                              AutovalidateMode.disabled,
                                          child: Column(
                                            children: [
                                              Text('Redeem Code',
                                                  textAlign: TextAlign.center,
                                                  style: TextStore
                                                      .textTheme.displaySmall!
                                                      .copyWith(
                                                          color:
                                                              descriptionColor,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                              SizedBox(height: 2.h),
                                              AuthTextFromField(
                                                readOnly: false,
                                                controller: giftCardController
                                                    .couponCodeController,
                                                labelStyle: context
                                                    .theme.textTheme.headlineMedium!
                                                    .copyWith(
                                                    color: hintColor,
                                                    fontWeight: FontWeight.w500),
                                                obscureText: false,
                                                validator: (value) {
                                                  if (value
                                                      .toString()
                                                      .trim()
                                                      .isEmpty) {
                                                    giftCardController.change(
                                                        giftCardController
                                                                .couponCodeValue =
                                                            true);
                                                    return NameValues
                                                        .pleaseEnterCode.tr;
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      16),
                                                ],
                                                labelText:
                                                    NameValues.couponCode,
                                                textInputAction:
                                                    TextInputAction.done,
                                              ),
                                              giftCardController
                                                          .couponCodeValue ==
                                                      false
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                          SizedBox(
                                                              height: 3.h,
                                                              width: 2.w),
                                                          Text(
                                                            'Invalid gift card',
                                                            style: TextStyle(
                                                                color:
                                                                    mainColor),
                                                          )
                                                        ])
                                                  : const SizedBox(height: 0),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0.1.w,
                                                    vertical: 4.h),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        if (giftCardController
                                                            .redeemCodeFromKey
                                                            .currentState!
                                                            .validate()) {
                                                          giftCardController
                                                              .checkCouponCode();
                                                        }
                                                        setState(() {
                                                          giftCardController
                                                              .couponCodeController
                                                              .clear();
                                                        });
                                                      },
                                                      style: ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              mainColor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3.w)),
                                                          fixedSize:
                                                              Size(90.w, 6.h)),
                                                      child: Text(
                                                        'Redeem',
                                                        style: TextStore
                                                            .textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                                color: Colors
                                                                    .white),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                        }),
                        Padding(
                          padding: EdgeInsets.all(3.h),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Form(
                              key: giftCardController.topUpWalletFromKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Column(
                                children: [
                                  Text('Topup Wallet',
                                      textAlign: TextAlign.center,
                                      style: TextStore.textTheme.displaySmall!
                                          .copyWith(
                                              color: descriptionColor,
                                              fontWeight: FontWeight.w300)),
                                  SizedBox(height: 2.h),
                                  AuthTextFromField(
                                    readOnly: true,
                                    labelStyle: context
                                        .theme.textTheme.headlineMedium!
                                        .copyWith(
                                        color: hintColor,
                                        fontWeight: FontWeight.w500),
                                    controller:
                                        giftCardController.emailTextController1,
                                    obscureText: false,
                                    validator: (value) {
                                      if (value.toString().trim().isEmpty) {
                                        return NameValues.pleaseEnterEmail.tr;
                                      } else if (!RegExp(
                                              ValidationRegex.validationEmail)
                                          .hasMatch(value)) {
                                        return NameValues
                                            .pleaseEnterValidEmail.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    labelText: NameValues.email,
                                    textInputAction: TextInputAction.next,
                                  ),
                                  SizedBox(height: 5.h),
                                  AuthTextFromField(
                                    readOnly: false,
                                    controller:
                                        giftCardController.amountController1,
                                    labelStyle: context
                                        .theme.textTheme.headlineMedium!
                                        .copyWith(
                                        color: hintColor,
                                        fontWeight: FontWeight.w500),
                                    obscureText: false,
                                    inputFormatters: <TextInputFormatter>[
                                      //FilteringTextInputFormatter.digitsOnly,
                                      FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]"),
                                      ),
                                      LengthLimitingTextInputFormatter(5),
                                    ],
                                    validator: (value) {
                                      if (value.toString().trim().isEmpty) {
                                        return NameValues.pleaseEnterAmount.tr;
                                      } else if (double.parse(value)
                                          .isLowerThan(0.9)) {
                                        return NameValues
                                            .pleaseEnterValidAmount.tr;
                                      } else {
                                        return null;
                                      }
                                    },
                                    labelText: NameValues.amount,
                                    textInputAction: TextInputAction.done,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      decimal: false,
                                      signed: true,
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.1.w, vertical: 4.h),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (giftCardController
                                                .topUpWalletFromKey
                                                .currentState!
                                                .validate()) {
                                              Map value = {
                                                'email': giftCardController
                                                    .emailTextController1.text
                                                    .toString(),
                                                'points': giftCardController
                                                    .amountController1.text
                                                    .toString(),
                                                'message': giftCardController
                                                    .messageController.text
                                                    .toString(),
                                                'view': 'TopUpWallet'
                                              };
                                              // print('values$value');
                                              Get.toNamed(
                                                  Routes.googlePaymentScreen,
                                                  arguments: value);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: mainColor,
                                              fixedSize: Size(90.w, 6.h),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.w))),
                                          child: Text(
                                            NameValues.proceedToPay,
                                            style: TextStore
                                                .textTheme.headlineMedium!
                                                .copyWith(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          )
          /* Padding(
          padding: EdgeInsets.symmetric(horizontal:  2.h),
          child: SizedBox(
              height: 120.h,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                SizedBox(height: 1.h),
                DefaultTabController(
                  length: 3,
                  child: Container(
                    height: 6.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        //color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25.0)),
                    child: TabBar(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        unselectedLabelColor: Colors.red,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.red),
                        onTap: (value){
                          giftCardController.amountController.clear();
                          giftCardController.emailTextController.clear();
                          giftCardController.messageController.clear();
                          giftCardController.couponCodeController.clear();
                          giftCardController.amountController1.clear();
                        },
                        tabs: [
                          Tab(

                            text: 'Buy Gift Card',
                            // child: Container(
                            //   width: 60.w,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(50),
                            //       border:
                            //           Border.all(color: Colors.red, width: 1)),
                            //   child: const Align(
                            //     alignment: Alignment.center,
                            //     child: Text("Buy Gift Card",
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.w700,
                            //         )),
                            //   ),
                            // ),
                          ),
                          Tab(
                            child: Container(
                              width: 60.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: Colors.red, width: 1)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Redeem Code",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              width: 60.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: Colors.red, width: 1)),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(" Dip Wallet ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Form(
                          key: giftCardController.buyGiftCardFromKey,
                          // autovalidateMode: AutovalidateMode.,
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(0.1.h),
                                  height: 26.h, //width: 110.w,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("assets/giftcard.png"),
                                    ),
                                  ),
                                 // decoration: BoxDecoration(),
                              //    child: Image.asset('assets/giftcard.png',fit: BoxFit.cover,)
                              ),
                              Text('Buy Gift Card',
                                  textAlign: TextAlign.center,
                                  style: TextStore.textTheme.displaySmall!
                                      .copyWith(
                                          color: descriptionColor,
                                          fontWeight: FontWeight.w300)),
                              SizedBox(height: 2.h),
                              AuthTextFromField2(
                                readOnly: false,
                                controller:
                                    giftCardController.emailTextController,
                                obscureText: false,
                                validator: (value) {
                                  if (value.toString().trim().isEmpty) {
                                    return NameValues.pleaseEnterEmail.tr;
                                  } else if (!RegExp(
                                          ValidationRegex.validationEmail)
                                      .hasMatch(value)) {
                                    return NameValues.pleaseEnterValidEmail.tr;
                                  } else if (value == SharedPrefs.instance.getString('Email')) {
                                    return NameValues.pleaseUseDipWallet.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                labelText: NameValues.email,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 3.h),
                              AuthTextFromField2(
                                readOnly: false,
                                controller: giftCardController.amountController,
                                obscureText: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                validator: (value) {
                                  if (value.toString().trim().isEmpty) {
                                    return NameValues.pleaseEnterAmount.tr;
                                  } else if (double.parse(value).isLowerThan(0.9)) {
                                    return NameValues.pleaseEnterValidAmount.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                labelText: NameValues.amount,
                                textInputAction: TextInputAction.next,
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: true,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              AuthTextFromField2(
                                readOnly: false,
                                controller: giftCardController.messageController,
                                obscureText: false,
                                validator: (value) {},

                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(100),
                                ],
                                labelText: NameValues.message,
                                textInputAction: TextInputAction.done,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if(giftCardController.buyGiftCardFromKey.currentState!.validate()){
                                        Map value = {
                                          'email': giftCardController.emailTextController.text.toString(),
                                          'points': giftCardController.amountController.text.toString(),
                                          'message':giftCardController.messageController.text.toString(),
                                          'view':'buyGiftCard'
                                        };
                                        print('values$value');
                                        Get.toNamed(Routes.giftCardPaymentScreen, arguments: value);
                                      }
                                      // Get.offAllNamed(Routes.mainScreen);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.w),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 24.w)),
                                    child: Text(NameValues.proceedToPay,
                                        style: TextStore.textTheme.displaySmall!
                                            .copyWith(color: Colors.white))
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.h),
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Form(
                          key: giftCardController.redeemCodeFromKey,
                          // autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              Text('Redeem Code',
                                  textAlign: TextAlign.center,
                                  style: TextStore.textTheme.displaySmall!
                                      .copyWith(
                                          color: descriptionColor,
                                          fontWeight: FontWeight.w300)),
                              SizedBox(height: 2.h),
                              AuthTextFromField2(
                                readOnly: false,
                                controller: giftCardController.couponCodeController,
                                obscureText: false,
                                validator: (value) {
                                  if (value.toString().trim().isEmpty) {
                                    return NameValues.pleaseEnterCode.tr;
                                  }  else {
                                    return null;
                                  }
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                labelText: NameValues.couponCode,
                                textInputAction: TextInputAction.done,
                              ),
                             */ /*  giftCardController.status == 'false' ?
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children:[
                                    SizedBox(width: 1.5.w),
                                    Text('Invlid gift card',
                                      style: TextStyle(color: mainColor),)
                                      ]
                              )    :
                               const SizedBox(height: 0),*/ /*
                              Padding(
                                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if(giftCardController.redeemCodeFromKey.currentState!.validate()){
                                        giftCardController.addWalletValues();
                                        if(giftCardController.status != 'true'){
                                          showSnackBar('Invalid gift card');
                                          //print(giftCardController.value);
                                        }
                                        //giftCardController.failedCouponCodeAlertDialog(context);
                                      }
                                      // Get.offAllNamed(Routes.mainScreen);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.w),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 30.w)),
                                    child: Text(
                                      'Redeem',style: TextStore.textTheme.displaySmall!
                                        .copyWith(color: Colors.white),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(3.h),
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Form(
                          key: giftCardController.topUpWalletFromKey,
                          // autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              Text('Topup Wallet',
                                  textAlign: TextAlign.center,
                                  style: TextStore.textTheme.headlineMedium!
                                      .copyWith(
                                          color: descriptionColor,
                                          fontWeight: FontWeight.w300)),
                              SizedBox(height: 2.h),
                              AuthTextFromField2(
                                readOnly: true,
                                controller: giftCardController.emailTextController1,
                                obscureText: false,
                                validator: (value) {
                                  if (value.toString().trim().isEmpty) {
                                    return NameValues.pleaseEnterEmail.tr;
                                  } else if (!RegExp(
                                      ValidationRegex.validationEmail)
                                      .hasMatch(value)) {
                                    return NameValues.pleaseEnterValidEmail.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                labelText: NameValues.email,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(height: 5.h),
                              AuthTextFromField2(
                                readOnly: false,
                                controller: giftCardController.amountController1,
                                obscureText: false,
                                validator: (value) {
                                  if (value.toString().trim().isEmpty) {
                                    return NameValues.pleaseEnterAmount.tr;
                                  } else if (double.parse(value).isLowerThan(0.9)) {
                                    return NameValues.pleaseEnterValidAmount.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                labelText: NameValues.amount,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                textInputAction: TextInputAction.done,
                                keyboardType: const TextInputType.numberWithOptions(
                                  decimal: true,
                                  signed: true,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                                child: ElevatedButton(
                                    onPressed: () {
                                      if(giftCardController.topUpWalletFromKey.currentState!.validate()){
                                        Map value = {
                                          'email': giftCardController.emailTextController1.text.toString(),
                                          'points': giftCardController.amountController1.text.toString(),
                                          'message':giftCardController.messageController.text.toString(),
                                          'view':'TopUpWallet'
                                        };
                                        print('values$value');
                                        Get.toNamed(Routes.giftCardPaymentScreen, arguments: value);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(2.w),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.h, horizontal: 24.w)),
                                    child: Text(NameValues.proceedToPay,
                                        style: TextStore.textTheme.displaySmall!
                                            .copyWith(color: Colors.white))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ])),
        )*/
          ),
    );
  }
}
