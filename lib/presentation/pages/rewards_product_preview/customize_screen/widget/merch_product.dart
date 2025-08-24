import 'package:dip_menu/extra/common_widgets/counter_increment.dart';
import 'package:dip_menu/extra/common_widgets/description_text.dart';
import 'package:dip_menu/presentation/pages/product_preview/widget/merch_category.dart';
import 'package:dip_menu/presentation/pages/rewards_product_preview/customize_screen/widget/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../logic/controller/rewards_customize_edit_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';




class CustomizeRewardMerchCategory extends StatefulWidget {
  CustomizeRewardMerchCategory({Key? key, this.rewardsCustomizeEditController}) : super(key: key);
  RewardsCustomizeEditController? rewardsCustomizeEditController;

  @override
  State<CustomizeRewardMerchCategory> createState() => _MerchCategoryState();

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}

class _MerchCategoryState extends State<CustomizeRewardMerchCategory> {
  final numberFormat = NumberFormat("#,##0.00##", "en_US");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, right: 2.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Card(
                elevation: 0,
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: SizedBox(
                      height: 40.h,
                      width: 70.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.w),
                          child: ImageView(
                              imageUrl: imageview( widget.rewardsCustomizeEditController!.merchCategoryImages![
                              widget.rewardsCustomizeEditController!
                                  .merchCategoryImageValues]),
                              // imageUrl:  productPreviewController!.merchCategoryImages![
                              // productPreviewController!
                              //     .merchCategoryImageValues],
                              showValues: false,
                              mainImageViewWidth: 35.w,
                              bottomImageViewHeight: 5.h))),
                )),
            horizontalListview(),
            productName(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: productDescription1()),
            Row(children: [priceContent(),   const Spacer(flex: 2),favouriteContent()]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [chooseSize(), addButton()])
          ]),
    );
  }

  Widget productName() {
    return Flexible(
      child: Text(widget.rewardsCustomizeEditController?.argumentData['name'],
          overflow: TextOverflow.clip,
          style: TextStore.textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black)),
    );
  }


  Widget priceContent() {
    return GetBuilder<RewardsCustomizeEditController>(builder: (_) {
      return Text(
          '${widget.rewardsCustomizeEditController?.priceCalculation1(widget.rewardsCustomizeEditController!.productQuality.toInt(), widget.rewardsCustomizeEditController!.totalPrice)} pts',
          style: TextStore.textTheme.displaySmall?.copyWith(color: mainColor));
    });
  }
  // Widget priceContent() {
  //   return widget.rewardsProductPreviewController?.slashedPrice == 0.0
  //       ? const SizedBox()
  //       : GetBuilder<ProductPreviewController>(builder: (_) {
  //     return Padding(
  //         padding: EdgeInsets.only(
  //             left: 1.w,
  //             right: 1.w,
  //             bottom:
  //             widget.rewardsProductPreviewController!.productDescription!.isEmpty
  //                 ? 0
  //                 : 0.h),
  //         child: Text(
  //             '\$ ${numberFormat.format(widget.productPreviewController?.slashedPrice)}',
  //             style: TextStore.textTheme.displaySmall?.copyWith(
  //                 decoration: TextDecoration.lineThrough,
  //                 fontWeight: FontWeight.w300,
  //                 color: mainColor)));
  //   });
  // }
  //
  // Widget onlinePrice() {
  //   return GetBuilder<ProductPreviewController>(builder: (_) {
  //     return Padding(
  //       padding: EdgeInsets.only(
  //           left: 5.w,
  //           right: 1.w,
  //           bottom: widget.productPreviewController!.productDescription!.isEmpty
  //               ? 0
  //               : 0.h),
  //       child: widget.productPreviewController!.totalPrice == 0.0
  //           ? Text(
  //           '\$ ${numberFormat.format(widget.productPreviewController!.priceCalculation1(1, double.parse(widget.productPreviewController!.totalPrice.toStringAsFixed(2))))}',
  //           style: TextStore.textTheme.displaySmall?.copyWith(
  //               fontWeight: FontWeight.w900, color: Colors.green))
  //           : Text(
  //           '\$ ${numberFormat.format(double.parse(widget.productPreviewController!.totalPrice.toStringAsFixed(2)))}',
  //           style: TextStore.textTheme.displaySmall?.copyWith(
  //               fontWeight: FontWeight.w900, color: Colors.green)),
  //     );
  //   });
  // }

  Widget favouriteContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.rewardsCustomizeEditController?.isFavourite == true) {
            widget.rewardsCustomizeEditController?.favouriteValues = 'favouriteScreen';
            widget.rewardsCustomizeEditController?.isFavourite = false;
            widget.rewardsCustomizeEditController?.removeFavourite(
                productCode: widget.rewardsCustomizeEditController!.productID!);
          } else if (widget.rewardsCustomizeEditController?.isFavourite == false) {
            widget.rewardsCustomizeEditController?.favouriteValues = 'favouriteScreen';
            widget.rewardsCustomizeEditController?.isFavourite = true;
            widget.rewardsCustomizeEditController?.someFavouriteValuesChecking();
          }
        });
      },
      child: widget.rewardsCustomizeEditController!.isFavourite == true
          ? SizedBox(
          height: 5.h,
          width: 12.w,
          child: Icon(Icons.favorite,
              size: MerchCategory.getDeviceType() == 'phone' ? 26.sp : 13.sp,
              color: Colors.red))
          : SizedBox(
          height: 5.h,
          width: 12.w,
          child: Icon(Icons.favorite_outline_outlined,
              size: MerchCategory.getDeviceType() == 'phone' ? 26.sp : 13.sp,
              color: Colors.grey)),
    );
  }

  Widget addButton() {
    return GetBuilder<RewardsCustomizeEditController>(builder: (_) {
      return HandlingDataView(
          statusRequest: widget.rewardsCustomizeEditController!.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                widget.rewardsCustomizeEditController!.increaseCount();
              },
              onDecrementSelected: () {
                widget.rewardsCustomizeEditController!.decreaseCount();
              },
              label: Text(widget.rewardsCustomizeEditController!.productQuality.toString(),
                  style: TextStore.textTheme.displaySmall?.copyWith(
                      color: Get.isDarkMode ? Colors.white : borderColor,
                      fontWeight: FontWeight.bold))));
    });
  }

  Widget productDescription1() {
    return GetBuilder<RewardsCustomizeEditController>(builder: (_) {
      return widget.rewardsCustomizeEditController!.productDescription!.isEmpty
          ? Container()
          : (widget.rewardsCustomizeEditController!.productDescription!.isNotEmpty
          ? (widget.rewardsCustomizeEditController!.productDescription!.length < 64
          ? Text(widget.rewardsCustomizeEditController!.productDescription!,
          textAlign: TextAlign.left,
          style: TextStore.textTheme.headlineSmall!.copyWith(
              fontSize: 11.sp,
              color: Get.isDarkMode ? Colors.white : borderColor))
          : ExpandableText(
          widget.rewardsCustomizeEditController!.productDescription!,
          trimLines: 2))
          : Text(widget.rewardsCustomizeEditController!.productDescription!,
          textAlign: TextAlign.left,
          style: TextStore.textTheme.headlineSmall!.copyWith(
              fontSize: 11.sp,
              color: Get.isDarkMode ? Colors.white : borderColor)));
    });
  }

  // Widget totalPrizeValues() {
  //   return Wrap(
  //       direction: Axis.vertical,
  //       crossAxisAlignment: WrapCrossAlignment.center,
  //       children: [
  //         // Text('Total Price',
  //         //     style: TextStore.textTheme.headlineMedium?.copyWith(
  //         //         color: Get.isDarkMode ? Colors.white : Colors.black,
  //         //         fontWeight: FontWeight.bold)),
  //         GetBuilder<ProductPreviewController>(builder: (_) {
  //           String values = widget.productPreviewController!
  //               .priceCalculation1(
  //               widget.productPreviewController!.productQuality.toInt(),
  //               widget.productPreviewController!.totalPrice)
  //               .toStringAsFixed(2);
  //           return Text('\$ ${numberFormat.format(double.parse(values))}',
  //               style: TextStore.textTheme.displaySmall?.copyWith(
  //                   fontWeight: FontWeight.w900, color: Colors.green));
  //         })
  //       ]);
  // }

  Widget chooseSize() {
    return Padding(
        padding: EdgeInsets.only(left: 3.w, right: 2.w, top: 1.w),
        child: HandlingDataView(
            statusRequest:
            widget.rewardsCustomizeEditController!.statusRequestProductPreview!,
            widget: RewardDropdown(
                controller:  widget.rewardsCustomizeEditController!,
                onViewbuttonpressed: (dynamic) {
                  widget.rewardsCustomizeEditController!.handleDropdownSelection(
                      item:  widget.rewardsCustomizeEditController!
                          .dropdownChooseingValues(dynamic));
                })));
  }

  horizontalListview() {
    return GetBuilder<RewardsCustomizeEditController>(builder: (_) {
      return SizedBox(
        height: 14.h,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.rewardsCustomizeEditController!.merchCategoryImages?.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                onTap: () {
                  widget.rewardsCustomizeEditController!.merchCategoryChangeImages(i);
                  // tempValues = i;
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 2.3.w, right: 2.3.w),
                  child: SizedBox(
                    height: 10.h,
                    width: 24.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.w),
                      child: ImageView(
                        imageUrl:imageview( widget.rewardsCustomizeEditController!.merchCategoryImages![i]),
                        // imageUrl:productPreviewController!.merchCategoryImages![i],
                        showValues: true,
                        mainImageViewWidth: 34.w,
                        bottomImageViewHeight: 5.h,
                        index: i,
                        selectedIndex:
                        widget.rewardsCustomizeEditController!.merchCategoryImageValues,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
