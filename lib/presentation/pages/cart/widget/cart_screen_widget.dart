/*
import 'package:dip_menu/domain/provider/http_request.dart';
import 'package:dip_menu/presentation/logic/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_textstyle.dart';
import '../../../../core/config/theme.dart';
import '../../../../data/model/cartlist_model.dart';

class CartScreenCard extends StatefulWidget {
  CartScreenCard({super.key, this.data, this.controller});

  List<CartListDataValues>? data;
  CartController? controller;
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  @override
  State<CartScreenCard> createState() => CartScreenCardState();
}

class CartScreenCardState extends State<CartScreenCard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
          itemCount: widget.data!.length,
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(1.w),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.data![index].product!.name ?? '',
                                style: TextStore.textTheme.displaySmall!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(height: 0.5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                    '\$ ${double.parse(widget.data![index].totalCost!) * widget.data![index].quantity!}',
                                    style: TextStore.textTheme.displaySmall!
                                        .copyWith(
                                            color: mainColor,
                                            fontWeight: FontWeight.bold)),
                                SizedBox(width: 1.h),
                                Text('${widget.data![index].defaultSizeName}',
                                    style: TextStore.textTheme.displaySmall!
                                        .copyWith(
                                            color: Colors.grey, fontSize: 18)),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                addButton(index: index),
                                Row(
                                  children: [
                                    GestureDetector(
                                        onTap: () {},
                                        child: const Icon(Icons.edit_outlined,
                                            color: Colors.black, size: 22)),
                                    SizedBox(width: 4.w),
                                    GestureDetector(
                                        onTap: () {
                                          widget.controller!
                                              .cartDeleteAlertDialog(
                                                  selectedIndex: index);
                                        },
                                        child: const Icon(Icons.delete_outline,
                                            color: Colors.black, size: 22)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                        height: 15.h,
                        width: 30.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.w),
                          child: ImageView(
                            imageUrl:
                                imageview(widget.data![index].product!.image!),
                            showValues: false,
                            mainImageViewWidth: 34.w,
                            bottomImageViewHeight: 5.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1.h, right: 1.h),
                  child: const Divider(
                    color: tileColor,
                    thickness: 2.0,
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget addButton({required int index}) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              if (widget.data![index].quantity! > 1) {
                widget.controller!
                    .cartCountUpdate(selectedIndex: index, isIncreasing: false);
              }
            },
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), //color: mainColor,
                    border: Border.all(width: 1, color: Colors.grey.shade500)),
                child:
                    const Icon(Icons.remove, color: Colors.black, size: 16))),
        Container(
            width: 10.w,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Center(
              child: Text('${widget.data![index].quantity!}',
                  style: TextStore.textTheme.displaySmall!
                      .copyWith(color: mainColor, fontWeight: FontWeight.bold)),
            )),
        InkWell(
            onTap: () {
              // if (widget.data![index].quantity! < 5) {       // for max limit
              widget.controller!
                  .cartCountUpdate(selectedIndex: index, isIncreasing: true);
              // }
            },
            child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), //color: mainColor,
                    border: Border.all(width: 1, color: Colors.grey.shade500)),
                child: const Icon(Icons.add, color: Colors.black, size: 16))),
      ],
    );
  }
}
*/

import 'package:dip_menu/presentation/logic/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/cartlist_model.dart';
import '../../../../extra/common_widgets/description_text.dart';
import 'package:dip_menu/presentation/pages/index.dart';


// ignore: must_be_immutable
class CartScreenCard extends StatefulWidget {
  CartScreenCard({super.key, this.data, this.controller, this.onDeleted});

  List<CartListDataValues>? data;
  CartController? controller;
  final Function()? onDeleted;

  @override
  State<CartScreenCard> createState() => CartScreenCardState();
}

class CartScreenCardState extends State<CartScreenCard> {
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return TextScaleFactorClamper(
      child: Flexible(
        child: ListView.builder(
            itemCount: widget.data!.length,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final rewardview = widget.data![index];
              final cardViewValues = widget.data![index].product!;
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(0.1.w),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    tapFunction(
                                        index: index,
                                        cardViewValues: cardViewValues);
                                  },
                                  child:
              widget.data![index].reward == 0?
                                  Text(
                                      widget.data![index].product!.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w900)):Wrap(
                  children:[
                    Text( widget.data![index].product!.name!,
                        textAlign: TextAlign.left,
                        style: Get.context!.theme.textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const ImageIcon(AssetImage(ImageAsset.rewardIcon)),
                  ]
              ),
                              ),
                              SizedBox(height: 0.5.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (widget.data![index].reward == 0)
                                    Text(
                                        '\$ ${numberFormat.format(widget.data![index].totalCost!)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold))
                                  else
                                    Text(
                                        // '${numberFormat.format(double.parse(widget.data![index].totalCost!))} pts',
                                        '${widget.data![index].totalCost!} pts',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                color: mainColor,
                                                fontWeight: FontWeight.bold)),
                                  SizedBox(width: 0.9.w),
                                  Flexible(
                                    child: Text(
                                        '${widget.data![index].sizeDescription?.trim()}',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                            color: Colors.grey)
                                    ),
                                  ),
                                  SizedBox(width: 1.h),

                                  // Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: rewardview.reward == 1
                                  //       ? _buildChip(
                                  //     label: 'Reward Product',
                                  //     color: Colors.blueAccent,
                                  //     onSelected: (value) {
                                  //       Map values = {
                                  //         'CardUuid': widget.data![index].id,
                                  //         'id': cardViewValues.id,
                                  //         'name': cardViewValues.name,
                                  //         'image': cardViewValues.image,
                                  //         'protuctquantiy': widget.data![index].quantity,
                                  //         'defaultsize': defaultSize,
                                  //         'SelectedItem':
                                  //         widget.data![index].itemIds!.split(','),
                                  //         'route': 'favouriteScreen'
                                  //       };
                                  //       Get.toNamed(Routes.rewardsCustomizeScreen,
                                  //           arguments: values);
                                  //       Get.delete<CartController>();
                                  //     },
                                  //   )
                                  //       : _buildChip(
                                  //       label: 'Customized',
                                  //       color: Colors.redAccent,
                                  //       onSelected: (value) {
                                  //         Map values = {
                                  //           'CardUuid': widget.data![index].id,
                                  //           'id': cardViewValues.id,
                                  //           'name': cardViewValues.name,
                                  //           'image': cardViewValues.image,
                                  //           'protuctquantiy': widget.data![index].quantity,
                                  //           'defaultsize': defaultSize,
                                  //           'SelectedItem':
                                  //           widget.data![index].itemIds!.split(','),
                                  //           'route': 'favouriteScreen'
                                  //         };
                                  //         Get.toNamed(Routes.productCustomizeScreen,
                                  //             arguments: values);
                                  //         Get.delete<CartController>();
                                  //       }),
                                  // ),
                                ],
                              ),
                              // customizeText(defaultCustom: rewardview.defaultCustom!, reward: rewardview.reward!),
                              // Text( rewardview.defaultCustom == 1?'':'Customize',
                              //     style: TextStore.textTheme.titleLarge!
                              //         .copyWith(
                              //         color:rewardview.defaultCustom == 1? Colors.green:mainColor)),
                              // Text( rewardview.reward == 1?'Reward product':'',
                              //     style: TextStore.textTheme.titleLarge!
                              //         .copyWith(
                              //         color:rewardview.reward == 1? Colors.blue:mainColor)),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  addButton(
                                      index: index,
                                      id: widget.data![index].id!),
                                  Row(
                                    children: [
                                      // SizedBox(
                                      //     height: 3.h,
                                      //     width: 16.w,
                                      //     child:  IconButton(
                                      //       padding:  const EdgeInsets.all(0.0),
                                      //       color:Colors.black,
                                      //       icon:   Icon(Icons.edit_outlined,size: 20.sp),
                                      //       onPressed: (){
                                      //         if (widget.data![index].reward == 0) {
                                      //           Map values = {
                                      //             'CardUuid':
                                      //             widget.data![index].id,
                                      //             'id': cardViewValues.id,
                                      //             'name': cardViewValues.name,
                                      //             'image': cardViewValues.image,
                                      //             'protuctquantiy':
                                      //             widget.data![index].quantity,
                                      //             'defaultsize': defaultSize,
                                      //             'SelectedItem': widget
                                      //                 .data![index].itemIds!
                                      //                 .split(','),
                                      //             'route': 'favouriteScreen'
                                      //           };
                                      //           Get.toNamed(
                                      //               Routes.productCustomizeScreen,
                                      //               arguments: values);
                                      //           Get.delete<CartController>();
                                      //         } else {
                                      //           Map values = {
                                      //             'CardUuid':
                                      //             widget.data![index].id,
                                      //             'id': cardViewValues.id,
                                      //             'name': cardViewValues.name,
                                      //             'image': cardViewValues.image,
                                      //             'protuctquantiy':
                                      //             widget.data![index].quantity,
                                      //             'defaultsize': defaultSize,
                                      //             'SelectedItem': widget
                                      //                 .data![index].itemIds!
                                      //                 .split(','),
                                      //             'route': 'favouriteScreen'
                                      //           };
                                      //           Get.toNamed(
                                      //               Routes.rewardsCustomizeScreen,
                                      //               arguments: values);
                                      //           Get.delete<CartController>();
                                      //         }
                                      //       },
                                      //     )
                                      // ),
                                      GestureDetector(
                                          onTap: () {
                                            tapFunction(
                                                index: index,
                                                cardViewValues: cardViewValues);
                                          },
                                          child: imageview1(
                                              ImageAsset.editIcon,   Get.isDarkMode ? Colors.white : Colors.black)
                                          //     Image.asset(
                                          //       ImageAsset.editIcon,
                                          //       width: 6.w,
                                          //       height: 6.h,
                                          //       color: Colors.black,
                                          //     )
                                          ),
                                      SizedBox(width: 6.w),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.controller!

                                                  .cartDeleteAlertDialog(
                                                      selectedIndex: index);
                                            });
                                          },
                                          child: imageview1(
                                              ImageAsset.deleteIcon,
                                              Colors.red)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w),
                        GestureDetector(
                          onTap: () {
                            tapFunction(
                                index: index, cardViewValues: cardViewValues);
                          },
                          child: FittedBox(
                            child: SizedBox(
                              height: 15.h,
                              width: getDeviceType() == 'phone' ? 27.w : 23.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4.w),
                                child: ImageView(
                                  imageUrl: imageview(
                                      widget.data![index].product!.image!),
                                  showValues: false,
                                  mainImageViewWidth: 34.w,
                                  bottomImageViewHeight: 5.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  rewardview.itemNames!.isNotEmpty
                      ? Row(
                          children: [
                            Flexible(
                              child: customizeText(
                                  defaultCustom: rewardview.defaultCustom!,
                                  reward: rewardview.reward!,
                                  names: rewardview.itemNames == null &&
                                          rewardview.itemNames == ''
                                      ? ''
                                      : rewardview.itemNames!
                                          .replaceAll(",", " , ")),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 0.4.h, right: 1.h),
                    child:   DividerView(
                      values: 1,
                      colorValues: Get.isDarkMode?Colors.white24:Colors.black26 ,
                    ),
                    // child: const Divider(
                    //   color: Colors.black26,
                    //   thickness: 2.0,
                    // ),
                  )
                ],
              );
            }),
      ),
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  imageview1(String? name, Color? colorValues) {

    return Image.asset(name!,
        width: getDeviceType() == 'phone' ? 6.w : 4.w,
        height: getDeviceType() == 'phone' ? 6.h : 4.h,
        color: colorValues);
  }

  Widget addButton({required int index, required int id}) {
    Color? color = Get.isDarkMode ? Colors.white : Colors.black;
    return Row(
      children: [
        InkWell(
            onTap: () {
              if (widget.data![index].quantity! > 1) {
                widget.controller!.cartCountUpdate(
                    selectedIndex: index, isIncreasing: false, id: id);
              }
            },
            child: Container(
                padding: EdgeInsets.all(0.6.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), //color: mainColor,
                    border: Border.all(width: 1, color: Colors.grey.shade500)),
                child: Icon(Icons.remove, color: color))),
        Container(
            width: 14.w,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.6.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.white),
            child: Center(
              child: Text('${widget.data![index].quantity!}',
                  style: context.theme.textTheme.displaySmall!
                      .copyWith(color: mainColor, fontWeight: FontWeight.bold)),
            )),
        InkWell(
            onTap: () {
              widget.controller!.cartCountUpdate(
                  selectedIndex: index, isIncreasing: true, id: id);
            },
            child: Container(
                padding: EdgeInsets.all(0.6.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), //color: mainColor,
                    border: Border.all(width: 1, color: Colors.grey.shade500)),
                child: Icon(Icons.add, color: color))),
      ],
    );
  }

  customizeText(
      {required int defaultCustom, required int reward, String? names}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(richTextFactor(defaultCustom, reward, names!),
            style: context.theme.textTheme.headlineSmall!.copyWith(
                color: richTextFactor1(defaultCustom, reward),
                fontWeight: FontWeight.bold)),
        names.isNotEmpty
            ? (names.length < 64
                ? Text(names,
                    style: context.theme.textTheme.titleLarge!
                        .copyWith(color:  Get.isDarkMode ? Colors.white : borderColor))
                : ExpandableText("$names'", trimLines: 1))
            : Text(names,
                style:
                context.theme.textTheme.titleLarge!.copyWith(color: Get.isDarkMode ? Colors.white : borderColor))
      ],
    );
    // if (defaultCustom == 0) {
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text('Customized Items   ',
    //         style: TextStore.textTheme.headlineSmall!
    //             .copyWith(color: mainColor, fontWeight: FontWeight.bold)),
    //     ExpandableText("$names'", trimLines: 2)
    //   ],
    // );
    // } else if (reward == 1) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Reward Product Items   ',
    //           style: TextStore.textTheme.headlineSmall!
    //               .copyWith(color: mainColor, fontWeight: FontWeight.bold)),
    //       ExpandableText("$names'", trimLines: 2)
    //     ],
    //   );
    // } else {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Default Items  ',
    //           style: TextStore.textTheme.headlineSmall!
    //               .copyWith(color:Colors.blue , fontWeight: FontWeight.bold)),
    //       ExpandableText("$names'", trimLines: 2)
    //     ],
    //   );
    // }
  }

  richTextFactor(int defaultValues, int reward, String? names) {
    if (reward == 1) {
      return defaultValues == 0
          ? 'Reward Customized Items '
          : 'Reward Default Items';
    } else {
      return defaultValues == 0
          ? 'Customized Items'
          : (names!.isNotEmpty ? 'Default Items' : '');
    }
  }

  richTextFactor1(int defaultValues, int reward) {
    if (reward == 1) {
      return Colors.blue;
    } else {
      return mainColor;
    }
  }

  void tapFunction({int? index, Product? cardViewValues}) {
    if (widget.data![index!].reward == 0) {
      Map values = {
        'CardUuid': widget.data![index].id,
        'id': cardViewValues!.id,
        'name': cardViewValues.name,
        'image': cardViewValues.image,
        'protuctquantiy': widget.data![index].quantity,
        'defaultsize': widget.data![index].defaultSize!,
        'SelectedItem': widget.data![index].itemIds!.split(','),
        'route': 'favouriteScreen',
        'totalCost': widget.data![index].totalCost,
        'defaultPrize': widget.data![index].productPrice
      };
      Get.toNamed(Routes.productCustomizeScreen, arguments: values);
    } else {
      Map values = {
        'CardUuid': widget.data![index].id,
        'id': cardViewValues!.id,
        'name': cardViewValues.name,
        'image': cardViewValues.image,
        'protuctquantiy': widget.data![index].quantity,
        'defaultsize': widget.data![index].defaultSize!,
        'SelectedItem': widget.data![index].itemIds!.split(','),
        'route': 'favouriteScreen',
        'totalCost': widget.data![index].totalCost,
        'defaultPrize': widget.data![index].productPrice
      };
      Get.toNamed(Routes.rewardsCustomizeScreen, arguments: values);
    }
  }
}
