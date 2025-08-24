import 'package:dio/dio.dart';
import 'package:dip_menu/data/model/home/banner_data.dart';
import 'package:dip_menu/data/model/sub_category/pos_message_modal.dart';
import 'package:dip_menu/domain/reporties/pos_message_api.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:dip_menu/presentation/pages/index.dart';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/enum/permission_handling.dart';
import '../../../data/model/color_plate_model.dart';
import '../../../data/model/home/category/category_data_model.dart';
import '../../../data/model/recent_order_model.dart';
import '../../../data/model/tax_value_model.dart';
import '../../../domain/reporties/home_service.dart';

class HomeController extends GetxController with StateMixin {
  var homeRestaurantsList = <BannerData>[];
  var homeCategoryList = <CategoryModelData>[];
  var posMessageList = <PosMessagevalueData>[];

  // List<String> bannerImages = [];
  late StatusRequest statusRequestBanner;
  late StatusRequest statusRequestCategory;
  late StatusRequest statusRequestColor;
  late StatusRequest statusRequestDrivethru;
  late StatusRequest statusRequestRecentOrder;
  late StatusRequest statusRequestCategory1;
  bool isCheckInFeature = false;
  RecentOrderData? recentOrderData;
  List<SavedColors> savedColorsValues = [];
  List<OrderValues> ordersValues = [];
  List<OrderValues> currentOrderList = [];
  List<ImageViewModel> carImage = [];
  int? selectedIndex;
  int? selectedIndex2;
  String? currentOrder;
  String? colorValues;
  var orderListValues = [];
  var avictveListValues = [];
  TaxValueData? taxValueData;
  RecentOrderData? currentOrderData;

  // WebViewController controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void onInit() async {
    super.onInit();
    viewHomeCategory();
    posMessage();
    statusRequestColor = StatusRequest.stop;
    statusRequestRecentOrder = StatusRequest.stop;
    taxEncyptGetApi();
    sessionChecking();
  }

  mobilePermissionHandler() {
    if (PermissionHandler.requestAllPermission() == false) {
      SharedPrefs.instance.setBool("notification", false);
    } else {
      SharedPrefs.instance.setBool("notification", true);
    }

    // if (PermissionHandler.requestLocationPermission() == false) {
    //   SharedPrefs.instance.setBool("location", false);
    // } else {
    //   SharedPrefs.instance.setBool("location", true);
    // }
  }

  List<String> imagesValues = [
    ImageAsset.carIcon,
    ImageAsset.suvIcon,
    ImageAsset.truckIcon
  ];

//***** don't delete this  line  because  the  banner images already worked
  // void viewHomeBanners() async {
  //   statusRequestBanner = StatusRequest.loading;
  //   var response = await HomeServices.viewHomeBannersRequest();
  //   statusRequestBanner = handlingData(response);
  //   if (StatusRequest.success == statusRequestBanner) {
  //     viewHomeCategory();
  //     bannerImages.clear();
  //     homeRestaurantsList.clear();
  //     List<String> tempvalues = [];
  //     tempvalues.clear();
  //     final dataList = (response['data'] as List)
  //         .map((e) => BannerData.fromJson(e))
  //         .toList();
  //     homeRestaurantsList.addAll(dataList);
  //
  //     for (var element in homeRestaurantsList) {
  //       tempvalues.add(element.images!);
  //     }
  //     tempvalues.forEach((element) {
  //       final splitNames = element.split(',');
  //       for (int i = 0; i < splitNames.length; i++) {
  //         bannerImages.add(splitNames[i]);
  //       }
  //     });
  //     // print(bannerImages.length);
  //   } else {
  //     statusRequestBanner = StatusRequest.failure;
  //   }
  //   update();
  // }

  // void generalSettingApi()async{
  //   var response = await HomeServices.generalSettingApi();
  //    var values=Encrypt.decryptionData(response['datas']);
  //    print(values[0]);
  //  var user= TaxValueData.fromJson(values['response']);
  //    print(user);
  // }

  void viewHomeCategory() async {
    statusRequestBanner = StatusRequest.loading;
    var response = await HomeServices.viewHomeCategoryRequest();
    statusRequestBanner = handlingData(response);
    if (StatusRequest.success == statusRequestBanner) {
      homeCategoryList.clear();
      final dataList = (response['data'] as List)
          .map((e) => CategoryModelData.fromJson(e))
          .toList();
      homeCategoryList.addAll(dataList);
    } else {
      statusRequestBanner = StatusRequest.failure;
    }
    update();
  }

  carImageValues() {
    carImage.add(ImageViewModel(values: ImageAsset.carIcon, carName: 'Car'));
    carImage.add(ImageViewModel(values: ImageAsset.suvIcon, carName: 'SUV'));
    carImage
        .add(ImageViewModel(values: ImageAsset.truckIcon, carName: 'Truck'));
  }

  driveThruValues() {
    String? vechileModel = SharedPrefs.instance.getString("vehicleModel");
    vechileModel == 'Car'
        ? selectedIndex = 0
        : vechileModel == 'SUV'
            ? selectedIndex = 1
            : selectedIndex = 2;
    selectedIndex2 = savedColorsValues.indexWhere((item) =>
        item.colorName == SharedPrefs.instance.getString('vehicleColor'));
  }

  Future<void> refreshLocalGallery() async {
    await Future.delayed(const Duration(seconds: 1));
    imageCache.clear();
    homeCategoryList.clear();
    homeRestaurantsList.clear();
    viewHomeCategory();
    posMessage();
  }

  void posMessage() async {
    statusRequestBanner = StatusRequest.loading;
    var response = await PosMessageServices.posMessageRequest();
    statusRequestBanner = handlingData(response);
    if (StatusRequest.success == statusRequestBanner) {
      posMessageList.clear();
      final dataList = (response['data'] as List)
          .map((e) => PosMessagevalueData.fromJson(e))
          .toList();
      posMessageList.addAll(dataList);
      for (var element in posMessageList) {
        String? startingTime = element.startTime;
        String? endingTime = element.endTime;
        SharedPrefs.instance.setString("startingTime", '$startingTime');
        SharedPrefs.instance.setString("endingTime", '$endingTime');
      }
    } else {
      statusRequestBanner = StatusRequest.failure;
    }
    update();
  }

  cartScreen() {
    Get.toNamed(Routes.cartScreen);
  }

  sessionChecking() {
    if (SharedPrefs.instance.getString('token') != null) {
      statusRequestRecentOrder = StatusRequest.loading;
      carImageValues();
      driveThruValues();
      mobilePermissionHandler();
      // recentOrder1();
      mobileOrder(values: 1);
    } else {
      FlutterBackgroundService().invoke("stopService");
    }
  }

//   void recentOrder() async {
//     final service = FlutterBackgroundService();
//     change(statusRequestRecentOrder = StatusRequest.loading);
//     try {
//       await Dio()
//           .post(BaseAPI.recentOrder,
//               options: Options(headers: {
//                 'x-access-token': SharedPrefs.instance.getString('token')
//               }))
//           .then((response) async {
//         if (response.statusCode == 200) {
//           recentOrderData = RecentOrderData.fromJson(response.data);
// //  today date and time check to  function to  add
//           currentOrderList.clear();
//           avictveListValues.clear();
//           orderListValues.clear();
//           ordersValues.clear();
//           List<String> ordersList = [];
//           for (var element in recentOrderData!.data!) {
//             if (int.parse(getDifference(
//                     DateTime.parse(element.createdAt!.substring(0, 10))))
//                 .isEqual(0)) {
//               if (element.orderStatus == 1) {
//                 avictveListValues.add(element.orderStatus);
//                 currentOrderList.add(OrderValues(
//                     orderNumber: element.orderNumber,
//                     orderPrize: element.orderAmount));
//                 if (element.gpstrack == '0') {
//                   ordersList.add(element.orderNumber!);
//                   // print(ordersList);
//                 }
//               }
//               if (element.orderStatus == 1 || element.orderStatus == 4) {
//                 ordersValues.add(OrderValues(
//                     orderNumber: element.orderNumber,
//                     orderPrize: element.orderAmount,
//                     orderStatus: element.orderStatus));
//                 change(ordersValues);
//               }
//               if (element.orderStatus == 4) {
//                 orderListValues.add(element.orderStatus);
//               }
//             }
//             // print(ordersValues);
//           }
//           SharedPrefs.instance.setStringList('OrderNumberList', ordersList);
//           change(SharedPrefs.instance
//               .setStringList('OrderNumberList', ordersList));
//
//           for (var element in ordersValues) {
//             if (element.orderStatus == 4) {
//               change(currentOrder = element.orderNumber);
//             }
//             currentOrderList.toSet().toList();
//           }
//           bool localServiceChanges = false;
//           for (var element in ordersValues) {
//             if (element.orderStatus == 1) {
//               change(localServiceChanges = true);
//             } else if (element.orderStatus == 4) {
//               change(localServiceChanges = true);
//             } else {
//               localServiceChanges = false;
//               change(localServiceChanges = false);
//             }
//           }
//
//           if (localServiceChanges == false) {
//             service.invoke("stopService");
//           } else {
//             service.startService();
//           }
//           change(isCheckInFeature = true);
//           change(statusRequestRecentOrder = StatusRequest.success);
//           showAlertDialog(Get.context!);
//         }
//       });
//     } catch (e) {
//       change(null, status: RxStatus.error('Something went to wrong'));
//     }
//     update();
//   }
//
//   void recentOrder1() async {
//     final service = FlutterBackgroundService();
//     change(statusRequestRecentOrder = StatusRequest.loading);
//     try {
//       await Dio()
//           .post(BaseAPI.recentOrder,
//               options: Options(headers: {
//                 'x-access-token': SharedPrefs.instance.getString('token')
//               }))
//           .then((response) async {
//         if (response.statusCode == 200) {
//           recentOrderData = RecentOrderData.fromJson(response.data);
// //  today date and time check to  function to  add
//           currentOrderList.clear();
//           avictveListValues.clear();
//           orderListValues.clear();
//           ordersValues.clear();
//           List<String> ordersList = [];
//           for (var element in recentOrderData!.data!) {
//             if (int.parse(getDifference(
//                     DateTime.parse(element.createdAt!.substring(0, 10))))
//                 .isEqual(0)) {
//               if (element.orderStatus == 1) {
//                 avictveListValues.add(element.orderStatus);
//                 currentOrderList.add(OrderValues(
//                     orderNumber: element.orderNumber,
//                     orderPrize: element.orderAmount));
//                 // print(element.gpstrack.runtimeType);
//                 if (element.gpstrack == '0') {
//                   ordersList.add(element.orderNumber!);
//                   // print(ordersList);
//                 }
//               }
//               if (element.orderStatus == 1 || element.orderStatus == 4) {
//                 ordersValues.add(OrderValues(
//                     orderNumber: element.orderNumber,
//                     orderPrize: element.orderAmount,
//                     orderStatus: element.orderStatus));
//                 change(ordersValues);
//               }
//             }
//
//             if (element.orderStatus == 4) {
//               orderListValues.add(element.orderStatus);
//             }
//           }
//           SharedPrefs.instance.setStringList('OrderNumberList', ordersList);
//           change(SharedPrefs.instance
//               .setStringList('OrderNumberList', ordersList));
//
//           for (var element in ordersValues) {
//             if (element.orderStatus == 4) {
//               change(currentOrder = element.orderNumber);
//             }
//             currentOrderList.toSet().toList();
//           }
//           bool localServiceChanges = false;
//           for (var element in ordersValues) {
//             if (element.orderStatus == 1) {
//               change(localServiceChanges = true);
//             } else if (element.orderStatus == 4) {
//               change(localServiceChanges = true);
//             } else {
//               localServiceChanges = false;
//               change(localServiceChanges = false);
//             }
//           }
//
//           if (localServiceChanges == false) {
//             service.invoke("stopService");
//           } else {
//             service.startService();
//           }
//
//           change(isCheckInFeature = true);
//           change(statusRequestRecentOrder = StatusRequest.success);
//         }
//       });
//     } catch (e) {
//       change(null, status: RxStatus.error('Something went to wrong'));
//     }
//     update();
//   }

  taxEncyptGetApi() async {
    change(null, status: RxStatus.loading());
    await Dio().get(BaseAPI.cartListTaxGetApi).then((response) {
      if (response.statusCode == 200) {
        if (response.data['datas'].isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          taxValueApi(encryptedValues: response.data['datas']);
        }
      } else {
        Get.snackbar('', 'Something went wrong');
        change(null, status: RxStatus.error('Something went wrong'));
      }
    });
  }

  taxValueApi({required encryptedValues}) async {
    await Dio().post(
      BaseAPI.cartListTaxDecryptApi,
      data: {"payload": encryptedValues},
    ).then((response) {
      if (response.statusCode == 200) {
        taxValueData = TaxValueData.fromJson(response.data);
        taxValueData?.datas!.response!.forEach((element) {
          SharedPrefs.instance.setString("timeZone", '${element.timezone}');
          SharedPrefs.instance
              .setString("shopLatitude", '${element.shopLatitude}');
          SharedPrefs.instance
              .setString("shopLongitude", '${element.shopLongitude}');
          SharedPrefs.instance.setString("shopRadius", '${element.shopRadius}');
          change(SharedPrefs.instance
              .setString("shopRadius", '${element.shopRadius}'));
          change(SharedPrefs.instance
              .setString("shopLongitude", '${element.shopLongitude}'));
          change(SharedPrefs.instance
              .setString("shopLatitude", '${element.shopLatitude}'));
          SharedPrefs.instance.setString("disclaimer", '${element.disclaimer}');
          SharedPrefs.instance.setString("discount", '${element.discount}');
          // print('-------------------');
          // print(element.discount);
          // print(element.tax);
        });
        SharedPrefs.instance
            .setString("salesTax", '${taxValueData?.datas!.response![0].tax}');
      } else {
        change(null, status: RxStatus.error(response.statusMessage));
      }
    });
  }

  void viewColorPlateValues() async {
    statusRequestColor = StatusRequest.loading;
    var response = await HomeServices.viewColorPlateRequest();
    statusRequestColor = handlingData(response);
    if (StatusRequest.success == statusRequestColor) {
      final values = ResultColorPlateValues.fromJson(response);
      for (var element in values.savedColors!) {
        savedColorsValues.add(SavedColors(
            colorCode: element.colorCode, colorName: element.colorName));
      }

      selectedIndex2 = savedColorsValues.indexWhere((item) =>
          item.colorName == SharedPrefs.instance.getString('vehicleColor'));
      colorValues = SharedPrefs.instance.getString('vehicleColor');
    } else {
      statusRequestBanner = StatusRequest.failure;
    }
    update();
  }

  void checkInFeature(int orderMode, dynamic orderModeValues,
      [String? currentOrderValues]) async {
    change(statusRequestDrivethru = StatusRequest.loading);

    Map values = {
      "order_number": currentOrderValues,
      "order_status": 1,
      "orderMode_details": orderModeValues,
      "order_mode": orderMode.toString()
    };
    final encryptingDataValues = Encrypt.encryptingData(values);
    try {
      var response = await HomeServices().checkInFeature(encryptingDataValues);
      if (response != null) {
        change(statusRequestDrivethru = StatusRequest.success);
        Get.offAllNamed(Routes.mainScreen, arguments: 0);
        taxEncyptGetApi();
        mobileOrder(values: 1);
      } else {}
    } catch (e) {
      change(statusRequestDrivethru = StatusRequest.failure);
    }
  }

  void mobileOrder({int? values}) async {
    final service = FlutterBackgroundService();
    change(statusRequestRecentOrder = StatusRequest.loading);
    try {
      await Dio()
          .post(BaseAPI.mobileOrder,
              options: Options(headers: {
                'x-access-token': SharedPrefs.instance.getString('token')
              }))
          .then((response) async {
        if (response.statusCode == 200) {
          currentOrderData = RecentOrderData.fromJson(response.data);
          List<String> ordersList = [];
          for (var element in currentOrderData!.data!) {
            if (element.orderStatus == 4) {
              currentOrder = element.orderNumber;
            }
            if (element.gpstrack == '0') {
              ordersList.add(element.orderNumber!);
            }
          }
          SharedPrefs.instance.setStringList('OrderNumberList', ordersList);
          change(SharedPrefs.instance
              .setStringList('OrderNumberList', ordersList));

          if (currentOrderData!.data!
                  .any((element) => element.orderStatus == 1) ||
              currentOrderData!.data!
                  .any((element) => element.orderStatus == 4)) {
            // service.startService();
            backgroundChecking(service);
          } else {
            service.invoke("stopService");
          }
          if (values == 0) {
            if (currentOrderData!.data!.isNotEmpty) {
              showAlertDialog(Get.context!);
            } else {
              emptyListDialog(Get.context!);
            }
          }

          change(statusRequestRecentOrder = StatusRequest.success);
        }
      });
    } catch (e) {
      change(null, status: RxStatus.error('Something went to wrong'));
    }

    update();
  }

  backgroundChecking(FlutterBackgroundService service) async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    // print('--permission---->${permission != LocationPermission.denied}');
    // print('--policy---->${SharedPrefs.instance.getInt('privacyPolicy') == 1}');
    if (permission != LocationPermission.denied &&
        SharedPrefs.instance.getInt('privacyPolicy') == 1) {
      await service.startService();
    } else {
      await ShowDialogBox().privacypolicy(Get.context);
    }
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<HomeController>(builder: (_) {
          return HandlingDataView(
            statusRequest: statusRequestRecentOrder,
            widget: TextScaleFactorClamper(
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: statusRequestRecentOrder == StatusRequest.loading
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0.5, horizontal: 0.5),
                        width: 25.w,
                        height: 25.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 15.h,
                                width: 200.w,
                                child: Lottie.asset(ImageAsset.loadingCheckIN,
                                    fit: BoxFit.contain)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Please wait",
                                    style: TextStore.textTheme.headlineMedium!
                                        .copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 1.2.h),
                          ],
                        ),
                      )
                    : currentOrderData!.data!
                            .any((element) => element.orderStatus == 4)
                        ? Container(
                            padding: const EdgeInsets.all(1.0),
                            width: 70.w,
                            height: 30.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(" Order ID :  $currentOrder",
                                    style: TextStore.textTheme.displaySmall!
                                        .copyWith(
                                            color: titleColor,
                                            fontWeight: FontWeight.w800)),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    Get.toNamed(Routes.driveThruScreen,
                                        arguments: currentOrder);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                          'assets/alert_icon/drive_thru.png',
                                          height: 10.h,
                                          width: 12.w),
                                      const SizedBox(width: 20),
                                      Text("Drive-Thru",
                                          style: TextStore.textTheme.displaySmall!
                                              .copyWith(
                                                  color: drivethru,
                                                  fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    checkInFeature(
                                        2, 'pickup-order', currentOrder);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                          'assets/alert_icon/pickup_order.png',
                                          height: 10.h,
                                          width: 12.w),
                                      const SizedBox(width: 20),
                                      Text("Front Window", //"Pick Up Order",
                                          style: TextStore.textTheme.displaySmall!
                                              .copyWith(
                                                  color: darkSeafoamGreen1,
                                                  fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          )
                        : currentOrderData!.data!
                                .any((element) => element.orderStatus == 1)
                            ? Container(
                                padding: const EdgeInsets.all(1.0),
                                width: 70.w,
                                height: 35.h,
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Center(
                                          child: Text(NameValues.activeOrder,
                                              style: TextStore
                                                  .textTheme.displaySmall!
                                                  .copyWith(
                                                      color: titleColor,
                                                      fontWeight:
                                                          FontWeight.w800))),
                                      SizedBox(height: 0.5.h),
                                      SizedBox(
                                        height: 28.h,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              const Divider(
                                                  color: Colors.black),
                                          itemCount:
                                              currentOrderData!.data!.length,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  "ID :${currentOrderData!.data![index].orderNumber}",
                                                  style: TextStore
                                                      .textTheme.headlineSmall!
                                                      .copyWith(
                                                          color: Colors.black)),
                                              Text(
                                                  "Price: \$ ${currentOrderData!.data![index].orderTotal}",
                                                  style: TextStore
                                                      .textTheme.headlineSmall!
                                                      .copyWith(
                                                          color: Colors.black))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(1.0),
                                width: 70.w,
                                height: 20.h,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          "There are currently no active orders. Please place an order to proceed with the check-in process.",
                                          style: DeviceTypeValues
                                                      .getDeviceType() ==
                                                  'phone'
                                              ? TextStore.textTheme.headlineSmall!
                                                  .copyWith(
                                                      color: descriptionColor)
                                              : TextStore.textTheme.headlineMedium!
                                                  .copyWith(
                                                      color: descriptionColor)),
                                      Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              // Get.offAllNamed(Routes.mainScreen, arguments: 1);
                                              Get.back();
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: mainColor,
                                                fixedSize: Size(50.w, 2.h),
                                                textStyle: TextStore
                                                    .textTheme.headlineSmall!
                                                    .copyWith(
                                                        color: Colors.white),
                                                elevation: 6),
                                            child: const Text('Back',style: TextStyle(color: Colors.white),)),
                                      ),
                                    ])),
              ),
            ),
          );
        });
      },
    );
  }

  emptyListDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return TextScaleFactorClamper(
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.w)),
            content: Text(
                "There are currently no active orders. Please place an order to proceed with the check-in process.",
                style: DeviceTypeValues.getDeviceType() == 'phone'
                    ? TextStore.textTheme.headlineSmall!
                        .copyWith(color: descriptionColor)
                    : TextStore.textTheme.headlineMedium!
                        .copyWith(color: descriptionColor)),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      // Get.offAllNamed(Routes.mainScreen, arguments: 1);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        fixedSize: Size(50.w, 2.h),
                        textStyle: TextStore.textTheme.headlineSmall!
                            .copyWith(color: Colors.white),
                        elevation: 6),
                    child: const Text('Back',style: TextStyle(color: Colors.white),)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OrderValues {
  int? orderStatus;
  String? orderNumber;
  String? orderName;
  String? orderPrize;

  OrderValues(
      {this.orderStatus, this.orderNumber, this.orderName, this.orderPrize});
}

class ImageViewModel {
  String? values;
  String? carName;

  ImageViewModel({this.values, this.carName});
}
