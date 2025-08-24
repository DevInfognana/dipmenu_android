import 'package:dip_menu/core/static/stactic_values.dart';
import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:dip_menu/presentation/logic/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
// import 'package:upgrader/upgrader.dart';

import '../../../core/config/app_textstyle.dart';
import '../../../core/config/icon_config.dart';
import '../../../core/config/theme.dart';

// import '../../../domain/local_handler/Local_handler.dart';
import '../../../extra/common_widgets/bottom_navigation.dart';

// import '../../../extra/common_widgets/floating_icon_button.dart';
import '../../logic/controller/connection_manager_controller.dart';
import '../../logic/controller/favourite_controller.dart';
import '../../logic/controller/profile_controller.dart';

// import '../../logic/controller/dim_menu_search_controller.dart';
import '../../logic/controller/rewards_controller.dart';
import 'dart:io' show Platform;
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeController = Get.find<MainController>();
  final favController = Get.find<FavouriteController>();
  final rewardController = Get.find<RewardsController>();

  // final searchController = Get.find<DipMenuSearchController>();
  final profileController = Get.find<ProfileController>();
  final ConnectionManagerController controller =
      Get.find<ConnectionManagerController>();
  PageController page = PageController(initialPage: 0);
  bool outValue = false;

  @override
  void initState() {
    homeController.cartListApi();
    super.initState();
    initializeBackgroundService();
  }

  void initializeBackgroundService() {
    if (controller.connectionType.value == 0) {
      FlutterBackgroundService().invoke("stopService");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return controller.connectionType.value != 0
            ? buildConnectedScaffold()
            : buildDisconnectedScaffold();
      }),
    );
  }

  buildConnectedScaffold() {
    return GetBuilder<MainController>(builder: (controller) {
      return WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            body: IndexedStack(
              index: homeController.selectedIndex,
              children: homeController.tabs,
            ),
            bottomNavigationBar: BottomNavigation(
                elevation: 0,
                onTap: homeController.onItemTapped,
                index: homeController.selectedIndex),
            floatingActionButton: FloatingButton(
              totalValues: homeController.totalCount.toString(),
            ),
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
            FloatingActionButtonLocation.endDocked,
          ),
      );
    });
  }

  Scaffold buildDisconnectedScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TextScaleFactorClamper(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                Image.asset(
                  ImageAsset.noConnection,
                  width: double.infinity,
                  height: 50.h,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  onPressed: () {
                    controller.getConnectivityType();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    textStyle: context.theme.textTheme.headlineMedium!
                        .copyWith(color: Colors.black),
                  ),
                  child: Text(NameValues.tryAgain,style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    setState(() {
      if (homeController.selectedIndex == 0) {
        FlutterBackgroundService().startService();
        FlutterBackgroundService().invoke("setAsBackground");
        outValue = true;
      } else {
        outValue = false;
        homeController.selectedIndex = 0;
      }
    });
    return outValue;
  }
}
