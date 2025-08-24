import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:dip_menu/presentation/pages/preview_details/widget/onBoarding_button.dart';
import 'package:dip_menu/presentation/pages/preview_details/widget/pageViewOnBoarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/config/app_textstyle.dart';
import '../../../core/config/theme.dart';
import '../../../core/static/stactic_values.dart';
import '../../logic/controller/preview_controller.dart';


class PreviewScreen extends StatelessWidget {
  PreviewScreen({Key? key}) : super(key: key);
  final controller = Get.find<PreviewController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:  TextScaleFactorClamper(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    TextButton(
                      onPressed: () {
                        controller.mainScreen();


                        // Get.offAndToNamed(Routes.mainScreen);
                      },
                      child: TextWithFont().textWithPoppinsFont(
                        text: 'Skip >'.tr,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(width: 5.w)
                  ],),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 70.h,
                        child:PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            controller: controller.pageController,
                            onPageChanged: (value) {
                              controller.onPageChanged(value);
                            },
                            itemCount: onBoardingList.length,
                            itemBuilder: (context, i){
                              return PageViewOnBoarding(
                                index: i,
                                controller: controller,
                              );
                            }
                        ),

                      ),
                    ],
                  ),
                  // SizedBox(height: 5.h),
                  OnBoardingButton(height: 6.h,width: 80.w,controller: controller,)
                ],
              ),
            ),
          ),
        ),
        );
  }
}
