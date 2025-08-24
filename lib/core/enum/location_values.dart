//
// //
// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geolocator_apple/geolocator_apple.dart';
// import 'package:geolocator_android/geolocator_android.dart';
// import 'dart:math' show cos, sqrt, asin;
//
// // _getCurrentLocation() {
// //   Position? currentPosition;
// //
// //   Geolocator
// //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
// //       .then((Position position) {
// //     currentPosition = position;
// //   }).catchError((e) {
// //     print(e);
// //   });
// //   return  currentPosition;
// // }
//
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_apple/geolocator_apple.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'dart:math' show cos, sqrt, asin;

// _getCurrentLocation() {
//   Position? currentPosition;
//
//   frequentlyChecking() {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       locationSettings = AndroidSettings(
//           accuracy: LocationAccuracy.medium,
//           distanceFilter: 100,
//           forceLocationManager: true,
//           intervalDuration: const Duration(seconds: 20));
//     } else if (defaultTargetPlatform == TargetPlatform.iOS ||
//         defaultTargetPlatform == TargetPlatform.macOS) {
//       locationSettings = AppleSettings(
//           accuracy: LocationAccuracy.medium,
//           activityType: ActivityType.fitness,
//           distanceFilter: 100,
//           pauseLocationUpdatesAutomatically: true,
//           showBackgroundLocationIndicator: true);
//     } else {
//       locationSettings = const LocationSettings(
//           accuracy: LocationAccuracy.medium, distanceFilter: 100);
//     }
//   }
// }

class LocationChecking {
  LocationSettings? locationSettings;

  frequentlyChecking() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.medium,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 20));
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
          accuracy: LocationAccuracy.medium,
          activityType: ActivityType.fitness,
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
          showBackgroundLocationIndicator: true);
    } else {
      locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.medium, distanceFilter: 100);
    }
  }



  static checkPermissionsAndGetLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // Check and request location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }else if(permission == LocationPermission.deniedForever){
      permission = await Geolocator.requestPermission();
    }
  }
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a)) * 1000;
}
