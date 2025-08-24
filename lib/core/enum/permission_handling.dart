import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;
import 'package:get/get.dart';
import '../../presentation/pages/index.dart';
import 'location_values.dart';

class PermissionHandler {


  static Future<bool> requestAllPermission() async {
    PermissionStatus? status;
    try {
      // status = await Permission.locationAlways.request();
      // status = await Permission.locationWhenInUse.request();
      status = await Permission.notification.request();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return status == PermissionStatus.granted ? true : false;
  }

  static Future<bool> requestLocationPermission() async {
    PermissionStatus? status;
    try {
      status = await Permission.notification.request();
      status = await Permission.location.request();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return status == PermissionStatus.granted ? true : false;
  }

  static Future<bool> requestMediaPermission() async {
    PermissionStatus? status;
    try {
      status = await Permission.mediaLibrary.request();
      status = await Permission.camera.request();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    return status == PermissionStatus.granted ? true : false;
  }
}

class PermissionDialogBox {
  static permissionAlertDialog(
      {BuildContext? context,
      String? content,
      String? title,
      void Function()? okayButtonTapped,
      void Function()? cancelButtonTapped,
      String? textBackButton,
      String? textOkButton}) {
    if (Platform.isAndroid) {
      return showDialog(
          context: context!,
          builder: (BuildContext context) {
            return TextScaleFactorClamper(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.w)),
                title: Text(title!,
                    style: TextStore.textTheme.headlineMedium!.copyWith(
                        color: borderColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                content: Text(content!,
                    style: TextStore.textTheme.headlineSmall!
                        .copyWith(color: borderColor),
                    textAlign: TextAlign.center),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            cancelButtonTapped!();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: Colors.grey),
                          child: Text(textBackButton!,
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white))),
                      SizedBox(width: 2.w),
                      ElevatedButton(
                          onPressed: () {
                            okayButtonTapped!();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: mainColor),
                          child: Text(textOkButton!,
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white)))
                    ],
                  ),
                ],
              ),
            );
          });
    } else {
      return showDialog(
          context: context!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(title!,
                  style: TextStore.textTheme.displaySmall!
                      .copyWith(fontWeight: FontWeight.bold)),
              content: Text(content!, style: TextStore.textTheme.headlineSmall!),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(textBackButton!,
                      style: TextStore.textTheme.headlineSmall!),
                  onPressed: () {
                    cancelButtonTapped!();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(textOkButton!,
                      style: TextStore.textTheme.headlineSmall!),
                  onPressed: () {
                    okayButtonTapped!();
                  },
                ),
              ],
            );
          });
    }
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }



  static privacyPolicyAlertDialog1(
      {BuildContext? context}) async {
      return  showDialog(
          context: context!,
          builder: (BuildContext context) {
            return TextScaleFactorClamper(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.w)),
                title: Text(AlertPrivacyDialog.alertTitle,
                    style: TextStore.textTheme.headlineMedium!.copyWith(
                        color: borderColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                content:

                Wrap(
                  spacing: 2.h,
                  children: [
                    Text(AlertPrivacyDialog.alertTitle1,style:TextStore.textTheme.titleLarge!
                        .copyWith(color: borderColor) ),
                    Text(AlertPrivacyDialog.alertTitle1Content,style:TextStore.textTheme.bodyLarge!
                        .copyWith(color: titleColor) ),

                    Text(AlertPrivacyDialog.alertTitle2,style:TextStore.textTheme.titleLarge!
                        .copyWith(color: borderColor) ),
                    Text(AlertPrivacyDialog.alertTitle2ContentPart1,style:TextStore.textTheme.bodyLarge!
                        .copyWith(color: titleColor) ),

                    // Text(alertPrivacyDialog.alertTitle3,style:TextStore.textTheme.titleLarge!
                    //     .copyWith(color: borderColor) ),
                    // Text(alertPrivacyDialog.alertTitle3Content,style:TextStore.textTheme.bodyLarge!
                    //     .copyWith(color: titleColor) ),


                    Text(AlertPrivacyDialog.alertTitle4,style:TextStore.textTheme.titleLarge!
                        .copyWith(color: borderColor) ),
                    Text(AlertPrivacyDialog.alertTitle4Content,style:TextStore.textTheme.bodyLarge!
                        .copyWith(color: titleColor) ),

                    Text(AlertPrivacyDialog.alertTitle5,style:TextStore.textTheme.titleLarge!
                        .copyWith(color: borderColor) ),
                    Text(AlertPrivacyDialog.alertTitle5Content,style:TextStore.textTheme.bodyLarge!
                        .copyWith(color: titleColor) ),

                    Text(AlertPrivacyDialog.alertTitle6,style:TextStore.textTheme.titleLarge!
                        .copyWith(color: borderColor) ),
                    Text(AlertPrivacyDialog.alertTitle6Content,style:TextStore.textTheme.bodyLarge!
                        .copyWith(color: titleColor) ),


                    Text(AlertPrivacyDialog.alertTitle7,style:TextStore.textTheme.titleLarge!
                        .copyWith(color: borderColor) ),
                    Text(AlertPrivacyDialog.alertTitle7Content,style:TextStore.textTheme.bodyLarge!
                        .copyWith(color: titleColor) ),

                  ],
                ),

                // content: Text(content!,
                //     style: TextStore.textTheme.headlineSmall!
                //         .copyWith(color: borderColor),
                //     textAlign: TextAlign.center),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            SharedPrefs.instance.setInt('privacyPolicy',0 );
                            Get.back();
                            // cancelButtonTapped!();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: Colors.grey),
                          child: Text('Decline',
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white))),
                      SizedBox(width: 2.w),
                      ElevatedButton(
                          onPressed: () {
                            SharedPrefs.instance.setInt('privacyPolicy',1 );
                            Get.back();
                            // okayButtonTapped!();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: mainColor),
                          child: Text('Accept',
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white)))
                    ],
                  ),
                ],
              ),
            );
          });
  }


  static privacyPolicyAlertDialog(
      {BuildContext? context}) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if ((SharedPrefs.instance.getString('token') != null) &&
        SharedPrefs.instance.getInt('privacyPolicy') != 1) {
     await  showDialog(
          context: context!,
          builder: (BuildContext context) {
            return TextScaleFactorClamper(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.w)),
                title: Text(AlertPrivacyDialog.alertTitle,
                    style: TextStore.textTheme.headlineMedium!.copyWith(
                        color: borderColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                content:

                  Wrap(
                    spacing: 2.h,
                    children: [
                      Text(AlertPrivacyDialog.alertTitle1,style:TextStore.textTheme.titleLarge!
                          .copyWith(color: borderColor) ),
                      Text(AlertPrivacyDialog.alertTitle1Content,style:TextStore.textTheme.bodyLarge!
                          .copyWith(color: titleColor) ),

                      Text(AlertPrivacyDialog.alertTitle2,style:TextStore.textTheme.titleLarge!
                          .copyWith(color: borderColor) ),
                      Text(AlertPrivacyDialog.alertTitle2ContentPart1,style:TextStore.textTheme.bodyLarge!
                          .copyWith(color: titleColor) ),

                      // Text(alertPrivacyDialog.alertTitle3,style:TextStore.textTheme.titleLarge!
                      //     .copyWith(color: borderColor) ),
                      // Text(alertPrivacyDialog.alertTitle3Content,style:TextStore.textTheme.bodyLarge!
                      //     .copyWith(color: titleColor) ),


                      Text(AlertPrivacyDialog.alertTitle4,style:TextStore.textTheme.titleLarge!
                          .copyWith(color: borderColor) ),
                      Text(AlertPrivacyDialog.alertTitle4Content,style:TextStore.textTheme.bodyLarge!
                          .copyWith(color: titleColor) ),

                      Text(AlertPrivacyDialog.alertTitle5,style:TextStore.textTheme.titleLarge!
                          .copyWith(color: borderColor) ),
                      Text(AlertPrivacyDialog.alertTitle5Content,style:TextStore.textTheme.bodyLarge!
                          .copyWith(color: titleColor) ),


                      Text(AlertPrivacyDialog.alertTitle6,style:TextStore.textTheme.titleLarge!
                          .copyWith(color: borderColor) ),
                      Text(AlertPrivacyDialog.alertTitle6Content,style:TextStore.textTheme.bodyLarge!
                          .copyWith(color: titleColor) ),

                      Text(AlertPrivacyDialog.alertTitle8,style:TextStore.textTheme.titleLarge!
                          .copyWith(color: borderColor) ),
                      Text(AlertPrivacyDialog.alertTitle8Content,style:TextStore.textTheme.bodyLarge!
                          .copyWith(color: titleColor) ),

                      Text(AlertPrivacyDialog.alertTitle7,style:TextStore.textTheme.titleLarge!
                          .copyWith(color: borderColor) ),
                      Text(AlertPrivacyDialog.alertTitle7Content,style:TextStore.textTheme.bodyLarge!
                          .copyWith(color: titleColor) ),

                    ],
                  ),

                // content: Text(content!,
                //     style: TextStore.textTheme.headlineSmall!
                //         .copyWith(color: borderColor),
                //     textAlign: TextAlign.center),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            SharedPrefs.instance.setInt('privacyPolicy',0 );
                            Get.back();
                            // cancelButtonTapped!();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: Colors.grey),
                          child: Text('Decline',
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white))),
                      SizedBox(width: 2.w),
                      ElevatedButton(
                          onPressed: () {
                            SharedPrefs.instance.setInt('privacyPolicy',1 );
                            Get.back();
                            // okayButtonTapped!();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: mainColor),
                          child: Text('Accept',
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white)))
                    ],
                  ),
                ],
              ),
            );
          });
    }
    if((SharedPrefs.instance.getString('token') != null) &&
        permission == LocationPermission.denied){
      await showDialog(
          context: context!,
          builder: (BuildContext context) {
            return TextScaleFactorClamper(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.w)),
                title: Text('Background location Access Required',
                    style: TextStore.textTheme.headlineMedium!.copyWith(
                        color: borderColor, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                content: Text('The App needs background access to track your location so that we may have your order ready for delivery the closer your proximity to The Dip. We DO NOT USE your location for any other purpose other than for the efficiency of your order delivery.  Please grant the necessary permissions to enhance your experience using our mobile app.',
                    style: TextStore.textTheme.headlineSmall!
                        .copyWith(color: borderColor),
                    textAlign: TextAlign.center),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            SharedPrefs.instance.setInt('background', 0);
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: Colors.grey),
                          child: Text('Decline',
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white))),
                      SizedBox(width: 2.w),
                      ElevatedButton(
                          onPressed: () async {
                            LocationChecking.checkPermissionsAndGetLocation();
                              Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                              side: BorderSide.none,
                              fixedSize: Size(
                                  28.w, getDeviceType == "phone" ? 8.h : 6.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.w)),
                              backgroundColor: mainColor),
                          child: Text('Grant',
                              style: TextStore.textTheme.headlineSmall!
                                  .copyWith(color: Colors.white)))
                    ],
                  ),
                ],
              ),
            );
          });

    }else{
      // print('----i will out');
    }
  }

 // static geolocatorPermission() async {
 //    await PermissionHandler.requestLocationPermission();
 //  }
}