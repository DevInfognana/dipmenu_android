import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../../data/model/product_preview/custom_menu_data.dart';
import '../../../logic/controller/rewards_product_view_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';

class MenuCategoryItem1 extends StatefulWidget {
  MenuCategoryItem1(
      {Key? key,
      required this.title,
      required this.customMenuItemValues,
      this.customProductsValues,
      required this.controller,
      required this.minMaxValues,
      required this.customizeMenuItems,
      required this.selectedItems,this.isHybrid,this.customMenuId})
      : super(key: key);

  final String title;
  List<CustomMenuItems> customMenuItemValues;
  List<CustomProducts>? customProductsValues;
  List<CustomizeMenuValueItems> customizeMenuItems;
  final minMaxValues;
  final RewardsProductController controller;
  List<SelectedItems> selectedItems;
  final String? isHybrid;
  int? customMenuId;

  @override
  State<MenuCategoryItem1> createState() => _MenuCategoryItemState();
}

class _MenuCategoryItemState extends State<MenuCategoryItem1> {
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
            child: Text(
                widget.controller.isWeightCheck != '1'? widget.controller.productMinsValues(widget.minMaxValues['min'] , widget.minMaxValues['max'],widget.isHybrid!):"Weight :${widget.controller.weightValues}",
                style: TextStore.textTheme.titleLarge!
                    .copyWith(color:  Get.isDarkMode ? Colors.white : Colors.black)
            )
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(widget.title,
                style: TextStore.textTheme.titleSmall!.copyWith(
                    color: Colors.transparent, fontWeight: FontWeight.bold)
            )),
        // widget.controller.categoryIdValues == 4
        //     ? Padding(
        //         padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
        //         child: Text(
        //             'Min: ${widget.minMaxValues['min']} Max: ${widget.minMaxValues['max']}',
        //             style: TextStore.textTheme.titleLarge!
        //                 .copyWith(color: Colors.black54)))
        //     : const SizedBox(),
        GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                // childAspectRatio: MediaQuery.of(context).size.width /
                //     (MediaQuery.of(context).size.height / 1.2),
                // crossAxisSpacing: 10.0,
                // mainAxisSpacing: 10.0,
                childAspectRatio: 4 / 7,
                crossAxisSpacing: 1.w,
                maxCrossAxisExtent: 150),
            itemCount: widget.customizeMenuItems.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext ctx, index) {
              return FittedBox(
                fit: BoxFit.contain,
                child: SizedBox(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (widget.customizeMenuItems[index].isChecked ==
                            false) {
                          if (widget.controller.isWeightCheck != '1' &&  widget.controller.hybridProduct != 1) {
                            widget.controller.weightWithOutItemSelection(
                                selectedItemsValues: widget.selectedItems,
                                customizeMenuItemsValues:
                                widget.customizeMenuItems,
                                customizeMenuItemsId:
                                widget.customizeMenuItems[index].id,
                                customProductMenuId: widget
                                    .customizeMenuItems[index].customMenuId,
                                customMenuName:
                                widget.customizeMenuItems[index].name,
                                customMenuDataName: widget.title,
                                productCustomWeight:
                                widget.customizeMenuItems[index].weight,
                                maxValues: widget.minMaxValues['max']);
                            if (widget.controller.isProductWeightCheck ==
                                true) {
                              widget.customizeMenuItems[index].isChecked =
                              true;
                              widget.controller
                                  .weightOthersBasedLineGraphValues(
                                  customMenuId: widget.customMenuId!,
                                  isHybrid:widget.isHybrid ,
                                  selectedItemsValues:
                                  widget.selectedItems);
                            }
                          } else if (
                          widget.controller.hybridProduct == 1) {
                            widget.controller.selectItemsDifferentFormsSelection(
                                selectedItemsValues: widget.selectedItems,
                                customizeMenuItemsId:
                                widget.customizeMenuItems[index].id,
                                customMenuName:
                                widget.customizeMenuItems[index].name,
                                productCustomWeight:
                                widget.customizeMenuItems[index].weight,
                                maxValues: widget.minMaxValues['max'],
                                customMenuDataName: widget.title,
                                isHybrid: widget.isHybrid,
                                customProductMenuId: widget
                                    .customizeMenuItems[index].customMenuId);
                            if (widget.controller.isProductWeightCheck ==
                                true) {
                              widget.customizeMenuItems[index].isChecked =
                              true;
                              widget.controller
                                  .weightOthersBasedLineGraphValues(
                                  customMenuId: widget.customMenuId!,
                                  isHybrid:widget.isHybrid ,
                                  selectedItemsValues:
                                  widget.selectedItems);
                            }
                          } else {
                            widget.controller.weightWithInItemSelection(
                                selectedItemsValues: widget.selectedItems,
                                customizeMenuItemsId:
                                widget.customizeMenuItems[index].id,
                                customMenuName:
                                widget.customizeMenuItems[index].name,
                                productCustomWeight:
                                widget.customizeMenuItems[index].weight,
                                customMenuDataName: widget.title,
                                customProductMenuId: widget
                                    .customizeMenuItems[index].customMenuId);
                            if (widget.controller.isProductWeightCheck ==
                                true) {
                              widget.customizeMenuItems[index].isChecked =
                              true;
                            }
                          }
                        } else if (widget.customizeMenuItems[index].isChecked =
                            true) {
                          widget.customizeMenuItems[index].isChecked = false;
                          widget.controller.weightWithOutItemRemove(
                              productWeightValues: widget.customizeMenuItems[index].weight ??0,
                              customizeMenuItemsId:
                              widget.customizeMenuItems[index].id,
                              selectedItemsValues: widget.selectedItems);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        PhysicalModel(
                          color: Colors.transparent,
                          elevation:
                              widget.customizeMenuItems[index].isChecked == true
                                  ? 8
                                  : 2,
                          shadowColor:
                              widget.customizeMenuItems[index].isChecked == true
                                  ? Colors.grey.shade500
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: Card(
                            color: widget.customizeMenuItems[index].isChecked ==
                                    true
                                ? Colors.green.shade100
                                : authTextFromFieldFillColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.w)),
                            child: LayoutBuilder(
                              builder: (context, cons) => Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FittedBox(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5.w),
                                              topRight: Radius.circular(5.w)),
                                          child: CachedNetworkImage(
                                              width: 25.w,
                                              height: 11.h,
                                              // width: 27.w,
                                              // height: 15.h,
                                              // fit: BoxFit.fill,
                                              imageUrl: imageview(widget
                                                  .customizeMenuItems[index]
                                                  .image!),
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  Center(
                                                      child: CircularProgressIndicator(
                                                          value: downloadProgress
                                                              .progress,
                                                          color: mainColor)),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                          ImageAsset.tempImage,
                                                          fit: BoxFit.fill)))),
                                  widget.customizeMenuItems[index].name!
                                              .length <=
                                          25
                                      ? FittedBox(
                                          child: SizedBox(
                                          height: getDeviceType() == 'phone'
                                              ? 5.h
                                              : 7.h,
                                          width: 27.w,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                      widget
                                                          .customizeMenuItems[
                                                              index]
                                                          .name!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStore
                                                          .textTheme1.titleLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ),
                                              ]),
                                        ))
                                      : FittedBox(
                                          child: SizedBox(
                                          height: getDeviceType() == 'phone'
                                              ? 10.h
                                              : 12.h,
                                          width: 27.w,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                      widget
                                                          .customizeMenuItems[
                                                              index]
                                                          .name!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStore
                                                          .textTheme1.titleLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                ),
                                              ]),
                                        )),
                                  // FittedBox(
                                  //     child: SizedBox(
                                  //       height: 4.1.h,
                                  //       width: 27.w,
                                  //       child:Row(
                                  //           mainAxisAlignment: MainAxisAlignment.center,
                                  //           children: [
                                  //             Flexible(
                                  //               child:Text(
                                  //                   widget
                                  //                       .customizeMenuItems[index].name!,
                                  //                   textAlign: TextAlign.center,
                                  //                   style: TextStore.textTheme
                                  //                       .titleLarge!
                                  //                       .copyWith(
                                  //                       color: Colors.black,
                                  //                       fontWeight:
                                  //                       FontWeight.bold)),
                                  //             ),
                                  //           ]),
                                  //     )),
                                  double.parse(widget.controller.pointsValues(
                                              widget.customProductsValues,
                                              widget.customizeMenuItems[index]
                                                  .id!)) !=
                                          0.0
                                      ? FittedBox(
                                          child: SizedBox(
                                            height: 3.h,
                                            child: Text(
                                              '${widget.controller.pointsValues(widget.customProductsValues, widget.customizeMenuItems[index].id!)} pts',
                                              // '${numberFormat.format(double.parse(widget.controller.pointsValues(widget.customProductsValues, widget.customizeMenuItems[index].id!)))} pts',
                                              style: TextStore
                                                  .textTheme1.headlineSmall!
                                                  .copyWith(
                                                      color: mainColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : SizedBox(height: 3.h),
                                  // FittedBox(
                                  //   child: SizedBox(
                                  //     height: 3.h,
                                  //     child: Text(
                                  //       'Weight ${widget.customizeMenuItems[index].weight}',
                                  //       style: TextStore
                                  //           .textTheme1.titleLarge!
                                  //           .copyWith(color: mainColor),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(height: 2.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                        getDeviceType() == 'phone'
                            ? Positioned(
                                top: 0,
                                right: 1,
                                child: Offstage(
                                  offstage: !widget
                                      .customizeMenuItems[index].isChecked!,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.check,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            : Positioned(
                                top: -10,
                                right: 1,
                                child: Offstage(
                                  offstage: !widget
                                      .customizeMenuItems[index].isChecked!,
                                  child: Container(
                                    height: 6.h,
                                    width: 6.w,
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: const Icon(Icons.check,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}
