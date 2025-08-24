import 'dart:async';
import 'dart:ui';

import 'package:dip_menu/presentation/logic/bindings/controller_binding.dart';
import 'package:dip_menu/presentation/logic/controller/connection_manager_controller.dart';
import 'package:dip_menu/presentation/logic/controller/intial_controller.dart';
import 'package:dip_menu/presentation/logic/controller/splash_controller.dart';
import 'package:dip_menu/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'core/config/theme.dart';
import 'domain/local_handler/Local_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_background_service_android/flutter_background_service_android.dart';



Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,
      autoStart: true,
      isForegroundMode: false,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,
      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,
      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}


@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}


@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  // if(service  is IOSServiceInstance){
  //   service.on('setBackgroundFetchResult').listen((event) {
  //     service;
  //   });
  //
  // }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });
  Get.put(SplashInitalController());
  final profileController = Get.find<SplashInitalController>();



  Timer.periodic(const Duration(seconds:20 ), (timer) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    await prefs.reload();
    profileController.sharedPrefValuesIntialValues();
    profileController.locationValues();
  });

  Timer.periodic(const Duration(minutes: 1 ), (timer) async {
    profileController.notificationOrder();

  });
}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();
  Get.put(SplashScreenController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.lazyPut(() => ConnectionManagerController());
  tz.initializeTimeZones();
    initializeService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // print(state);
    if (state == AppLifecycleState.resumed) {
      //Check call when open app from background

    }else if(state ==AppLifecycleState.inactive){

    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          initialBinding: ControllerBinding(),
          debugShowCheckedModeBanner: false,
          title: 'VELVET CREAM',
          fallbackLocale: const Locale('en'),
          theme: ThemesApp.light,
          darkTheme: ThemesApp.dark,
          // themeMode: ThemeMode.system,
          themeMode:SharedPrefs.instance.getBool('darkMode')==true ||  SharedPrefs.instance.getBool('darkMode') == null
              ? ThemeMode.dark
              : ThemeMode.light,
          // themeMode: ThemeController().themeDataGet,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
