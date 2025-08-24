import 'package:dip_menu/extra/common_widgets/counter_increment.dart';
import 'package:dip_menu/extra/common_widgets/description_text.dart';
import 'package:dip_menu/presentation/logic/controller/rewards_product_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../product_preview/widget/merch_category.dart';
import 'dropdown_rewards.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class RewardMerchCategory extends StatefulWidget {
  RewardMerchCategory({Key? key, this.rewardsProductPreviewController}) : super(key: key);
  RewardsProductController? rewardsProductPreviewController;

  @override
  State<RewardMerchCategory> createState() => _MerchCategoryState();

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}

class _MerchCategoryState extends State<RewardMerchCategory> {
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
                              imageUrl: imageview( widget.rewardsProductPreviewController!.merchCategoryImages![
                              widget.rewardsProductPreviewController!
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
      child: Text(widget.rewardsProductPreviewController?.argumentData['name'],
          overflow: TextOverflow.clip,
          style: TextStore.textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black)),
    );
  }


  Widget priceContent() {
    return GetBuilder<RewardsProductController>(builder: (_) {
      return Text(
          '${widget.rewardsProductPreviewController?.priceCalculation1(widget.rewardsProductPreviewController!.productQuality.toInt(), widget.rewardsProductPreviewController!.totalPrice)} pts',
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
          if (widget.rewardsProductPreviewController?.isFavourite == true) {
            widget.rewardsProductPreviewController?.favouriteValues = 'favouriteScreen';
            widget.rewardsProductPreviewController?.isFavourite = false;
            widget.rewardsProductPreviewController?.removeFavourite(
                productCode: widget.rewardsProductPreviewController!.productID!);
          } else if (widget.rewardsProductPreviewController?.isFavourite == false) {
            widget.rewardsProductPreviewController?.favouriteValues = 'favouriteScreen';
            widget.rewardsProductPreviewController?.isFavourite = true;
            widget.rewardsProductPreviewController?.someFavouriteValuesChecking();
          }
        });
      },
      child: widget.rewardsProductPreviewController!.isFavourite == true
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
    return GetBuilder<RewardsProductController>(builder: (_) {
      return HandlingDataView(
          statusRequest: widget.rewardsProductPreviewController!.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                widget.rewardsProductPreviewController!.increaseCount();
              },
              onDecrementSelected: () {
                widget.rewardsProductPreviewController!.decreaseCount();
              },
              label: Text(widget.rewardsProductPreviewController!.productQuality.toString(),
                  style: TextStore.textTheme.displaySmall?.copyWith(
                      color: Get.isDarkMode ? Colors.white : borderColor,
                      fontWeight: FontWeight.bold))));
    });
  }

  Widget productDescription1() {
    return GetBuilder<RewardsProductController>(builder: (_) {
      return widget.rewardsProductPreviewController!.productDescription!.isEmpty
          ? Container()
          : (widget.rewardsProductPreviewController!.productDescription!.isNotEmpty
          ? (widget.rewardsProductPreviewController!.productDescription!.length < 64
          ? Text(widget.rewardsProductPreviewController!.productDescription!,
          textAlign: TextAlign.left,
          style: TextStore.textTheme.headlineSmall!.copyWith(
              fontSize: 11.sp,
              color: Get.isDarkMode ? Colors.white : borderColor))
          : ExpandableText(
          widget.rewardsProductPreviewController!.productDescription!,
          trimLines: 2))
          : Text(widget.rewardsProductPreviewController!.productDescription!,
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
            widget.rewardsProductPreviewController!.statusRequestProductPreview!,
            widget: RewardsDropdownMethod(
                controller:  widget.rewardsProductPreviewController!,
                onViewbuttonpressed: (dynamic) {
                  widget.rewardsProductPreviewController!.handleDropdownSelection(
                      item:  widget.rewardsProductPreviewController!
                          .dropdownChooseingValues(dynamic));
                })));
  }

  horizontalListview() {
    return GetBuilder<RewardsProductController>(builder: (_) {
      return SizedBox(
        height: 14.h,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.rewardsProductPreviewController!.merchCategoryImages?.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                onTap: () {
                  widget.rewardsProductPreviewController!.merchCategoryChangeImages(i);
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
                        imageUrl:imageview( widget.rewardsProductPreviewController!.merchCategoryImages![i]),
                        // imageUrl:productPreviewController!.merchCategoryImages![i],
                        showValues: true,
                        mainImageViewWidth: 34.w,
                        bottomImageViewHeight: 5.h,
                        index: i,
                        selectedIndex:
                        widget.rewardsProductPreviewController!.merchCategoryImageValues,
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
