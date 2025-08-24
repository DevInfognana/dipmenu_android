import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_textstyle.dart';
import '../../../../core/config/theme.dart';
import '../../../../core/static/stactic_values.dart';
import '../../../logic/controller/preview_controller.dart';
import 'onBoarding_indicator.dart';

class PageViewOnBoarding extends StatelessWidget {
  final int index;

  final PreviewController controller;

  const PageViewOnBoarding({super.key,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 14.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(onBoardingList[index].image!, height: 30.h, width: 60.w),
          Text(onBoardingList[index].title!.tr,
              textAlign: TextAlign.center,
              style: TextStore.textTheme.displayLarge!
                  .copyWith(color: titleColor, fontWeight: FontWeight.w500)),
          Text(onBoardingList[index].body!,
              textAlign: TextAlign.center,
              style: TextStore.textTheme.headlineSmall!.copyWith(
                  color: descriptionColor, fontWeight: FontWeight.w500)),
          const Spacer(),
          OnBoardingIndicator(controller: controller, margin: 15),
          const Spacer(),
        ],
      ),
    );
  }
}
