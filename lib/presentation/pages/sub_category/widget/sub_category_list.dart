
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../../core/config/app_textstyle.dart';

import 'package:dip_menu/presentation/pages/index.dart';


Widget cardView(
    {required String name,
    required String description,
      int? rewardValues,
      int? rewardIcon,
    required String imageUrl}) {
  return TextScaleFactorClamper(
    child: Card(
      color: Theme.of(Get.context!).scaffoldBackgroundColor,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rewardIcon==0?
                      Text(name,
                          textAlign: TextAlign.left,
                          style: Get.context!.theme.textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold)):Wrap(
                        children:[
                          Text(name,
                              textAlign: TextAlign.left,
                              style: Get.context!.theme.textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const ImageIcon(AssetImage(ImageAsset.rewardIcon)),
                        ]
                      ),
                      rewardValues==0?
                      Text(
                        description.replaceAll("\n", " ").toString(),
                        textAlign: TextAlign.justify,
                        maxLines: 3,
                        style: Get.context!.theme.textTheme.titleLarge?.copyWith(
                            color: Get.isDarkMode
                                ? Colors.white70
                                : descriptionColor),
                      ) : Text(
                          ' $description pts',
                          style: Get.context!.theme.textTheme.headlineMedium
                              ?.copyWith(color: mainColor)),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              SizedBox(
                height: 13.3.h,
                width: getDeviceType() == 'phone' ? 27.w : 23.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.w),
                  child: ImageView(
                    imageUrl: imageview(imageUrl),
                    showValues: false,
                    mainImageViewWidth: 34.w,
                    bottomImageViewHeight: 5.h,
                  ),
                ),
              ),
            ],
          ),
          DividerView(values: 1)
        ],
      ),
    ),
    // child: Card(
    //   color: Theme.of(Get.context!).scaffoldBackgroundColor,
    //   elevation: 0,
    //   child: Padding(
    //     padding:  EdgeInsets.only(left: 2.w,right: 2.w),
    //     child: Column(
    //       children: [
    //         Container(
    //           margin: EdgeInsets.all(1.w),
    //           alignment: Alignment.centerLeft,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Flexible(
    //                 child: Container(
    //                   padding: EdgeInsets.all(1.h),
    //                   child: Column(
    //                     children: [
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                               child: Text(name,
    //                                   style: TextStore.textTheme.headlineMedium!
    //                                       .copyWith(
    //                                           color: Colors.black,
    //                                           fontWeight: FontWeight.bold)
    //                               ))
    //                         ],
    //                       ),
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                               child: Text(describtion,
    //                                   style: TextStore.textTheme.titleLarge!
    //                                       .copyWith(color: descriptionColor)))
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(width: 3.w),
    //               SizedBox(
    //                 height: 15.h,
    //                 width: getDeviceType()=='phone'? 27.w:23.w,
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(4.w),
    //                   child: ImageView(
    //                     imageUrl: imageview(imageUrl),
    //                     showValues: false,
    //                     mainImageViewWidth: 34.w,
    //                     bottomImageViewHeight: 5.h,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding:  EdgeInsets.only(left: 1.h,right: 1.h),
    //           child: const Divider(
    //             color: tileColor,
    //             thickness: 2.0,
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // ),
  );
}

String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? 'phone' : 'tablet';
}
