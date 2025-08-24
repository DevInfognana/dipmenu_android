import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectionManagerController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  var connectionType = 0.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    // late ConnectivityResult connectivityResult;
    // instead of the above commented deprecated code
    late List<ConnectivityResult> connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  // _updateState(ConnectivityResult result) {
  _updateState(List<ConnectivityResult> results) {  // Changed parameter type to List<ConnectivityResult>
    // Take the first result from the list (primary connection)
    final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
      switch (result) {
        case ConnectivityResult.wifi:
          connectionType.value = 1;
          break;
        case ConnectivityResult.mobile:
          connectionType.value = 2;

          break;
        case ConnectivityResult.none:
          connectionType.value = 0;
          break;
        default:
          connectionType.value = 0;
          // Get.snackbar(
          //   'Error',
          //   'Failed to get connection type',
          // );
          break;
      }
    }

    @override
    void onClose() {
      _streamSubscription.cancel();
    }

}
