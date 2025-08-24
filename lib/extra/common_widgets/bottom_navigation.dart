import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/icon_config.dart';
import '../../presentation/logic/controller/main_controller.dart';
import '../../presentation/routes/routes.dart';
import 'back_button.dart';
import 'floating_icon_button.dart';

//ignore: must_be_immutable
class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key, this.index, this.onTap, this.elevation})
      : super(key: key);
  int? index;
  double? elevation;
  void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          shadowColor: Colors.transparent,
          bottomNavigationBarTheme:
          const BottomNavigationBarThemeData(elevation: 0)),
      child: Container(
          decoration: BoxDecoration(
              color: Theme
                  .of(context)
                  .bottomNavigationBarTheme
                  .backgroundColor,
              border: Border(
                  top: BorderSide(
                      color: Theme
                          .of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor!,
                      width: 3.0))),
          child: BottomNavigationBar(
            elevation: elevation,
            backgroundColor:
            Theme
                .of(context)
                .bottomNavigationBarTheme
                .backgroundColor,
            selectedIconTheme:
            Theme
                .of(context)
                .bottomNavigationBarTheme
                .selectedIconTheme,
            selectedItemColor:
            Theme
                .of(context)
                .bottomNavigationBarTheme
                .selectedItemColor,
            unselectedItemColor:
            Theme
                .of(context)
                .bottomNavigationBarTheme
                .unselectedItemColor,
            unselectedIconTheme:
            Theme
                .of(context)
                .bottomNavigationBarTheme
                .unselectedIconTheme,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: Theme
                .of(context)
                .bottomNavigationBarTheme
                .type,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(ImageAsset.bottomImage1)),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(ImageAsset.rewardIcon)),
                  label: 'Rewards'),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(ImageAsset.bottomImage3)),
                  label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage(ImageAsset.bottomImage4)),
                  label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat, size: 2, color: Colors.transparent),
                  label: ''),
            ],
            currentIndex: index!,
            onTap: onTap,
          )),
    );
  }
}

class FloatingButton extends StatelessWidget {
  FloatingButton({Key? key, this.totalValues}) : super(key: key);

  String? totalValues;

  @override
  Widget build(BuildContext context) {
    return TextScaleFactorClamper(
      child: GetBuilder<MainController>(
        builder: (_) {
          return floatingIcon(
              values: totalValues,
              devicetype: DeviceTypeValues.getDeviceType(),
              onButtonTapped: () {
                Get.toNamed(Routes.cartScreen);
              });
        },
      ),
    );

  }
}

class ProductAppBar extends StatelessWidget {
  ProductAppBar({Key? key, this.press}) : super(key: key);

  void Function()? press;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: AuthBackButton(press: () {
          press!();
        }),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: Image.asset(
                  ImageAsset.appLogo, width: 55.w, height: 4.h))
        ]);
  }
}
