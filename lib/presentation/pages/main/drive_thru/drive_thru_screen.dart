import 'dart:convert';

import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/core/static/stactic_values.dart';
import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:dip_menu/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_textstyle.dart';
import '../../../../domain/entities/handling_data_view.dart';
import '../../../../extra/common_widgets/back_button.dart';
import '../../../../extra/common_widgets/snack_bar.dart';
import '../../../logic/controller/home_controller.dart';

class DriveThruScreen extends StatefulWidget {
  const DriveThruScreen({Key? key}) : super(key: key);

  @override
  State<DriveThruScreen> createState() => _DriveThruScreenState();
}

class _DriveThruScreenState extends State<DriveThruScreen> {
  final HomeController homeController = Get.find();
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    homeController.viewColorPlateValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Row(
              children: [
                AuthBackButton(
                  press: () {
                    Get.offAllNamed(Routes.mainScreen, arguments: 0);
                  },
                ),
                const Spacer(flex: 3),
                TextScaleFactorClamper(
                    child: AuthTitleText(text: NameValues.driveThru)),
                // TextScaleFactorClamper(
                //   child: Text(NameValues.driveThru,
                //       style: TextStore.textTheme.displaySmall!.copyWith(
                //           color: Colors.black, fontWeight: FontWeight.bold)),
                // ),
                const Spacer(flex: 5),
              ],
            ),
          ),
        ),
        body: TextScaleFactorClamper(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(bottom: 2.h, right: 2.h, left: 2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    textView('Type of Vehicle'),
                    SizedBox(height: 1.h),
                    SizedBox(
                      height: 17.h,
                      width: double.infinity,
                      child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.carImage.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  homeController.selectedIndex = index;
                                });
                              },
                              child: Card(
                                elevation: 0,
                                color: homeController.selectedIndex == index
                                    ? Colors.blueGrey.shade100
                                    : Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.w)),
                                child: imageView(
                                    homeController.carImage[index].values,
                                    homeController.carImage[index].carName,
                                    index),
                              ),
                            );
                          }),
                    ),
                    textView('Choose Colors'),
                    SizedBox(height: 1.h),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        return HandlingDataView(
                          statusRequest: homeController.statusRequestColor,
                          widget:
                              LayoutBuilder(builder: (context, constraints) {
                            return GridView.builder(
                              itemCount:
                                  homeController.savedColorsValues.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        homeController.selectedIndex2 = index;
                                        homeController.colorValues =
                                            homeController
                                                .savedColorsValues[index]
                                                .colorName;
                                      });
                                    },
                                    child: Stack(children: [
                                      Card(
                                          elevation:
                                              homeController.selectedIndex2 ==
                                                      index
                                                  ? 15.0
                                                  : 0.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.w)),
                                          shadowColor: homeController
                                                      .selectedIndex2 ==
                                                  index
                                              ? Color(int.parse(
                                                  "0xFF${homeController.savedColorsValues[index].colorCode!.substring(1, homeController.savedColorsValues[index].colorCode!.length)}"))
                                              : Colors.transparent,
                                          child: colorView(homeController
                                              .savedColorsValues[index]
                                              .colorCode)),
                                      Positioned(
                                        top: 0,
                                        right: 1,
                                        child: Offstage(
                                          offstage:
                                              homeController.selectedIndex2 ==
                                                      index
                                                  ? false
                                                  : true,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                color: Colors.green,
                                                shape: BoxShape.circle),
                                            child: const Icon(Icons.check,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ]));
                              },
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10, crossAxisCount: 5),
                            );
                          }),
                        );
                      },
                    ),
                    SizedBox(height: 1.h),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                        child: ElevatedButton(
                            onPressed: () {
                              String carvalues = '';
                              homeController.selectedIndex == 0
                                  ? carvalues = 'Car'
                                  : homeController.selectedIndex == 1
                                      ? carvalues = 'SUV'
                                      : carvalues = 'Truck';

                              dynamic mapvalues = {
                                "vehicleModel": carvalues,
                                "vehicleColor": homeController.colorValues
                              };
                              dynamic orderModeNummberValues =
                                  jsonEncode(mapvalues);
                              if (homeController.colorValues != null &&
                                  homeController.selectedIndex != null) {
                                homeController.checkInFeature(
                                    1, orderModeNummberValues, argumentData);
                              } else {
                                showSnackBar(
                                    'Please choose vehicle type and colors');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.h, horizontal: 24.w)),
                            child: TextScaleFactorClamper(
                              child: Text('Submit',
                                  style: TextStore.textTheme.displaySmall!
                                      .copyWith(color: Colors.white)),
                            )),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

textView(String? values) {
  return Text(values!,
      style: Get.context!.theme.textTheme.displaySmall
          ?.copyWith(fontWeight: FontWeight.bold));
}

imageView(String? values, String? text, int index) {
  return FittedBox(
    fit: BoxFit.contain,
    child: SizedBox(
      height: 13.h,
      width: 21.w,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(4.w),
              child: Image.asset(values!,
                  height: index == 3 ? 13.h : 9.h, width: 21.w)),
          Text(text!,
              style: Get.context!.theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              // style: TextStore.textTheme.titleLarge!
              //     .copyWith(color: Colors.black, fontWeight: FontWeight.bold)
          )
        ],
      ),
    ),
  );
}

colorView(String? values) {
  return FittedBox(
    fit: BoxFit.fill,
    child: Container(
      height: 10.h,
      width: 20.w,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.3),
          borderRadius: BorderRadius.circular(2.w),
          color:
              Color(int.parse("0xFF${values!.substring(1, values.length)}"))),
    ),
  );
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 000000);
}
