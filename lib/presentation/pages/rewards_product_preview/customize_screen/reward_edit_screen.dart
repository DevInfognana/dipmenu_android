import 'package:dip_menu/extra/packages/linear_progress_bar.dart';
import 'package:dip_menu/extra/packages/scrollable_list_tab_scroller.dart';
import 'package:dip_menu/presentation/pages/rewards_product_preview/customize_screen/widget/customize_edit_view.dart';
import 'package:dip_menu/presentation/pages/rewards_product_preview/customize_screen/widget/dropdown.dart';
import 'package:dip_menu/presentation/pages/rewards_product_preview/customize_screen/widget/merch_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../extra/common_widgets/bottom_navigation.dart';
import '../../../../extra/common_widgets/common_product_page_widgets.dart';
import '../../../../extra/common_widgets/counter_increment.dart';
import '../../../../extra/common_widgets/description_text.dart';
import '../../../logic/controller/rewards_customize_edit_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class CustomizeRewardPreviewScreen extends StatefulWidget {
  const CustomizeRewardPreviewScreen({Key? key}) : super(key: key);

  @override
  State<CustomizeRewardPreviewScreen> createState() =>
      _CustomizeRewardPreviewScreenState();
}

class _CustomizeRewardPreviewScreenState
    extends State<CustomizeRewardPreviewScreen>
    with SingleTickerProviderStateMixin {
  final rewardCustomizePreviewController =
      Get.find<RewardsCustomizeEditController>();

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
          child: GetBuilder<RewardsCustomizeEditController>(
            builder: (_) {
              return HandlingDataView(
                  statusRequest: rewardCustomizePreviewController
                      .statusRequestCustomMenu!,
                  widget: NotificationListener(
                      child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (rewardCustomizePreviewController
                          .customMenu.isNotEmpty) {
                        if (scrollInfo is UserScrollNotification) {
                          /* if (scrollInfo.direction == ScrollDirection.forward) {
                            onStartScroll(scrollInfo.metrics);
                          } else*/
                          if (scrollInfo.direction == ScrollDirection.reverse) {
                            rewardCustomizePreviewController
                                .scrollingValues();
                          }
                        }
                      } else {
                        rewardCustomizePreviewController
                            .scrollingValues();
                      }
                      return true;
                    },
                    child:
                    rewardCustomizePreviewController.categoryIdValues !=
                      5?
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          // productName(),
                          // SizedBox(
                          //   child: Padding(
                          //     padding: EdgeInsets.only(left: 1.w, right: 1.w),
                          //     child: Card(
                          //       elevation: 0,
                          //       child: Column(children: [
                          //         Row(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               SizedBox(
                          //                   height: 15.h,
                          //                   width: getDeviceType() == 'phone'
                          //                       ? 27.w
                          //                       : 23.w,
                          //                   child: ClipRRect(
                          //                       borderRadius:
                          //                           BorderRadius.circular(4.w),
                          //                       child: ImageView(
                          //                           imageUrl: imageview(
                          //                               rewardCustomizePreviewController
                          //                                       .argumentData[
                          //                                   'image']!),
                          //                           showValues: false,
                          //                           mainImageViewWidth: 34.w,
                          //                           bottomImageViewHeight:
                          //                               5.h))),
                          //               Flexible(
                          //                 child: Container(
                          //                   padding: EdgeInsets.all(0.1.h),
                          //                   child: Column(children: [
                          //                     Row(children: [productName()]),
                          //                     Row(children: [
                          //                       productName1(),
                          //                       favouriteContent()
                          //                     ]),
                          //                   ]),
                          //                 ),
                          //               ),
                          //             ]),
                          //         Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.spaceBetween,
                          //             children: [addButton(), chooseSize()]),
                          //         Padding(
                          //             padding:
                          //                 EdgeInsets.symmetric(horizontal: 2.w),
                          //             child: productDescription())
                          //       ]),
                          //     ),
                          //   ),
                          // ),
                          ProductCard(
                              imageUrl: rewardCustomizePreviewController
                                  .argumentData['image']!,
                              productName: rewardCustomizePreviewController
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
                                  // alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      left: 4.w,
                                      top: 2.h,
                                      right: 4.w,
                                      bottom: 0.2.h),
                                  child: ScrollableListTabScrollerView(
                                    tabBuilder: (BuildContext context,
                                            int index, bool active) =>
                                        Container(
                                          color: Get.isDarkMode
                                              ? (Colors.transparent)
                                              : (rewardCustomizePreviewController
                                              .customMenu
                                              .length <=
                                              1
                                              ? Colors.transparent
                                              : Colors.grey.shade100),
                                      height: 9.h,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      child: Text(
                                        rewardCustomizePreviewController
                                            .customMenu[index].name!,
                                        style: !active
                                            ? TextStore.textTheme.headlineMedium
                                                ?.copyWith(
                                                    color: descriptionColor,
                                                    fontWeight: FontWeight.bold)
                                            : TextStore.textTheme.headlineMedium
                                                ?.copyWith(
                                                    color: mainColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                      ),
                                    ),
                                    itemCount: rewardCustomizePreviewController
                                        .customMenu.length,
                                    tabChanged: (int values) {
                                      rewardCustomizePreviewController
                                          .valuesChanges(values, '');
                                    },
                                    addingWidget: verticalBar(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final size =
                                          rewardCustomizePreviewController
                                              .minMaxShow(
                                                  rewardCustomizePreviewController
                                                      .customMenu[index].id);
                                      return Column(
                                        children: [
                                          // SizedBox(height: 1.h),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 1.h),
                                            child: ResMenuCategoryItem(
                                              isHybrid:
                                              rewardCustomizePreviewController
                                                  .customMenu[index]
                                                  .isHybrid,
                                              title:
                                                  rewardCustomizePreviewController
                                                      .customMenu[index].name!,
                                              customMenuItemValues:
                                                  rewardCustomizePreviewController
                                                      .customMenu[index]
                                                      .customMenuItems!,
                                              minMaxValues: size,
                                              controller:
                                                  rewardCustomizePreviewController,
                                              customProductsValues:
                                                  rewardCustomizePreviewController
                                                      .customMenu[index]
                                                      .customProducts!,
                                              customizeMenuItems:
                                                  rewardCustomizePreviewController
                                                      .customMenu[index]
                                                      .customizeMenuItems,
                                              selectedItems:
                                                  rewardCustomizePreviewController
                                                      .customMenu[index]
                                                      .selectedItems,
                                            ),
                                          ),
                                          index ==
                                                  rewardCustomizePreviewController
                                                          .customMenu.length -
                                                      1
                                              ? SizedBox(
                                                  height:
                                                      getDeviceType() == 'phone'
                                                          ? 24.h
                                                          : 34.h)
                                              : const SizedBox(),
                                        ],
                                      );
                                    },
                                  ))),
                        ]):CustomizeRewardMerchCategory(
                        rewardsCustomizeEditController:rewardCustomizePreviewController
                    ),
                  )));
            },
          ),
        ),
        floatingActionButton:GetBuilder<RewardsCustomizeEditController>(
            builder: (_) {
              return HandlingDataView(statusRequest: rewardCustomizePreviewController
                  .statusRequestCustomMenu!, widget:   TextScaleFactorClamper(
                  child: rewardCustomizePreviewController.customMenu.isNotEmpty
                      ?CommonWidget().floatingButton(
                      endPointValues: rewardCustomizePreviewController.endPoint,
                      name: NameValues.productupdate,
                      totalLength: rewardCustomizePreviewController.productTotal,
                      onViewbuttonpressed: () {
                        bool values = false;
                        if (rewardCustomizePreviewController
                            .customMenu.isNotEmpty) {
                          values = rewardCustomizePreviewController
                              .minimumCheckValues();
                        } else {
                          values = true;
                        }
                        if (values == false) {
                          ShowDialogBox.alertDialogBox(
                              context: context,
                              title: 'Alert',
                              content: rewardCustomizePreviewController
                                  .minCustMenuName
                                  .join(', '),
                              onButtonTapped: () {
                                Get.back();
                              },
                              cartScreen: 1,
                              categoryId: rewardCustomizePreviewController
                                  .categoryIdValues,
                              textOkButton: 'OK');
                        } else {
                          rewardCustomizePreviewController
                              .addToCartCalculations();
                        }
                      })
                      : FloatingActionButton.extended(
                      onPressed: () {
                        double subTotal = 0.0;
                        rewardCustomizePreviewController
                            .overAllPriceCalculation()
                            .forEach((element) {
                          subTotal += double.parse(element);
                        });

                        rewardCustomizePreviewController.addCart(
                            itemPrize: '',
                            itemID: '',
                            totalCost: rewardCustomizePreviewController
                                .allProductTotalValues(subTotal),
                            defaultCustom: 1,
                            itemNames: '');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                      label: Text(NameValues.productupdate,
                          style: TextStore.textTheme.headlineMedium!
                              .copyWith(color: Colors.white)),
                      backgroundColor: mainColor)
              ),

              );
            }

        )




        // floatingActionButton: TextScaleFactorClamper(
        //   child: FloatingActionButton.extended(
        //       onPressed: () {
        //         if (rewardCustomizePreviewController.endPoint == true) {
        //           final bool values =
        //               rewardCustomizePreviewController.minimumCheckValues();
        //           if (values == false) {
        //             ShowDialogBox.AlertDialogBox(
        //                 context: context,
        //                 title: 'Alert',
        //                 content:
        //                     ' ${rewardCustomizePreviewController.minCustMenuName.join(', ')} ',
        //                 onButtonTapped: () {
        //                   Get.back();
        //                 },
        //                 cartScreen: 1,
        //                 categoryId:
        //                     rewardCustomizePreviewController.categoryIdValues,
        //                 textOkButton: 'OK');
        //           } else {
        //             double subTotal = 0.0;
        //             rewardCustomizePreviewController.overAllPriceCalculation()
        //                 .forEach((element) {
        //               subTotal += double.parse(element);
        //             });
        //             if (rewardCustomizePreviewController
        //                 .customMenu.isNotEmpty) {
        //               final priceValues = rewardCustomizePreviewController
        //                       .overAllPriceCalculation()
        //                   .join(',');
        //               // .reduce((value, element) => value + ',' + element);
        //               dynamic selectIDValues =
        //                   rewardCustomizePreviewController.selectedID()
        //                       .join(',');
        //               // .reduce((value, element) => value + ',' + element);
        //
        //               dynamic selectNameValues =
        //                   rewardCustomizePreviewController.selectedName()
        //                       .join(',');
        //               // .reduce((value, element) => value + ',' + element);
        //
        //               rewardCustomizePreviewController.addCart(
        //                   itemPrize:
        //                       rewardCustomizePreviewController.valuescheck() ==
        //                               false
        //                           ? ''
        //                           : priceValues,
        //                   itemID:
        //                       rewardCustomizePreviewController.valuescheck() ==
        //                               false
        //                           ? ''
        //                           : selectIDValues,
        //                   totalCost: rewardCustomizePreviewController
        //                       .allProductTotalValues(subTotal),
        //                   defaultCustom: rewardCustomizePreviewController
        //                               .deafulatCustomItems() ==
        //                           true
        //                       ? 1
        //                       : 0,
        //                   itemNames:
        //                       rewardCustomizePreviewController.valuescheck() ==
        //                               false
        //                           ? ''
        //                           : selectNameValues);
        //             } else {
        //               rewardCustomizePreviewController.addCart(
        //                   itemPrize: '0',
        //                   itemID: '',
        //                   totalCost: rewardCustomizePreviewController
        //                       .allProductTotalValues(subTotal),
        //                   defaultCustom: rewardCustomizePreviewController
        //                               .deafulatCustomItems() ==
        //                           true
        //                       ? 1
        //                       : 0,
        //                   itemNames: '');
        //             }
        //           }
        //         }
        //       },
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(3.w)),
        //       extendedPadding: EdgeInsets.all(5.w),
        //       label: Text(NameValues.productupdate,
        //           style: TextStore.textTheme.displaySmall!
        //               .copyWith(color: Colors.white)),
        //       backgroundColor:
        //           rewardCustomizePreviewController.endPoint == true
        //               ? mainColor
        //               : Colors.grey),
        // ),
      ),
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  Widget productDetailsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 2.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Flexible(
              child: Text(
                  rewardCustomizePreviewController.argumentData['name'],
                  overflow: TextOverflow.clip,
                  style: TextStore.boldTheme.displayLarge!
                      .copyWith(color: Colors.black)),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 2.w, bottom: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GetBuilder<RewardsCustomizeEditController>(builder: (_) {
                return Text(
                    '${rewardCustomizePreviewController.priceCalculation1(rewardCustomizePreviewController.custProductQuanity.toInt(), rewardCustomizePreviewController.totalPrice)} pts',
                    style: TextStore.boldTheme.displayMedium
                        ?.copyWith(color: mainColor));
              }),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 2.w),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Flexible(
              child: Text(
                  rewardCustomizePreviewController.productDescription == null
                      ? ''
                      : rewardCustomizePreviewController.productDescription!,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStore.textTheme.titleLarge!
                      .copyWith(color: borderColor, fontSize: 10.5.sp)),
            ),
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                direction: Axis.vertical,
                children: [
                  Text(NameValues.chooseSize,
                      style: TextStore.textTheme.displaySmall?.copyWith(
                          color: descriptionColor,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  GetBuilder<RewardsCustomizeEditController>(builder: (_) {
                    return HandlingDataView(
                        statusRequest: rewardCustomizePreviewController
                            .statusRequestProductPreview!,
                        widget: RewardDropdown(
                            controller: rewardCustomizePreviewController,
                            onViewbuttonpressed: (dynamic) {
                              rewardCustomizePreviewController.selectedValue =
                                  dynamic;
                            }));
                  })
                ],
              ),
            ],
          ),
        ),
        // rewardCustomizePreviewController.customMenu.isNotEmpty
        //     ? Padding(
        //   padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h),
        //   child: Wrap(
        //     crossAxisAlignment: WrapCrossAlignment.start,
        //     direction: Axis.vertical,
        //     children: [
        //       Text(NameValues.customizeOrder,
        //           style: TextStore.textTheme.displaySmall?.copyWith(
        //               color: titleColor, fontWeight: FontWeight.bold)),
        //      /* Text(NameValues.customizeOrderSubText,
        //           style: TextStore.textTheme.titleLarge
        //               ?.copyWith(color: descriptionColor))*/
        //     ],
        //   ),
        // )
        //     : Container()
      ],
    );
  }

  Widget productName() {
    return Flexible(
      child: Text(rewardCustomizePreviewController.argumentData['name'],
          overflow: TextOverflow.clip,
          style: TextStore.textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
    );
  }

  Widget priceContent() {
    return Flexible(
      child: Text(
          '${rewardCustomizePreviewController.priceCalculation1(rewardCustomizePreviewController.custProductQuanity.toInt(), rewardCustomizePreviewController.defaultPrice)} pts',
          overflow: TextOverflow.clip,
          style: TextStore.textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.bold, color: mainColor)),
    );
  }

  Widget addButton() {
    return GetBuilder<RewardsCustomizeEditController>(builder: (_) {
      Color? color = Get.isDarkMode ? Colors.white : borderColor;
      return HandlingDataView(
          statusRequest:
              rewardCustomizePreviewController.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                rewardCustomizePreviewController.increaseCount();
              },
              onDecrementSelected: () {
                rewardCustomizePreviewController.decreaseCount();
              },
              label: Text(
                rewardCustomizePreviewController.custProductQuanity.toString(),
                style: TextStore.textTheme.displaySmall
                    ?.copyWith(color: color, fontWeight: FontWeight.bold),
              )));
    });
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 1.w),
    //   child: Row(
    //     children: [
    //       InkWell(
    //           onTap: () {
    //             /* if (widget.data![index].quantity! > 1) {
    //             widget.controller!.cartCountUpdate(
    //                 selectedIndex: index, isIncreasing: false, Id: Id);
    //           }*/
    //           },
    //           child: Container(
    //               padding: EdgeInsets.all(0.6.h),
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(5), //color: mainColor,
    //                   border: Border.all(width: 1, color: Colors.grey.shade500)),
    //               child:
    //               Icon(Icons.remove, color: Colors.black, size: 2.h))),
    //       Container(
    //           width: 14.w,
    //           margin: EdgeInsets.symmetric(horizontal: 2.w),
    //           padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.6.h),
    //           decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(3), color: Colors.white),
    //           child: Center(
    //             child: Text('1',//'${widget.data![index].quantity!}',
    //                 style: TextStore.textTheme.displaySmall!
    //                     .copyWith(color: mainColor, fontWeight: FontWeight.bold)),
    //           )),
    //       InkWell(
    //           onTap: () {
    //             /*widget.controller!.cartCountUpdate(
    //           selectedIndex: index, isIncreasing: true, Id: Id);*/
    //           },
    //           child: Container(
    //               padding: EdgeInsets.all(0.6.h),
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(5), //color: mainColor,
    //                   border: Border.all(width: 1, color: Colors.grey.shade500)),
    //               child:  Icon(Icons.add, color: Colors.black, size: 2.h))),
    //       /* SizedBox(width: 15.w),
    //     GestureDetector(
    //       onTap: () {
    //         setState(() {
    //           if (SharedPrefs.instance
    //               .getString('token') !=
    //               null) {
    //             if (productPreviewController
    //                 .isFavourite ==
    //                 true) {
    //               productPreviewController
    //                   .favouriteValues =
    //               'favouriteScreen';
    //               productPreviewController
    //                   .isFavourite = false;
    //               productPreviewController
    //                   .favouriteAdded(
    //                   productCode:
    //                   productPreviewController
    //                       .productID!,
    //                   status: '0');
    //             } else if (productPreviewController
    //                 .isFavourite ==
    //                 false) {
    //               productPreviewController
    //                   .favouriteValues =
    //               'favouriteScreen';
    //               productPreviewController
    //                   .isFavourite = true;
    //               productPreviewController
    //                   .favouriteAdded(
    //                   productCode:
    //                   productPreviewController
    //                       .productID!,
    //                   status: '1');
    //             }
    //           } else {
    //             showFavLoginAlertDialog(context);
    //           }
    //         });
    //       },
    //       child: productPreviewController
    //           .isFavourite ==
    //           true
    //           ? SizedBox(
    //           height: 5.h,
    //           width: 12.w,
    //           child: Icon(
    //               Icons.favorite,size: 26.sp,
    //               color: Colors.red))
    //           : SizedBox(
    //           height: 5.h,
    //           width: 12.w,
    //           child: Icon(
    //               Icons
    //                   .favorite_outline_outlined,size: 26.sp,
    //               color: Colors.grey)),
    //     ),*/
    //     ],
    //   ),
    // );
  }

  Widget favouriteContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (rewardCustomizePreviewController.isFavourite == true) {
            rewardCustomizePreviewController.favouriteValues =
                'favouriteScreen';
            rewardCustomizePreviewController.isFavourite = false;
            rewardCustomizePreviewController.removeFavourite(
                productCode: rewardCustomizePreviewController.productID!);
          } else if (rewardCustomizePreviewController.isFavourite == false) {
            rewardCustomizePreviewController.favouriteValues =
                'favouriteScreen';
            rewardCustomizePreviewController.isFavourite = true;
            rewardCustomizePreviewController.someFavouriteValuesChecking();

          }
        });
      },
      child: rewardCustomizePreviewController.isFavourite == true
          ? SizedBox(
              height: 5.h,
              width: 12.w,
              child: Icon(Icons.favorite,
                  size: getDeviceType() == 'phone' ? 26.sp : 13.sp,
                  color: Colors.red))
          : SizedBox(
              height: 5.h,
              width: 12.w,
              child: Icon(Icons.favorite_outline_outlined,
                  size: getDeviceType() == 'phone' ? 26.sp : 13.sp,
                  color: Colors.grey)),
    );
  }

  Widget productDescription() {
    return GetBuilder<RewardsCustomizeEditController>(builder: (_) {
      return rewardCustomizePreviewController.productDescription!.isEmpty
          ? const SizedBox()
          : Text(rewardCustomizePreviewController.productDescription!,
          style: TextStore.textTheme.titleLarge!.copyWith(
          color: Get.isDarkMode ? Colors.white : borderColor));
      // ExpandableText(
      //         rewardCustomizePreviewController.productDescription == null
      //             ? ''
      //             : rewardCustomizePreviewController.productDescription!,
      //         trimLines: 1);
      // : Container(
      //     padding: EdgeInsets.only(left: 1.w, right: 1.w),
      //     // height: 12.h,
      //     child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      //       Flexible(
      //         child: Text(
      //             rewardCustomizePreviewController.productDescription ==
      //                     null
      //                 ? ''
      //                 : rewardCustomizePreviewController
      //                     .productDescription!,
      //             textAlign: TextAlign.left,
      //             overflow: TextOverflow.ellipsis,
      //             maxLines: 3,
      //             style: TextStore.textTheme.titleLarge!
      //                 .copyWith(color: borderColor, fontSize: 10.5.sp)),
      //       ),
      //     ]),
      //   );
    });
  }

  Widget chooseSize() {
    return Padding(
        padding: EdgeInsets.only(left: 3.w, right: 2.w, top: 1.w),
        child: HandlingDataView(
            statusRequest:
                rewardCustomizePreviewController.statusRequestProductPreview!,
            widget: RewardDropdown(
                controller: rewardCustomizePreviewController,
                onViewbuttonpressed: (dynamic) {
                  rewardCustomizePreviewController. handleDropdownSelection(item: rewardCustomizePreviewController.dropdownChooseingValues(dynamic));
                  // rewardCustomizePreviewController.selectedValue = dynamic;
                })));
  }

  // Widget verticalBar() {
  //   return Obx(() => ProductOperations().verticalBar(
  //       percent: rewardCustomizePreviewController.valuesChanges(
  //           rewardCustomizePreviewController.productIndex.toInt(),
  //           'productValues'),
  //       isWeightCheck: rewardCustomizePreviewController.isWeightCheck,
  //       subCategoryIdValues:
  //           rewardCustomizePreviewController.subCategoryIdValues,
  //       weightPercent: rewardCustomizePreviewController.lineGraphValues,
  //       weightHeader:
  //           '${(rewardCustomizePreviewController.lineGraphValues * 100).toStringAsFixed(2)} %',
  //       header:
  //           '${(rewardCustomizePreviewController.valuesChanges(rewardCustomizePreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
  //       name: rewardCustomizePreviewController
  //           .customMenu[rewardCustomizePreviewController.productIndex.toInt()]
  //           .name!));
  // }
  Widget verticalBar() {
    return Obx(() => SizedBox(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
               Text(
                   rewardCustomizePreviewController
                  .customMenu[rewardCustomizePreviewController.productIndex.toInt()]
                  .name!,
              style: TextStore.textTheme.titleMedium!.copyWith(
                // color: Get.isDarkMode ? Colors.white : Colors.black,
                  color: Colors.transparent,
                  fontWeight: FontWeight.bold)),
          rewardCustomizePreviewController.isWeightCheck != '1' &&
              rewardCustomizePreviewController.hybridProduct != 1
              ? VerticalBarIndicator(
              percent: rewardCustomizePreviewController.valuesChanges(
                  rewardCustomizePreviewController.productIndex.toInt(),
                  'productValues'),
              height: 1.h,
              animationDuration: const Duration(seconds: 3),
              color: const [Colors.limeAccent, Colors.green],
              header:
              '${(rewardCustomizePreviewController.valuesChanges(rewardCustomizePreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
              footer: '',
              footerStyle: TextStore.textTheme.titleLarge
                  ?.copyWith(fontSize: 9.sp, color: Get.isDarkMode ? Colors.white : Colors.black),
              headerStyle: TextStore.textTheme.titleLarge
                  ?.copyWith(fontSize: 9.sp, color: Get.isDarkMode ? Colors.white : Colors.black),
              width: 40.w)
              : (rewardCustomizePreviewController.hybridProduct == 1
              ? VerticalBarIndicator(
              percent: rewardCustomizePreviewController.valuesChanges(
                  rewardCustomizePreviewController.productIndex.toInt(),
                  'productValues'),
              height: 1.h,
              animationDuration: const Duration(seconds: 3),
              color: const [Colors.limeAccent, Colors.green],
              header:
              '${(rewardCustomizePreviewController.valuesChanges(rewardCustomizePreviewController.productIndex.toInt(), 'productValues') * 100).toStringAsFixed(2)} %',
              footerStyle: TextStore.textTheme.titleLarge
                  ?.copyWith(fontSize: 9.sp,color: Get.isDarkMode ? Colors.white : Colors.black),
              headerStyle: TextStore.textTheme.titleLarge
                  ?.copyWith(fontSize: 9.sp, color: Get.isDarkMode ? Colors.white : Colors.black),
              width: 53.w)
              : VerticalBarIndicator(
              percent: rewardCustomizePreviewController.lineGraphValues,
              height: 1.h,
              animationDuration: const Duration(seconds: 3),
              color: const [Colors.limeAccent, Colors.green],
              header:
              '${(rewardCustomizePreviewController.lineGraphValues * 100).toStringAsFixed(2)} %',
              footerStyle: TextStore.textTheme.titleLarge
                  ?.copyWith(fontSize: 9.sp, color: Get.isDarkMode ? Colors.white : Colors.black),
              headerStyle: TextStore.textTheme.titleLarge
                  ?.copyWith(fontSize: 9.sp, color: Get.isDarkMode ? Colors.white : Colors.black),
              width: 53.w))
        ])));
  }
}
