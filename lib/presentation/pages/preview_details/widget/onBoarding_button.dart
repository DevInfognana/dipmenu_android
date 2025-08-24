import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/config/app_textstyle.dart';
import '../../../../core/config/theme.dart';
import '../../../logic/controller/preview_controller.dart';


class OnBoardingButton extends StatelessWidget {
  OnBoardingButton({super.key,
    required this.controller,
    required this.height,
    required this.width,
  });

  final PreviewController controller;
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    return  Obx(()
      => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          GestureDetector(
            onTap: (){
              controller.currentIndex.value==2?controller.mainScreen():controller.next();
            },
            child: Container(
              decoration: BoxDecoration(   borderRadius: BorderRadius.circular(2.h),color: mainColor,),
              height: height,width: width,  margin: EdgeInsets.all(2.h),
              child: Align(
                alignment: Alignment.center,
                child: Text( controller.currentIndex.value==2?'Get Started':'Next',
                    style: TextStore.textTheme.headlineMedium!.copyWith(
                        color: Colors.white,

                        fontWeight: FontWeight.w500)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
