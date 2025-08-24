import 'package:dip_menu/extra/common_widgets/bottom_navigation.dart';
import 'package:dip_menu/extra/packages/linear_progress_bar.dart';
import 'package:dip_menu/extra/packages/scrollable_list_tab_scroller.dart';
import 'package:dip_menu/presentation/pages/product_preview/widget/dropdown_button.dart';
import 'package:dip_menu/presentation/pages/product_preview/widget/merch_category.dart';
import 'package:dip_menu/presentation/pages/product_preview/widget/top_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../extra/common_widgets/common_product_page_widgets.dart';
import '../../../extra/common_widgets/counter_increment.dart';
import '../../../extra/common_widgets/description_text.dart';
import '../../../extra/common_widgets/fav_login_alert_dialog.dart';
import '../../logic/controller/product_preview_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

class ProductPreviewScreen extends StatefulWidget {
  const ProductPreviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen>
    with SingleTickerProviderStateMixin {
  final productPreviewController = Get.find<ProductPreviewController>();
  final numberFormat = NumberFormat("#,##0.00##", "en_US");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (productPreviewController.favouriteValuesChecking ==
            'favouriteScreen') {
          Get.offAllNamed(Routes.mainScreen, arguments: 2);
        } else if (productPreviewController.favouriteValuesChecking !=
            'others') {
          Get.offAllNamed(Routes.mainScreen, arguments: 1);
        } else {
          Get.back();
        }
        return true;
      },
      child: SafeArea(child: GetBuilder<ProductPreviewController>(
        builder: (_) {
          return HandlingDataView(
              statusRequest: productPreviewController.statusRequestCustomMenu!,
              widget: TextScaleFactorClamper(
                  child: Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(7.5.h),
                    child: ProductAppBar(
                      press: () {
                        if (productPreviewController.favouriteValuesChecking ==
                            'favouriteScreen') {
                          Get.offAllNamed(Routes.mainScreen, arguments: 2);
                        } else if (productPreviewController
                                .favouriteValuesChecking !=
                            'others') {
                          Get.offAllNamed(Routes.mainScreen, arguments: 1);
                        } else {
                          Get.back();
                        }
                      },
                    )),
                backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
                body: NotificationListener(
                    child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (productPreviewController.customMenu.isNotEmpty) {
                      if (scrollInfo is UserScrollNotification) {
                        if (scrollInfo.direction == ScrollDirection.reverse) {
                          productPreviewController.scrollingValues();
                        }
                      }
                    } else {
                      productPreviewController.scrollingValues();
                    }
                    return true;
                  },
                  child: productPreviewController.categoryIdValues != 5
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                              ProductCard(
                                  imageUrl: productPreviewController
                                      .argumentData['image']!,
                                  productName: productPreviewController
                                      .argumentData['name'],
                                  priceContent: priceContent(),
                                  isReward: 1,
                                  totalPrizeValues: totalPrizeValues(),
                                  favouriteContent: favouriteContent(),
                                  addButton: addButton(),
                                  chooseSize: chooseSize(),
                                  productDescription1: productDescription1()),
                              productPreviewController
                                          .customMenuBoolValues.value ==
                                      false
                                  ? Expanded(
                                      child: Container(
                                      padding: EdgeInsets.only(
                                          left: 4.w,
                                          top: 2.h,
                                          right: 4.w,
                                          bottom: 2.h),
                                      child: scrollTabBarView(),
                                    ))
                                  : const SizedBox(),
                            ])
                      : MerchCategory(
                          productPreviewController: productPreviewController),
                )),
                floatingActionButton: productPreviewController
                        .customMenu.isNotEmpty
                    ? CommonWidget().floatingButton(
                        endPointValues: productPreviewController.endPoint,
                        name: NameValues.add,
                        totalLength: productPreviewController.productTotal ?? 0,
                        onViewbuttonpressed: () {
                          final bool values =
                              productPreviewController.minimumCheckValues();
                          if (values == false) {
                            ShowDialogBox.alertDialogBox(
                                context: context,
                                title: 'Alert',
                                content: productPreviewController
                                    .minCustMenuName
                                    .join(', '),
                                onButtonTapped: () {
                                  Get.back();
                                },
                                cartScreen: 1,
                                categoryId:
                                    productPreviewController.categoryIdValues,
                                textOkButton: 'OK');
                          } else {
                            productPreviewController.addToCartCalculations();
                          }
                        })
                    : FloatingActionButton.extended(
                        onPressed: () {
                          double subTotal = 0.0;
                          productPreviewController
                              .overAllPriceCalculation()
                              .forEach((element) {
                            subTotal += double.parse(element);
                          });

                          productPreviewController.addCart(
                              itemPrize: '',
                              itemID: '',
                              totalCost: productPreviewController
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
              )));
        },
      )),
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  Widget priceContent() {
    return productPreviewController.slashedPrice == 0.0
        ? const SizedBox()
        : GetBuilder<ProductPreviewController>(builder: (_) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 1.w,
                  right: 1.w,
                  bottom: productPreviewController.productDescription!.isEmpty
                      ? 0
                      : 0.h),
              child: Text(
                  '\$ ${numberFormat.format(productPreviewController.slashedPrice)}',
                  style: TextStore.textTheme.displaySmall?.copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w300,
                      color: mainColor)),
            );
          });
  }

  Widget onlinePrice() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
            left: 5.w,
            right: 1.w,
            bottom:
                productPreviewController.productDescription!.isEmpty ? 0 : 0.h),
        child: productPreviewController.totalPrice == 0.0
            ? Text(
                '\$ ${numberFormat.format(productPreviewController.priceCalculation1(1, double.parse(productPreviewController.totalPrice.toStringAsFixed(2))))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green))
            : Text(
                '\$ ${numberFormat.format(double.parse(productPreviewController.totalPrice.toStringAsFixed(2)))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green)),
      );
    });
  }

  Widget addButton() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      Color? color = Get.isDarkMode ? Colors.white : borderColor;
      return HandlingDataView(
          statusRequest: productPreviewController.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                productPreviewController.increaseCount();
              },
              onDecrementSelected: () {
                productPreviewController.decreaseCount();
              },
              label:
                  // Container(
                  //     width: 8.w,
                  //     // margin: EdgeInsets.symmetric(horizontal: 2.w),
                  //     // padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.6.h),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3), color: Colors.transparent),
                  //     child: Center(
                  //       child: Text('145',
                  //           style: TextStore.textTheme.displaySmall!.copyWith(
                  //               color:  color, fontWeight: FontWeight.bold)),
                  //     )),
                  Text(
                productPreviewController.productQuality.toString(),
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
              if (productPreviewController.isFavourite == true) {
                productPreviewController.favouriteValuesChecking =
                    'favouriteScreen';
                productPreviewController.isFavourite = false;
                productPreviewController.removeFavourite(
                    productCode: productPreviewController.productID!);
              } else if (productPreviewController.isFavourite == false) {
                productPreviewController.favouriteValuesChecking =
                    'favouriteScreen';
                productPreviewController.isFavourite = true;
                productPreviewController.someFavouriteValuesChecking();
              }
            } else {
              FavLoginPopUp().showFavLoginAlertDialog(context,
                  userNameController: productPreviewController.emailController,
                  passWordController: productPreviewController
                      .passwordController, onButtonTapped: () {
                String email =
                    productPreviewController.emailController.text.trim();
                String password =
                    productPreviewController.passwordController.text.trim();
                productPreviewController.productPreviewFavLogin(
                    email: email,
                    password: password,
                    productCode: productPreviewController.productID!,
                    status: '0');
              });
            }
          });
        },
        child: SizedBox(
            height: 5.h,
            width: 12.w,
            child: Icon(
                productPreviewController.isFavourite == true
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: getDeviceType() == 'phone' ? 26.sp : 13.sp,
                color: productPreviewController.isFavourite == true
                    ? Colors.red
                    : Colors.grey))
    );
  }

  Widget productDescription1() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return productPreviewController.productDescription!.isEmpty
          ? const SizedBox()
          : Text(productPreviewController.productDescription!,
          style: TextStore.textTheme.titleLarge!.copyWith(
              color: Get.isDarkMode ? Colors.white : borderColor)
      );
      // (productPreviewController.productDescription!.length < 64
      //         ?
      //         : ExpandableText(
      //             productPreviewController.productDescription == null
      //                 ? ''
      //                 : productPreviewController.productDescription!,
      //             trimLines: 1,
      //           ));
    });
  }

  Widget totalPrizeValues() {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        GetBuilder<ProductPreviewController>(builder: (_) {
          String values = productPreviewController
              .priceCalculation1(
                  productPreviewController.productQuality.toInt(),
                  productPreviewController.totalPrice)
              .toStringAsFixed(2);
          return Text('\$ ${numberFormat.format(double.parse(values))}',
              style: TextStore.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.w900, color: Colors.green));
        })
      ],
    );
  }

  Widget chooseSize() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return Container(
          padding: EdgeInsets.only(left: 1.w, right: 1.w),
          child: HandlingDataView(
              statusRequest:
                  productPreviewController.statusRequestProductPreview!,
              widget: DropdownMethod(
                  controller: productPreviewController,
                  onViewbuttonpressed: (dynamic) {
                    productPreviewController.handleDropdownSelection(
                        item: productPreviewController
                            .dropdownChooseingValues(dynamic));
                  })));
    });
  }

  Widget verticalBar() {
    return Obx(() => SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              productPreviewController
                  .customMenu[productPreviewController.productIndex.toInt()]
                  .name!,
              style: TextStore.textTheme.titleMedium!.copyWith(
                  color: Colors.transparent, fontWeight: FontWeight.bold)),
          productPreviewController.isWeightCheck != '1' &&
                  productPreviewController.hybridProduct != 1
              ? VerticalBarIndicator(
                  percent: productPreviewController.valuesChanges(
                      productPreviewController.productIndex.toInt(),
                      'productValues'),
                  height: 1.h,
                  animationDuration: const Duration(seconds: 3),
                  color: const [Colors.limeAccent, Colors.green],
                  header:
                      '${(productPreviewController.valuesChanges(productPreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
                  footer: '',
                  footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                      fontSize: 9.sp,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                      fontSize: 9.sp,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                  width: 40.w)
              : (productPreviewController.hybridProduct == 1
                  ? VerticalBarIndicator(
                      percent: productPreviewController.valuesChanges(
                          productPreviewController.productIndex.toInt(),
                          'productValues'),
                      height: 1.h,
                      animationDuration: const Duration(seconds: 3),
                      color: const [Colors.limeAccent, Colors.green],
                      header:
                          '${(productPreviewController.valuesChanges(productPreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
                      footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      width: 53.w)
                  : VerticalBarIndicator(
                      percent: productPreviewController.lineGraphValues,
                      height: 1.h,
                      animationDuration: const Duration(seconds: 3),
                      color: const [Colors.limeAccent, Colors.green],
                      header:
                          '${(productPreviewController.lineGraphValues * 100).toStringAsFixed(2)} %',
                      footerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      headerStyle: TextStore.textTheme.titleLarge?.copyWith(
                          fontSize: 9.sp,
                          color: Get.isDarkMode ? Colors.white : Colors.black),
                      width: 53.w))
        ])));
  }

  scrollTabBarView() {
    return ScrollableListTabScrollerView(
      tabBuilder: (BuildContext context, int index, bool active) {
        return Container(
          color: Get.isDarkMode
              ? (Colors.transparent)
              : (productPreviewController.customMenu.length <= 1
                  ? Colors.transparent
                  : Colors.grey.shade100),
          height: 9.h,
          width: productPreviewController.customMenu.length <= 1
              ? MediaQuery.of(context).size.width
              : null,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Text(
            productPreviewController.customMenu[index].name!,
            style: !active
                ? TextStore.textTheme.headlineMedium?.copyWith(
                    color: descriptionColor, fontWeight: FontWeight.bold)
                : TextStore.textTheme.headlineMedium
                    ?.copyWith(color: mainColor, fontWeight: FontWeight.bold),
          ),
        );
      },
      addingWidget: verticalBar(),
      tabChanged: (int values) {
        productPreviewController.valuesChanges(values, '');
      },
      itemCount: productPreviewController.customMenu.length,
      itemBuilder: (BuildContext context, int index) {
        final size = productPreviewController
            .minMaxShow(productPreviewController.customMenu[index].id);
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.h),
              child: MenuCategoryItem(
                title: productPreviewController.customMenu[index].name!,
                customMenuItemValues:
                    productPreviewController.customMenu[index].customMenuItems!,
                minMaxValues: size,
                controller: productPreviewController,
                customProductsValues:
                    productPreviewController.customMenu[index].customProducts!,
                customizeMenuItems: productPreviewController
                    .customMenu[index].customizeMenuItems,
                selectedItems:
                    productPreviewController.customMenu[index].selectedItems,
                customMenuId: productPreviewController.customMenu[index].id,
                isHybrid: productPreviewController.customMenu[index].isHybrid,
              ),
            ),
            index == productPreviewController.customMenu.length - 1
                ? SizedBox(height: getDeviceType() == 'phone' ? 24.h : 34.h)
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
