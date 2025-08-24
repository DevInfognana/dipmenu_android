import 'package:dip_menu/extra/packages/linear_progress_bar.dart';
import 'package:dip_menu/extra/packages/scrollable_list_tab_scroller.dart';
import 'package:dip_menu/presentation/pages/rewards_product_preview/widget/dropdown_rewards.dart';
import 'package:dip_menu/presentation/pages/rewards_product_preview/widget/merch_product.dart';
import 'package:dip_menu/presentation/pages/rewards_product_preview/widget/top_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../extra/common_widgets/bottom_navigation.dart';
import '../../../extra/common_widgets/common_product_page_widgets.dart';
import '../../../extra/common_widgets/counter_increment.dart';
import '../../../extra/common_widgets/description_text.dart';
import '../../logic/controller/rewards_product_view_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

class RewardsProductPreviewScreen extends StatefulWidget {
  const RewardsProductPreviewScreen({Key? key}) : super(key: key);

  @override
  State<RewardsProductPreviewScreen> createState() =>
      _RewardsProductPreviewScreenState();
}

class _RewardsProductPreviewScreenState
    extends State<RewardsProductPreviewScreen>
    with SingleTickerProviderStateMixin {
  final rewardsProductPreviewController = Get.find<RewardsProductController>();

  final numberFormat = NumberFormat("#,##0.00##", "en_US");

  @override
  void initState() {
    super.initState();
  }

  onEndScroll(ScrollMetrics metrics) {
    setState(() {
      rewardsProductPreviewController.endPoint = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (rewardsProductPreviewController.favouriteValuesChecking ==
            'favouriteScreen') {
          Get.offAllNamed(Routes.mainScreen, arguments: 2);
        } else {
          Get.back();
        }
        return true;
      },
      child: SafeArea(
          child:  GetBuilder<RewardsProductController>(
              builder: (_) {
                return  HandlingDataView(
                  statusRequest: rewardsProductPreviewController.statusRequestCustomMenu!,
                  widget: TextScaleFactorClamper(
                    child: Scaffold(
                        appBar: PreferredSize(
                            preferredSize: Size.fromHeight(7.5.h),
                            child: ProductAppBar(
                              press: () {
                                if (rewardsProductPreviewController
                                    .favouriteValuesChecking ==
                                    'favouriteScreen') {
                                  Get.offAllNamed(Routes.mainScreen, arguments: 2);
                                } else {
                                  Get.back();
                                }
                              },
                            )),
                        backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
                        body: NotificationListener(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (rewardsProductPreviewController
                                    .customMenu.isNotEmpty) {
                                  if (scrollInfo is UserScrollNotification) {
                                    if (scrollInfo.direction == ScrollDirection.reverse) {
                                      rewardsProductPreviewController.scrollingValues();
                                    }
                                  }
                                } else {
                                  rewardsProductPreviewController.scrollingValues();
                                }
                                return true;
                              },
                              child: rewardsProductPreviewController.categoryIdValues != 5
                                  ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    ProductCard(
                                        imageUrl: rewardsProductPreviewController
                                            .argumentData['image']!,
                                        productName: rewardsProductPreviewController
                                            .argumentData['name'],
                                        priceContent: priceContent(),
                                        isReward: 0,
                                        totalPrizeValues: null,
                                        favouriteContent: favouriteContent(),
                                        addButton: addButton(),
                                        chooseSize: chooseSize(),
                                        productDescription1: productDescription()),
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 4.w,
                                                top: 2.h,
                                                right: 4.w,
                                                bottom: 0.2.h),
                                            child: scrollingTabView())),
                                  ])
                                  : RewardMerchCategory(
                                  rewardsProductPreviewController:
                                  rewardsProductPreviewController),
                            )),
                        floatingActionButton:
                        rewardsProductPreviewController.customMenu.isNotEmpty
                            ? CommonWidget().floatingButton(
                            endPointValues:
                            rewardsProductPreviewController.endPoint,
                            name: NameValues.add,
                            totalLength:
                            rewardsProductPreviewController.productTotal,
                            onViewbuttonpressed: () {
                              bool values = false;
                              if (rewardsProductPreviewController
                                  .customMenu.isNotEmpty) {
                                values = rewardsProductPreviewController
                                    .minimumCheckValues1();
                              } else {
                                values = true;
                              }
                              if (values == false) {
                                ShowDialogBox.alertDialogBox(
                                    context: context,
                                    title: 'Alert',
                                    content: rewardsProductPreviewController
                                        .minCustMenuName
                                        .join(', '),
                                    onButtonTapped: () {
                                      Get.back();
                                    },
                                    cartScreen: 1,
                                    categoryId: rewardsProductPreviewController
                                        .categoryIdValues,
                                    textOkButton: 'OK');
                              } else {
                                rewardsProductPreviewController
                                    .addToCartCalculations();
                              }
                            })
                            : FloatingActionButton.extended(
                            onPressed: () {
                              double subTotal = 0.0;
                              rewardsProductPreviewController
                                  .overAllPriceCalculation()
                                  .forEach((element) {
                                subTotal += double.parse(element);
                              });

                              rewardsProductPreviewController.addCart(
                                  itemPrize: '',
                                  itemID: '',
                                  totalCost: rewardsProductPreviewController
                                      .allProductTotalValues(subTotal),
                                  defaultCustom: 1,
                                  itemNames: '');
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.w)),
                            label: Text(NameValues.add,
                                style: TextStore.textTheme.headlineMedium!
                                    .copyWith(color: Colors.white)),
                            backgroundColor: mainColor),
                    ),
                  ),
                );
              })


         ),
    );
  }

  Widget productName() {
    return Flexible(
        child: Text(rewardsProductPreviewController.argumentData['name'],
            overflow: TextOverflow.clip,
            style: TextStore.textTheme.displaySmall!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.black)));
  }

  Widget priceContent() {
    return GetBuilder<RewardsProductController>(builder: (_) {
      return Text(
          '${rewardsProductPreviewController.priceCalculation1(rewardsProductPreviewController.productQuality.toInt(), rewardsProductPreviewController.totalPrice)} pts',
          style: TextStore.textTheme.displaySmall?.copyWith(color: mainColor));
    });
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  Widget addButton() {
    return GetBuilder<RewardsProductController>(builder: (_) {
      Color? color = Get.isDarkMode ? Colors.white : borderColor;
      return HandlingDataView(
          statusRequest:
              rewardsProductPreviewController.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                rewardsProductPreviewController.increaseCount();
              },
              onDecrementSelected: () {
                rewardsProductPreviewController.decreaseCount();
              },
              label: Text(
                rewardsProductPreviewController.productQuality.toString(),
                style: TextStore.textTheme.displaySmall
                    ?.copyWith(color: color, fontWeight: FontWeight.bold),
              )));
    });
  }

  Widget favouriteContent() {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (rewardsProductPreviewController.isFavourite == true) {
              rewardsProductPreviewController.favouriteValues =
                  'favouriteScreen';
              rewardsProductPreviewController.isFavourite = false;
              rewardsProductPreviewController.removeFavourite(
                  productCode: rewardsProductPreviewController.productID!);
            } else if (rewardsProductPreviewController.isFavourite == false) {
              rewardsProductPreviewController.favouriteValues =
                  'favouriteScreen';
              rewardsProductPreviewController.isFavourite = true;
              rewardsProductPreviewController.someFavouriteValuesChecking();
            }
          });
        },
        child: SizedBox(
            height: 5.h,
            width: 12.w,
            child: Icon(
                rewardsProductPreviewController.isFavourite == true
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: getDeviceType() == 'phone' ? 26.sp : 13.sp,
                color: rewardsProductPreviewController.isFavourite == true
                    ? Colors.red
                    : Colors.grey)));
  }

  Widget productDescription() {
    return GetBuilder<RewardsProductController>(builder: (_) {
      return rewardsProductPreviewController.productDescription!.isEmpty
          ? const SizedBox()
          : Text(rewardsProductPreviewController.productDescription!,
          style: TextStore.textTheme.titleLarge!.copyWith(
              color: Get.isDarkMode ? Colors.white : borderColor)
      );
      // ExpandableText(
      //         rewardsProductPreviewController.productDescription == null
      //             ? ''
      //             : rewardsProductPreviewController.productDescription!,
      //         trimLines: 1);
    });
  }

  Widget chooseSize() {
    return Padding(
        padding: EdgeInsets.only(left: 3.w, right: 2.w, top: 1.w),
        child: HandlingDataView(
            statusRequest:
                rewardsProductPreviewController.statusRequestProductPreview!,
            widget: RewardsDropdownMethod(
                controller: rewardsProductPreviewController,
                onViewbuttonpressed: (dynamic) {
                  rewardsProductPreviewController.handleDropdownSelection(
                      item: rewardsProductPreviewController
                          .dropdownChooseingValues(dynamic));
                })));
  }

  Widget verticalBar() {
    return Obx(() => SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              rewardsProductPreviewController
                  .customMenu[
                      rewardsProductPreviewController.productIndex.toInt()]
                  .name!,
              style: TextStore.textTheme.titleMedium!.copyWith(
                  color: Colors.transparent, fontWeight: FontWeight.bold)),
          rewardsProductPreviewController.isWeightCheck != '1' &&
                  rewardsProductPreviewController.hybridProduct != 1
              ? VerticalBarIndicator(
                  percent: rewardsProductPreviewController.valuesChanges(
                      rewardsProductPreviewController.productIndex.toInt(),
                      'productValues'),
                  height: 1.h,
                  animationDuration: const Duration(seconds: 3),
                  color: const [Colors.limeAccent, Colors.green],
                  header:
                      '${(rewardsProductPreviewController.valuesChanges(rewardsProductPreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
                  footer: '',
                  footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                      fontSize: 9.sp,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                      fontSize: 9.sp,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  width: 40.w)
              : (rewardsProductPreviewController.hybridProduct == 1
                  ? VerticalBarIndicator(
                      percent: rewardsProductPreviewController.valuesChanges(
                          rewardsProductPreviewController.productIndex.toInt(),
                          'productValues'),
                      height: 1.h,
                      animationDuration: const Duration(seconds: 3),
                      color: const [Colors.limeAccent, Colors.green],
                      header:
                          '${(rewardsProductPreviewController.valuesChanges(rewardsProductPreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
                      footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                        fontSize: 9.sp,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                        fontSize: 9.sp,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      width: 53.w)
                  : VerticalBarIndicator(
                      percent: rewardsProductPreviewController.lineGraphValues,
                      height: 1.h,
                      animationDuration: const Duration(seconds: 3),
                      color: const [Colors.limeAccent, Colors.green],
                      header:
                          '${(rewardsProductPreviewController.lineGraphValues * 100).toStringAsFixed(2)} %',
                      footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      width: 53.w))
        ])));
  }

  scrollingTabView() {
    return ScrollableListTabScrollerView(
      tabBuilder: (BuildContext context, int index, bool active) => Container(
          color: Get.isDarkMode
              ? (Colors.transparent)
              : (rewardsProductPreviewController.customMenu.length <= 1
                  ? Colors.transparent
                  : Colors.grey.shade100),
          height: 9.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(rewardsProductPreviewController.customMenu[index].name!,
              style: !active
                  ? TextStore.textTheme.headlineMedium?.copyWith(
                      color: descriptionColor, fontWeight: FontWeight.bold)
                  : TextStore.textTheme.headlineMedium?.copyWith(
                      color: mainColor, fontWeight: FontWeight.bold))),
      itemCount: rewardsProductPreviewController.customMenu.length,
      addingWidget: verticalBar(),
      tabChanged: (int values) {
        rewardsProductPreviewController.valuesChanges(values, '');
      },
      itemBuilder: (BuildContext context, int index) {
        final size = rewardsProductPreviewController
            .minMaxShow(rewardsProductPreviewController.customMenu[index].id);
        return Column(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: MenuCategoryItem1(
              title: rewardsProductPreviewController.customMenu[index].name!,
              customMenuItemValues: rewardsProductPreviewController
                  .customMenu[index].customMenuItems!,
              minMaxValues: size,
              controller: rewardsProductPreviewController,
              customProductsValues: rewardsProductPreviewController
                  .customMenu[index].customProducts!,
              customizeMenuItems: rewardsProductPreviewController
                  .customMenu[index].customizeMenuItems,
              selectedItems: rewardsProductPreviewController
                  .customMenu[index].selectedItems,
              isHybrid:
                  rewardsProductPreviewController.customMenu[index].isHybrid,
              customMenuId:
                  rewardsProductPreviewController.customMenu[index].id,
            ),
          ),
          index == rewardsProductPreviewController.customMenu.length - 1
              ? SizedBox(height: getDeviceType() == 'phone' ? 30.h : 35.h)
              : const SizedBox()
        ]);
      },
    );
  }
}
