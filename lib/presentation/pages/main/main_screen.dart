import 'package:dip_menu/core/config/app_textstyle.dart';
import 'package:dip_menu/data/model/home/category/category_data_model.dart';
import 'package:dip_menu/extra/common_widgets/back_button.dart';
import 'package:dip_menu/extra/common_widgets/image_view.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
// import 'package:dual_screen/dual_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../core/config/theme.dart';
import '../../../domain/entities/handling_data_view.dart';
import '../../logic/controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find();

  @override
  void dispose() {
    // homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//     bool singleScreen = MediaQuery.of(context).hinge == null && MediaQuery.of(context).size.width < 1000;
// print('----->$singleScreen');
// print('----->${MediaQuery.of(context).size.width}');
// print('----->${MediaQuery.of(context).displayFeatures}');
//     DualScreenInfo.hasHingeAngleSensor.then((bool hasHingeSensor) {
//       print('--has sensor $hasHingeSensor');
//     });
// print('----->${MediaQuery.of(context).devicePixelRatio}');
    return GetBuilder<HomeController>(builder: (_) {
      return HandlingDataView(
        statusRequest: homeController.statusRequestBanner,
        widget: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // body:  TwoPane(
          //   startPane: GestureDetector(
          //   onTap: () {
          //     var data = {
          //       'id': homeController.homeCategoryList[1].id,
          //       'name': homeController.homeCategoryList[1].name,
          //       'image':
          //       homeController.homeCategoryList[1].image
          //     };
          //     Get.toNamed(Routes.subCategoryScreen,
          //                             arguments: data);
          //   },
          //     child: HomeScreenCardView(
          //                     categoryData:
          //                         homeController.homeCategoryList[1])
          //   ),
          //   endPane: HomeScreenCardView(
          //       categoryData:
          //       homeController.homeCategoryList[4]),
          //   panePriority: singleScreen ? TwoPanePriority.start : TwoPanePriority.end,
          //   paneProportion: 0.33,
          //   padding: EdgeInsets.only(
          //       top: kToolbarHeight + MediaQuery.of(context).padding.top),
          // ),
          body: TextScaleFactorClamper(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 6.h,
                  padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Wrap(children: [
                    Image.asset(ImageAsset.appLogo, width: 55.w, height: 4.h)
                  ]),
                ),
                Flexible(
                  child: ListView.builder(
                    itemCount: homeController.homeCategoryList.length,
                    padding: EdgeInsets.all(2.w),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext buildContext, int index) {
                      return GestureDetector(
                        onTap: () {
                          var data = {
                            'id': homeController.homeCategoryList[index].id,
                            'name': homeController.homeCategoryList[index].name,
                            'image':
                                homeController.homeCategoryList[index].image
                          };
                          Get.toNamed(Routes.subCategoryScreen,
                              arguments: data);
                        },
                        child: HomeScreenCardView(
                            categoryData:
                                homeController.homeCategoryList[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: /*GetBuilder<HomeController>(builder: (_) {*/
              TextScaleFactorClamper(
            child: checkingOrderSTATUS(context),
          ),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        ),
      );
    });
  }

  checkingOrderSTATUS(BuildContext context) {
    Widget? alertDialogValues;
    alertDialogValues = Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: darkSeafoamGreen1,
            fixedSize: Size(30.w, 4.h),
            textStyle:
            TextStore.textTheme.headlineSmall!.copyWith(color: Colors.white),
            elevation: 6),
        onPressed: () {
          if (SharedPrefs.instance.getString('token') != null) {
            if(homeController.statusRequestRecentOrder==StatusRequest.success){
              homeController.mobileOrder(values: 0);
            }
          } else {
            homeController.emptyListDialog(context);
          }
        },
        child: TextScaleFactorClamper(child: Text('Check-in',
          style: TextStore.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontSize: 11.sp, // Use scalable pixels (sp) if available
            fontWeight: FontWeight.w500,
          ),)),
      ),
    );

    return alertDialogValues;
  }
}

class HomeScreenCardView extends StatelessWidget {
  HomeScreenCardView({Key? key, this.categoryData}) : super(key: key);

  CategoryModelData? categoryData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.all(0.0.h),
      elevation: 0,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(0.5.h),
                    child: Text(
                      categoryData!.name!,
                      style: context.theme.textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(width: 3.w),
              FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  height: 13.3.h,
                  width: getDeviceType() == 'phone' ? 27.w : 23.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.w),
                    child: ImageView(
                      imageUrl: imageview(categoryData!.image!),
                      showValues: false,
                      mainImageViewWidth: 34.w,
                      bottomImageViewHeight: 3.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 0.5.h, right: 0.5.h),
              child: DividerView(values: 1)),
        ],
      ),
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}
