import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/enum/location_values.dart';
import '../../../data/model/recent_order_model.dart';
import '../../../domain/entities/encryption_file.dart';
import '../../../domain/notification_manager/notification_manager.dart';
import '../../../domain/provider/http_request.dart';
import 'dart:io' show Platform;
// import '../../../extra/common_widgets/cst_time_check.dart';
// MainController mainController = MainController();

class SplashInitalController extends GetxController with StateMixin {
  RecentOrderData? recentOrderData;
  List<String>? ordersValuesList = [];
  var orderNumberValues = [];
  bool notification = false;
  bool location = false;
  late final NotificationService notificationService;
  double shopLatitude = 0;
  double shopLongitude = 0;
  double shopRadius = 0;
  String? userName;
  String? token;
  late StreamSubscription<Position> _locationSubscription;

  // final service = FlutterBackgroundService();

  final MethodChannel androidChannel = const MethodChannel(
      'id.flutter/background_service_android_bg', JSONMethodCodec());
  static const MethodChannel iosChannel =
      MethodChannel('id.flutter/background_service_ios_bg', JSONMethodCodec());

  // StreamSubscription? positionStream;

  @override
  void onInit() {
    super.onInit();
    sharedPrefValuesIntialValues();
    notificationService = NotificationService();
    notificationService.initializePlatformNotifications();
  }

  @override
  void onClose() {
    _locationSubscription.cancel();
    super.onClose();
  }

  sharedPrefValuesIntialValues() async {
    SharedPreferences.getInstance().then((value) {
      if (value.getStringList('OrderNumberList') != null) {
        ordersValuesList = value.getStringList('OrderNumberList');
        change(ordersValuesList = value.getStringList('OrderNumberList'));
      }

      // print(value.getStringList('OrderNumberList'));
      //  SharedPrefs.instance.setString("notification show",'1');
      if (value.getString('shopLatitude') != null &&
          value.getString('shopLongitude') != null) {
        change(shopLatitude = double.parse(value.getString('shopLatitude')!));
        change(shopLongitude = double.parse(value.getString('shopLongitude')!));
        change(shopRadius = double.parse(value.getString('shopRadius')!));
        change(location = value.getBool('location') ?? false);
        if (location == true) {
          locationValues();
        }
      } else {
        // positionStream!.cancel();
      }

      change(userName = value.getString('first_name'));
      change(token = value.getString('token'));

      if (value.getBool('notification') != null) {
        change(notification = value.getBool('notification')!);
      }
      return value;
    });

    // final service = FlutterBackgroundService();
    // var isRunning = await service.isRunning();
    // if (isRunning) {
    //   positionStream!.isPaused;
    // } else {
    //   positionStream!.resume();
    // }
  }

  locationValues() async {
    double totalDistance = 0;
    // print(shopRadius);

    ////
    // 2.  Configure the plugin
    //
    // bg.BackgroundGeolocation.ready(bg.Config(
    //     desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
    //     distanceFilter: 10.0,
    //     stopOnTerminate: false,
    //     startOnBoot: true,
    //     debug: true,
    //     logLevel: bg.Config.LOG_LEVEL_VERBOSE
    // )).then((bg.State state) {
    //   if (!state.enabled) {
    //     ////
    //     // 3.  Start the plugin.
    //     //
    //     bg.BackgroundGeolocation.start();
    //   }
    // });

    try {
      // var status = await Geolocator.requestPermission();
      // if (status == LocationPermission.denied) {
      //   Geolocator.checkPermission();
      //   return;
      // }
      // print('--4---66');

      // Subscribe to location updates
      _locationSubscription = Geolocator.getPositionStream(
              locationSettings: LocationChecking().locationSettings)
          .listen((Position? position) {
        if (position != null) {
          totalDistance = calculateDistance(position.latitude,
              position.longitude, shopLatitude, shopLongitude);
          print([
            totalDistance,
            shopRadius,
            position.latitude,
            position.longitude,
            shopLatitude,
            shopLongitude
          ]);
          if (shopLatitude != null && shopLongitude != null) {
            if (totalDistance < shopRadius) {
              locationOnceChecking();
            } else {
              print('shop near not that');
            }
          }
        }
      });
    } catch (e) {
      print(e);
      LocationChecking.checkPermissionsAndGetLocation();
    }
  }

  backgroundFeature() async {
    await SharedPreferences.getInstance().then((value) async {
      if (value.getString('token') != null && ordersValuesList!.isNotEmpty) {
        Map values = {
          "gps_track": "1",
          "order_id": int.parse(ordersValuesList!.first.toString())
        };
        final encryptingDataValues = Encrypt.encryptingData(values);
        var body = jsonEncode({
          "payload": encryptingDataValues,
        });
        try {
          await Dio()
              .post(BaseAPI.gpsUpdate,
                  data: body,
                  options: Options(
                      headers: {'x-access-token': value.getString('token')}))
              .then((response) {
            // print('===> GPS API Response Status: ${response.statusCode}');
            // print('===> GPS API Response Data: ${response.data}');
            if (response.statusCode == 200) {
              ordersValuesList!.remove(ordersValuesList!.first.toString());
              value.setStringList('OrderNumberList', ordersValuesList!);
              // print('===>Gps data:${response.data}');
              // print(GPSstatusmodel.fromJson(response.data));
              intialRecentorder();
            }
          });
        } catch (e) {
          if (kDebugMode) {
            print('$e');
          }
        }
      } else {
        intialRecentorder();
      }

      return value;
    });
  }

  locationOnceChecking() {
    backgroundFeature();
    print(ordersValuesList);
    // if (ordersValuesList != null) {
    //   backgroundFeature();
    // } else {
    //   print('stopService');
    // }
  }

  intialRecentorder() async {
    final service = FlutterBackgroundService();
    try {
      await Dio()
          .post(BaseAPI.mobileOrder,
              options: Options(headers: {'x-access-token': token}))
          .then((response) async {
        if (response.statusCode == 200) {
          if (response.data['data'].isNotEmpty) {
            // print('------------');
          } else {
            try {
              stopSelf();
            } catch (e) {
              print('-----$e');
            }
          }
          recentOrderData = RecentOrderData.fromJson(response.data);
          List<String> ordersList = [];
          orderNumberValues.clear();
          ordersValuesList!.clear();

          for (var element in recentOrderData!.data!) {
            if (element.orderStatus == 1) {
              if (element.gpstrack == 0) {
                ordersList.add(element.orderNumber!);
                ordersValuesList!.add(element.orderNumber!);
                change(ordersValuesList);

                SharedPreferences.getInstance().then((value) async {
                  value.setStringList('OrderNumberList', ordersValuesList!);
                });
              }
            }
          }

          if (recentOrderData!.data!.isEmpty) {
            stopSelf();
          }
        }
      });
    } catch (e) {
      print('not  working $e');
    }
  }

  Future<void> stopSelf() async {
    if (Platform.isAndroid) {
      await androidChannel.invokeMethod("stopService");
    } else {
      await iosChannel.invokeMethod("stopService");
    }

  }

  notificationOrder() async {
    try {
      await SharedPreferences.getInstance().then((value) async {
        if (value.getString('token') != null) {
          print('==>Tknval:${value.getString('token')}');
          await Dio()
              .post(BaseAPI.mobileOrder,
                  options: Options(headers: {'x-access-token': value.getString('token')}))
              .then((response) async {
            if (response.statusCode == 200) {
              // recentOrderData!.data!.clear();
              recentOrderData = RecentOrderData.fromJson(response.data);
              List<String> ordersList = [];
              var orderStatusValues = [];
              orderNumberValues.clear();
              ordersValuesList!.clear();

              for (var element in recentOrderData!.data!) {
                if (element.orderStatus == 1) {
                  if (element.gpstrack == 0) {
                    ordersList.add(element.orderNumber!);
                    ordersValuesList!.add(element.orderNumber!);
                    change(ordersValuesList);
                    SharedPreferences.getInstance().then((value) async {
                      value.setStringList('OrderNumberList', ordersValuesList!);
                    });
                  }
                }
                if (element.orderStatus == 4) {
                  orderStatusValues.add(element.orderStatus);
                  orderNumberValues.add(element.orderNumber);
                  if (notification == true) {
                    notificationValueAssign();
                  }
                }
              }
              if (recentOrderData!.data!.isEmpty) {
                // service.invoke("stopService");
              }
            }else if(response.statusCode == 401){

            }
          });
        }
      });
         } catch (e) {
      print('not  working $e');
    }
  }

  notificationValueAssign() {
    for (var element in orderNumberValues) {
      notificationtrigger(element.toString());
    }
  }

  notificationtrigger(String orderNumber) async {
    await notificationService.showdLocalNotification(
      id: 1,
      // title: '$userName, the order number is $orderNumber',
      title: 'When you arrive at Velvet Cream (The Dip)',
      body: "please make sure to use the Check-In feature in your mobile app",
      //When you arrive at Velvet Cream (The Dip), please make sure to use the Check-In feature in your mobile app.
    );
    orderNumberValues.remove(orderNumber);
  }
}
