import 'package:dip_menu/extra/packages/linear_progress_bar.dart';
import 'package:dip_menu/presentation/logic/controller/customize_edit_controller.dart';
import 'package:dip_menu/presentation/pages/product_preview/cutomize_edit_screen/widget/customize_dropdown.dart';
import 'package:dip_menu/presentation/pages/product_preview/cutomize_edit_screen/widget/customize_edit_view.dart';
import 'package:dip_menu/presentation/pages/product_preview/cutomize_edit_screen/widget/merch_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../extra/common_widgets/bottom_navigation.dart';
import '../../../../extra/common_widgets/common_product_page_widgets.dart';
import '../../../../extra/common_widgets/counter_increment.dart';
import '../../../../extra/common_widgets/description_text.dart';
import '../../../../extra/common_widgets/fav_login_alert_dialog.dart';
import '../../../../extra/packages/scrollable_list_tab_scroller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

class CustomizeProductPreviewScreen extends StatefulWidget {
  const CustomizeProductPreviewScreen({Key? key}) : super(key: key);

  @override
  State<CustomizeProductPreviewScreen> createState() =>
      _CustomizeProductPreviewScreenState();
}

class _CustomizeProductPreviewScreenState
    extends State<CustomizeProductPreviewScreen>
    with SingleTickerProviderStateMixin {
  final customizeProductPreviewController = Get.find<CustomizeEditController>();

  final numberFormat = NumberFormat("#,##0.00##", "en_US");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(7.5.h),
                child: ProductAppBar(
                  press: () {
                    Get.back();
                  },
                )),
            backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
            body: TextScaleFactorClamper(
              child: GetBuilder<CustomizeEditController>(
                builder: (_) {
                  return HandlingDataView(
                      statusRequest: customizeProductPreviewController
                          .statusRequestCustomMenu!,
                      widget: NotificationListener(
                          child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (customizeProductPreviewController
                              .customMenu.isNotEmpty) {
                            if (scrollInfo is UserScrollNotification) {
                              if (scrollInfo.direction ==
                                  ScrollDirection.reverse) {
                                customizeProductPreviewController
                                    .scrollingValues();
                              }
                            }
                          } else {
                            customizeProductPreviewController.scrollingValues();
                          }
                          return true;
                        },
                        child: customizeProductPreviewController
                                    .categoryIdValues !=
                                5
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                    ProductCard(
                                        imageUrl:
                                            customizeProductPreviewController
                                                .argumentData['image']!,
                                        productName:
                                            customizeProductPreviewController
                                                .argumentData['name'],
                                        priceContent: priceContent(),
                                        isReward: 1,
                                        totalPrizeValues: totalPrizeValues(),
                                        favouriteContent: favouriteContent(),
                                        addButton: addButton(),
                                        chooseSize: chooseSize(),
                                        productDescription1:
                                            productDescription()),
                                    customizeProductPreviewController
                                                .customMenuBoolValues.value ==
                                            false
                                        ? Expanded(
                                            child: Container(
                                                // alignment: Alignment.center,
                                                padding: EdgeInsets.only(
                                                    left: 4.w,
                                                    top: 2.h,
                                                    right: 4.w,
                                                    bottom: 0.2.h),
                                                child: scrollingTabView()))
                                        : const SizedBox(),
                                  ])
                            : CustomMerchCategory(
                                customizeEditController:
                                    customizeProductPreviewController),
                      )));
                },
              ),
            ),
            floatingActionButton:
                GetBuilder<CustomizeEditController>(builder: (_) {
              return HandlingDataView(
                  statusRequest: customizeProductPreviewController
                      .statusRequestCustomMenu!,
                  widget: TextScaleFactorClamper(
                    child: TextScaleFactorClamper(
                        child: customizeProductPreviewController
                                .customMenu.isNotEmpty
                            ? CommonWidget().floatingButton(
                                endPointValues:
                                    customizeProductPreviewController.endPoint,
                                totalLength: customizeProductPreviewController
                                    .productTotal,
                                onViewbuttonpressed: () {
                                  final bool values =
                                      customizeProductPreviewController
                                          .minimumCheckValues();

                                  if (values == false) {
                                    ShowDialogBox.alertDialogBox(
                                        context: context,
                                        title: 'Alert',
                                        content:
                                            customizeProductPreviewController
                                                .minCustMenuName
                                                .join(', '),
                                        onButtonTapped: () {
                                          Get.back();
                                        },
                                        cartScreen: 1,
                                        categoryId:
                                            customizeProductPreviewController
                                                .categoryIdValues,
                                        textOkButton: 'OK');
                                  } else {
                                    customizeProductPreviewController
                                        .addToCartCalculations();
                                  }
                                },
                                name: NameValues.update)
                            : FloatingActionButton.extended(
                                onPressed: () {
                                  double subTotal = 0.0;
                                  customizeProductPreviewController
                                      .overAllPriceCalculation()
                                      .forEach((element) {
                                    subTotal += double.parse(element);
                                  });
                                  customizeProductPreviewController.addCart(
                                      itemPrize: '0',
                                      itemID: '',
                                      totalCost:
                                          customizeProductPreviewController
                                              .allProductTotalValues(subTotal),
                                      defaultCustom: 1,
                                      itemNames: '');
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3.w)),
                                extendedPadding: EdgeInsets.all(5.w),
                                label: Text(NameValues.productupdate,
                                    style: TextStore.textTheme.headlineMedium!
                                        .copyWith(color: Colors.white)),
                                backgroundColor: mainColor)),
                  ));
            })));
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  Widget priceContent() {
    return customizeProductPreviewController.slashedPrice == 0.0
        ? const SizedBox()
        : GetBuilder<CustomizeEditController>(builder: (_) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 1.w,
                  right: 1.w,
                  bottom: customizeProductPreviewController
                          .productDescription!.isEmpty
                      ? 0
                      : 0.h),
              child: Text(
                  '\$ ${numberFormat.format(customizeProductPreviewController.slashedPrice)}',
                  style: TextStore.textTheme.displaySmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w300,
                      color: mainColor)),
            );
          });
  }

  Widget onlinePriceContent() {
    return GetBuilder<CustomizeEditController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
            left: 5.w,
            right: 1.w,
            bottom:
                customizeProductPreviewController.productDescription!.isEmpty
                    ? 0
                    : 0.h),
        child: customizeProductPreviewController.defaultPrice == 0.0
            ? Text(
                '\$ ${numberFormat.format(customizeProductPreviewController.priceCalculation1(1, double.parse(customizeProductPreviewController.defaultPrice.toStringAsFixed(2))))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green))
            : Text(
                '\$ ${numberFormat.format(double.parse(customizeProductPreviewController.defaultPrice.toStringAsFixed(2)))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green)),
      );
    });
  }

  Widget totalPrizeValues() {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GetBuilder<CustomizeEditController>(builder: (_) {
          String values = customizeProductPreviewController
              .priceCalculation1(
                  customizeProductPreviewController.custProductQuanity.toInt(),
                  customizeProductPreviewController.defaultPrice)
              .toStringAsFixed(2);

          return Text('\$ ${numberFormat.format(double.parse(values))}',
              style: TextStore.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w900, color: Colors.green));
        })
      ],
    );
  }

  Widget addButton() {
    return GetBuilder<CustomizeEditController>(builder: (_) {
      Color? color = Get.isDarkMode ? Colors.white : borderColor;
      return HandlingDataView(
          statusRequest:
              customizeProductPreviewController.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                customizeProductPreviewController.increaseCount();
              },
              onDecrementSelected: () {
                customizeProductPreviewController.decreaseCount();
              },
              label: Text(
                customizeProductPreviewController.custProductQuanity.toString(),
                style: TextStore.textTheme.displaySmall
                    ?.copyWith(color: color, fontWeight: FontWeight.bold),
              )));
    });
  }

  Widget favouriteContent() {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (SharedPrefs.instance.getString('token') != null) {
              if (customizeProductPreviewController.isFavourite == true) {
                customizeProductPreviewController.favouriteValues =
                    'favouriteScreen';
                customizeProductPreviewController.isFavourite = false;
                customizeProductPreviewController.removeFavourite(
                    productCode: customizeProductPreviewController.productID!);
              } else if (customizeProductPreviewController.isFavourite ==
                  false) {
                customizeProductPreviewController.favouriteValues =
                    'favouriteScreen';
                customizeProductPreviewController.isFavourite = true;
                customizeProductPreviewController.someFavouriteValuesChecking();
              }
            } else {
              FavLoginPopUp().showFavLoginAlertDialog(context,
                  userNameController:
                      customizeProductPreviewController.emailController,
                  passWordController: customizeProductPreviewController
                      .passwordController, onButtonTapped: () {
                String email = customizeProductPreviewController
                    .emailController.text
                    .trim();
                String password = customizeProductPreviewController
                    .passwordController.text
                    .trim();
                customizeProductPreviewController.productPreviewFavLogin(
                    email: email,
                    password: password,
                    productCode: customizeProductPreviewController.productID!,
                    status: '0');
              });
            }
          });
        },
        child: SizedBox(
            height: 5.h,
            width: 12.w,
            child: Icon(
                customizeProductPreviewController.isFavourite == true
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: getDeviceType() == 'phone' ? 26.sp : 13.sp,
                color: customizeProductPreviewController.isFavourite == true
                    ? Colors.red
                    : Colors.grey)));
  }

  Widget productDescription() {
    return GetBuilder<CustomizeEditController>(builder: (_) {
      Color? color = Get.isDarkMode ? Colors.white : borderColor;
      return customizeProductPreviewController.productDescription!.isEmpty
          ? const SizedBox()
          : Text(customizeProductPreviewController.productDescription!,
          style: TextStore.textTheme.titleLarge!.copyWith(color: color))
      // (customizeProductPreviewController.productDescription!.length < 64
      //         ?
      //         : ExpandableText(
      //             customizeProductPreviewController.productDescription == null
      //                 ? ''
      //                 : customizeProductPreviewController.productDescription!,
      //             trimLines: 1,
      //           ))
      ;
    });
  }

  Widget chooseSize() {
    return Padding(
        padding: EdgeInsets.only(left: 3.w, right: 2.w, top: 1.w),
        child: HandlingDataView(
            statusRequest:
                customizeProductPreviewController.statusRequestProductPreview!,
            widget: CustomizeDropdown(
                controller: customizeProductPreviewController,
                onViewbuttonpressed: (dynamic) {
                  customizeProductPreviewController.handleDropdownSelection(
                      item: customizeProductPreviewController
                          .dropdownChooseingValues(dynamic));
                })));
  }

  Widget verticalBar() {
    return Obx(() => SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              customizeProductPreviewController
                  .customMenu[
                      customizeProductPreviewController.productIndex.toInt()]
                  .name!,
              style: TextStore.textTheme.titleMedium!.copyWith(
                  color: Colors.transparent, fontWeight: FontWeight.bold)),
          customizeProductPreviewController.isWeightCheck != '1' &&
                  customizeProductPreviewController.hybridProduct != 1
              ? VerticalBarIndicator(
                  percent: customizeProductPreviewController.valuesChanges(
                      customizeProductPreviewController.productIndex.toInt(),
                      'productValues'),
                  height: 1.h,
                  animationDuration: const Duration(seconds: 3),
                  color: const [Colors.limeAccent, Colors.green],
                  header:
                      '${(customizeProductPreviewController.valuesChanges(customizeProductPreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
                  footer: '',
                  footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                      fontSize: 9.sp,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                      fontSize: 9.sp,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  width: 40.w)
              : (customizeProductPreviewController.hybridProduct == 1
                  ? VerticalBarIndicator(
                      percent: customizeProductPreviewController.valuesChanges(
                          customizeProductPreviewController.productIndex
                              .toInt(),
                          'productValues'),
                      height: 1.h,
                      animationDuration: const Duration(seconds: 3),
                      color: const [Colors.limeAccent, Colors.green],
                      header:
                          '${(customizeProductPreviewController.valuesChanges(customizeProductPreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
                      footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      width: 53.w)
                  : VerticalBarIndicator(
                      percent:
                          customizeProductPreviewController.lineGraphValues,
                      height: 1.h,
                      animationDuration: const Duration(seconds: 3),
                      color: const [Colors.limeAccent, Colors.green],
                      header:
                          '${(customizeProductPreviewController.lineGraphValues * 100).toStringAsFixed(2)} %',
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
      physics: const BouncingScrollPhysics(),
      tabBuilder: (BuildContext context, int index, bool active) => Container(
        color: Get.isDarkMode
            ? (Colors.transparent)
            : (customizeProductPreviewController.customMenu.length <= 1
                ? Colors.transparent
                : Colors.grey.shade100),
        height: 9.h,
        width: customizeProductPreviewController.customMenu.length <= 1
            ? MediaQuery.of(context).size.width
            : null,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Text(
          customizeProductPreviewController.customMenu[index].name!,
          style: !active
              ? TextStore.textTheme.headlineMedium?.copyWith(
                  color: descriptionColor, fontWeight: FontWeight.bold)
              : TextStore.textTheme.headlineMedium
                  ?.copyWith(color: mainColor, fontWeight: FontWeight.bold),
        ),
      ),
      itemCount: customizeProductPreviewController.customMenu.length,
      tabChanged: (int values) {
        customizeProductPreviewController.valuesChanges(values, '');
      },
      addingWidget: verticalBar(),
      itemBuilder: (BuildContext context, int index) {
        final size = customizeProductPreviewController
            .minMaxShow(customizeProductPreviewController.customMenu[index].id);
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: CusMenuCategoryItem(
                title:
                    customizeProductPreviewController.customMenu[index].name!,
                customMenuId:
                    customizeProductPreviewController.customMenu[index].id,
                customMenuItemValues: customizeProductPreviewController
                    .customMenu[index].customMenuItems!,
                minMaxValues: size,
                controller: customizeProductPreviewController,
                customProductsValues: customizeProductPreviewController
                    .customMenu[index].customProducts!,
                customizeMenuItems: customizeProductPreviewController
                    .customMenu[index].customizeMenuItems,
                isHybrid: customizeProductPreviewController
                    .customMenu[index].isHybrid,
                selectedItems: customizeProductPreviewController
                    .customMenu[index].selectedItems,
              ),
            ),
            index == customizeProductPreviewController.customMenu.length - 1
                ? SizedBox(height: getDeviceType() == 'phone' ? 24.h : 34.h)
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
