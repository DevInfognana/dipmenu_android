import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/theme.dart';
import '../../../../core/static/stactic_values.dart';
import '../../../logic/controller/preview_controller.dart';


class OnBoardingIndicator extends StatelessWidget {
  const OnBoardingIndicator({super.key,
    required this.controller,
    required this.margin,
  });

  final PreviewController controller;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          onBoardingList.length,
              (index) => AnimatedContainer(
            margin: EdgeInsets.only(right: margin),
            duration: const Duration(milliseconds: 100),
            width: 2.2.w,
            height: 2.2.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
              border: Border.all(color: descriptionColor),
                color: controller.currentIndex.value == index
                    ? mainColor
                    : Colors.white,
                ),
          ),
        ),
      ],
    )
    );
  }
}
