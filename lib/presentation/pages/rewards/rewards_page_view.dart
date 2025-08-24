// import 'package:dip_menu/core/config/icon_config.dart';

// import 'package:dip_menu/extra/common_widgets/bottom_navigation.dart';
import 'package:dip_menu/presentation/pages/rewards/widget/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../extra/common_widgets/empty_widget.dart';

// import '../../../extra/common_widgets/floating_icon_button.dart';
import '../../logic/controller/main_controller.dart';

// import '../../logic/controller/profile_controller.dart';
import '../../logic/controller/rewards_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

// import '../../logic/controller/dim_menu_search_controller.dart';
// import '../../routes/routes.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final rewardsController = Get.find<RewardsController>();
  final homeController = Get.find<MainController>();

  final numberFormat = NumberFormat("#,##0.00##", "en_US");

  @override
  void initState() {
    homeController.cartListApi();
    super.initState();
  }

  String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SharedPrefs.instance.getString('token') != null
            ? rewardProductView()
            : buildDisconnectedScaffold());
  }

  rewardProductView() {
    return SafeArea(child: GetBuilder<RewardsController>(builder: (_) {
      return HandlingDataView(
          statusRequest: rewardsController.statusRequestRewards,
          widget: TextScaleFactorClamper(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(10.h),
                child: AppBar(
                    leading: AuthBackButton(
                      press: () {
                        if (SharedPrefs.instance.getInt('bottomBar') == 3) {
                          Get.back();
                        } else {
                          Get.offAllNamed(Routes.mainScreen, arguments: 0);
                        }
                      },
                    ),
                    centerTitle: true,
                    title: AuthTitleText(text: NameValues.rewardsProduct)),
              ),
              body: WillPopScope(
                onWillPop: () {
                  return homeController.willpopscope();
                },
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          rewardView(),
                          rewardsController.rewardsProductList.isNotEmpty
                              ? RewardsCardView(
                                  rewardsController: rewardsController)
                              : emptyWidget(
                                  NameValues.nothingInYourRewardProducts)
                        ],
                      ),
                    )),
              ),
              // bottomNavigationBar: BottomNavigation(
              //     onTap: homeController.onItemTapped1,
              //     index: homeController.selectedIndex),
              // floatingActionButton: floatingIcon(
              //     values: homeController.totalCount.toString(),
              //     devicetype: getDeviceType(),
              //     onButtonTapped: () {
              //       Get.toNamed(Routes.cartScreen);
              //     }),
              // resizeToAvoidBottomInset: false,
              // floatingActionButtonLocation:
              //     FloatingActionButtonLocation.endDocked,
            ),
          ));
    }));
  }

  rewardView() {
    int values = 0;
    if (SharedPrefs.instance.getInt('rewards') == 0 &&  SharedPrefs.instance.getInt('rewards')==null ) {
      values = 0;
    } else {
      values = SharedPrefs.instance.getInt('rewards')?? 0;
    }
    return Text( '   Your Reward points : $values', style: context.theme.textTheme.headlineMedium
          ?.copyWith(fontWeight: FontWeight.bold));
    // return  Card(
    //   // semanticContainer: true,
    //   clipBehavior: Clip.antiAliasWithSaveLayer,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(10.0),
    //   ),
    //   elevation: 5,
    //   // margin: const EdgeInsets.all(10),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: [
    //     Wrap(
    //       direction: Axis.vertical,
    //       children: [
    //         Text('     $values',style: context.theme.textTheme.headlineMedium
    //           ?.copyWith(fontWeight: FontWeight.bold)),
    // Text( '      rewards points ', style: context.theme.textTheme.headlineMedium
    //         ?.copyWith(fontWeight: FontWeight.bold))
    //
    //       ],
    //     ),
    //     Image.asset(ImageAsset.rewardView, width: 40.w,height: 40.h,),
    //
    //   ],),
    //
    //   // child:  Image.asset(ImageAsset.rewardView,),
    //   //rewardView
    //   // child: Wrap(
    //   //   // direction: Axis.horizontal,
    //   //   children: [
    //   //
    //   // Text( '   Your are earned rewards points : $values', style: context.theme.textTheme.headlineMedium
    //   //       ?.copyWith(fontWeight: FontWeight.bold))
    //   //
    //   //   ],
    //   // ),
    //   // child:
    // );
  }

  Scaffold buildDisconnectedScaffold() {
    return Scaffold(
      body: TextScaleFactorClamper(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //You have not logged in. Please click here to log in. It will display your reward products.

                Text('You have not logged in. ',
                    style: context.theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Please ",
                          style: context.theme.textTheme.headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold)),
                      WidgetSpan(
                          child: GestureDetector(
                        onTap: () {
                          Get.offNamed(Routes.loginScreen);
                        },
                        child: Text('Click here to login.',
                            style: context.theme.textTheme.headlineMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dashed,
                                fontWeight: FontWeight.bold)),
                      )),
                    ],
                  ),
                ),
                Text('It will display your reward products',
                    style: context.theme.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                // Text('welcome'),

                // Container(
                //   width: double.infinity,
                //   height: 50.h,
                //   decoration:  BoxDecoration(
                //   color: Theme.of(context).scaffoldBackgroundColor,
                //   image: const DecorationImage(image: AssetImage(ImageAsset.notLoginIcon),  fit: BoxFit.fill,)
                // ),),
                // Image.asset(
                //   ImageAsset.notLoginIcon,
                //   width: double.infinity,
                //   height: 50.h,
                //   fit: BoxFit.fill,
                // ),
                // SizedBox(height: 2.h),
                // ElevatedButton(
                //   onPressed: () {
                //     controller.getConnectivityType();
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: mainColor,
                //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                //     textStyle: TextStore.textTheme.headlineMedium!.copyWith(
                //         color: Colors.black),
                //   ),
                //   child: Text(NameValues.tryAgain),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
