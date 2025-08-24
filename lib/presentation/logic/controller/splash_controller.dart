import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:dip_menu/presentation/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../../core/enum/permission_handling.dart';


class SplashScreenController extends GetxController with StateMixin {
  final sharedPrefs = SharedPrefs.instance;
  final key = 'First_Time_Entry';
  final darkModeKey = 'darkMode';
  final bottomBar = 'bottomBar';
  final privacyPolicy = 'privacyPolicy';
  bool isUpdateDialogShown = false; // Flag to prevent multiple dialogs

  @override
  void onInit() {
    super.onInit();
    // print("----> Step 1: Checking app version...");
    checkAppVersion();
  }

  Future<void> checkAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;
      String latestVersion = await VersionService.getLatestVersion();

      print("---->SplashScreen: Current App Version: $currentVersion");
      print("---->SplashScreen: Latest App Version from Json: $latestVersion");
      bool updateAvailable =await VersionHelper().isUpdateAvailable(packageInfo.version, latestVersion);
      print("----> [checkAppVersion] Is update available? $updateAvailable");
      if (updateAvailable && !isUpdateDialogShown) {
        isUpdateDialogShown = true; // Prevent multiple dialogs
        await showUpdateDialog(Get.context!); // Wait for user response
      } else{
        await requestPermissions();
        await notificationView();
        themeChecking();
      }
      // print("----> Proceeding with permissions and theme setup...");

    } catch (e) {
      // print('Error checking version: $e');
      Get.offNamed(Routes.mainScreen);
    }
  }

  Future<void> showUpdateDialog(BuildContext context) async {
    Completer<void> completer = Completer<void>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Update Required',
            style: TextStyle(color: Colors.black), // Ensure visible title text
          ),
          content: const Text(
            'A new version is available. Please update to continue.',
            style: TextStyle(color: Colors.black), // Ensure visible content text
          ),
          backgroundColor: Colors.white, // Ensure background is visible
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
          ),
          actions: [
            TextButton(
              onPressed: () {
                _exitApp();
                if (!completer.isCompleted) completer.complete();
              },
              child: const Text("Close", style: TextStyle(color: Colors.blue)),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Get.offNamed(Routes.mainScreen);
            //     //ifneed-add-to-three-popup-screen-fn's
            //     if (!completer.isCompleted) completer.complete();
            //   },
            //   child: Text("Update"),
            // ),
            TextButton(
              onPressed: () {
                StoreRedirect.redirect(
                  androidAppId: "com.velvetcream.dip",
                  iOSAppId: "1495798783", //  iOS App ID
                );
              },
              child: const Text('Update Now'),
            )
          ],
        );
      },
    );
    return completer.future;
  }

  void _exitApp() {
    Get.back();
    Future.delayed(Duration(milliseconds: 500), () => exit(0));
  }

  requestPermissions() async {
    await PermissionHandler.requestAllPermission();
  }

  themeChecking(){
    if(sharedPrefs.getBool(darkModeKey)==true ||  sharedPrefs.getBool(darkModeKey) == null ){
      Get.changeThemeMode(ThemeMode.dark);
    }else{
      Get.changeThemeMode(ThemeMode.light);
    }
  }
  Future<void> notificationView() async {
    await sessionChecking();
  }

  Future<void> sessionChecking() async {
    Timer(const Duration(seconds: 5), () {
      if (sharedPrefs.getBool(key) == null) {
        initializeFirstTimeEntry();
      }
      sharedPrefs.setInt(bottomBar, 0);
      mainScreen();
    });
    sharedPrefs.setInt(bottomBar, 0);
    SharedPrefs.instance.setInt('privacyPolicy',0);
  }

  void initializeFirstTimeEntry() {
    sharedPrefs.setBool(key, false);
    sharedPrefs.setString("tempToken", generateRandomString());
  }
  void mainScreen() async {
    await requestPermissions();
    Get.offNamed(Routes.mainScreen);
    update();
  }


  String generateRandomString() {
    Random random = Random();
    String characters = '0123456789abcdefghijklmnopqrstuvwxyz';
    return List.generate(
        15, (index) => characters[random.nextInt(characters.length)]).join();
  }
}

class VersionHelper {
  isUpdateAvailable(String current, String latest) {
    var currentParts = int.parse(current.replaceAll('.',''));
    var latestParts =int.parse(latest.replaceAll('.',''));

    if(currentParts<latestParts  ){

      return true;
    }else{
      return false;
    }

    // Ensure both lists have the same length by padding with zeros
    // while (currentParts.length < latestParts.length) {
    //   currentParts.add(0);
    // }
    // while (latestParts.length < currentParts.length) {
    //   latestParts.add(0);
    // }
    //
    // for (int i = 0; i < latestParts.length; i++) {
    //   if (currentParts[i] < latestParts[i]) return true;  // API version is higher → Show dialog
    //   if (currentParts[i] > latestParts[i]) return false; // App version is higher → No dialog
    // }
    return false; // Versions are the same → No dialog
  }
}

class VersionService {
  static Future<String> getLatestVersion() async {
    try {
      final response = await Dio().get(BaseAPI.getAppVersionAPI);   //cartListTaxGetApi
      // final response = await dio.get('https://jsonkeeper.com/b/7S9V');
      // print("check===>API: $response");
      if (response.statusCode == 200) {
        final data = response.data;

        // Ensure 'getVersions' exists and is a list
        if (data.containsKey('getVersions') && data['getVersions'] is List) {
          final List<dynamic> versionList = data['getVersions'];

          if (versionList.isNotEmpty) {
            final versionInfo = versionList[0];

            String? androidVersion = versionInfo['android_version'];
            // String? iosVersion = versionInfo['ios_version'];

            if (androidVersion != null) {
              print("Android Version: $androidVersion");
              return androidVersion;
            }
            // else if (iosVersion != null) {
            //   print("iOS Version: $iosVersion");
            //   return iosVersion;
            // }
            else {
              throw Exception("Missing 'android_version' and 'ios_version' in API response");
            }
          } else {
            throw Exception("Empty 'getVersions' list in API response");
          }
        } else {
          throw Exception("Missing 'getVersions' list in API response");
        }
      } else {
        throw Exception('Failed to load version');
      }
    } catch (e) {
      print("Error fetching version: $e");
      throw Exception('Error fetching version: $e');
    }
  }
}
