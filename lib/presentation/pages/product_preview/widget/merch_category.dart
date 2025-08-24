import 'package:dip_menu/extra/common_widgets/counter_increment.dart';
import 'package:dip_menu/extra/common_widgets/description_text.dart';
import 'package:dip_menu/extra/common_widgets/fav_login_alert_dialog.dart';
import 'package:dip_menu/presentation/logic/controller/product_preview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dip_menu/presentation/pages/index.dart';
import 'dropdown_button.dart';

class MerchCategory extends StatefulWidget {
  MerchCategory({Key? key, this.productPreviewController}) : super(key: key);
  ProductPreviewController? productPreviewController;

  @override
  State<MerchCategory> createState() => _MerchCategoryState();

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}

class _MerchCategoryState extends State<MerchCategory> {
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
                              imageUrl: imageview( widget.productPreviewController!.merchCategoryImages![
                              widget.productPreviewController!
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
            Row(children: [priceContent(), totalPrizeValues(),   const Spacer(flex: 2),favouriteContent()]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [productDropdown(), addButton()])
          ]),
    );
  }

  Widget productName() {
    return Flexible(
      child: Text(widget.productPreviewController?.argumentData['name'],
          overflow: TextOverflow.clip,
          style: TextStore.textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Get.isDarkMode ? Colors.white : Colors.black)),
    );
  }

  Widget priceContent() {
    return widget.productPreviewController?.slashedPrice == 0.0
        ? const SizedBox()
        : GetBuilder<ProductPreviewController>(builder: (_) {
            return Padding(
                padding: EdgeInsets.only(
                    left: 1.w,
                    right: 1.w,
                    bottom:
                        widget.productPreviewController!.productDescription!.isEmpty
                            ? 0
                            : 0.h),
                child: Text(
                    '\$ ${numberFormat.format(widget.productPreviewController?.slashedPrice)}',
                    style: TextStore.textTheme.displaySmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w300,
                        color: mainColor)));
          });
  }

  Widget onlinePrice() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
            left: 5.w,
            right: 1.w,
            bottom: widget.productPreviewController!.productDescription!.isEmpty
                ? 0
                : 0.h),
        child: widget.productPreviewController!.totalPrice == 0.0
            ? Text(
                '\$ ${numberFormat.format(widget.productPreviewController!.priceCalculation1(1, double.parse(widget.productPreviewController!.totalPrice.toStringAsFixed(2))))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green))
            : Text(
                '\$ ${numberFormat.format(double.parse(widget.productPreviewController!.totalPrice.toStringAsFixed(2)))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green)),
      );
    });
  }

  Widget favouriteContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (SharedPrefs.instance.getString('token') != null) {
            if (widget.productPreviewController!.isFavourite == true) {
              widget.productPreviewController!.favouriteValuesChecking =
              'favouriteScreen';
              widget.productPreviewController!.isFavourite = false;
              widget.productPreviewController!.removeFavourite(
                  productCode: widget.productPreviewController!.productID!);
            } else if (widget.productPreviewController!.isFavourite == false) {
              widget.productPreviewController!.favouriteValuesChecking =
              'favouriteScreen';
              widget.productPreviewController!.isFavourite = true;
              widget.productPreviewController!.someFavouriteValuesChecking();
            }
          } else {
            FavLoginPopUp().showFavLoginAlertDialog(Get.context!,
                userNameController: widget.productPreviewController!.emailController,
                passWordController: widget.productPreviewController!.passwordController,
                onButtonTapped: () {
                  String email =
                  widget.productPreviewController!.emailController.text.trim();
                  String password =
                  widget.productPreviewController!.passwordController.text.trim();
                  widget.productPreviewController!.productPreviewFavLogin(
                      email: email,
                      password: password,
                      productCode: widget.productPreviewController!.productID!,
                      status: '0');
                });
            // showFavLoginAlertDialog(context);
          }
        });
      },
      child: widget.productPreviewController!.isFavourite == true
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
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return HandlingDataView(
          statusRequest: widget.productPreviewController!.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                widget.productPreviewController!.increaseCount();
              },
              onDecrementSelected: () {
                widget.productPreviewController!.decreaseCount();
              },
              label: Text(widget.productPreviewController!.productQuality.toString(),
                  style: TextStore.textTheme.displaySmall?.copyWith(
                      color: Get.isDarkMode ? Colors.white : borderColor,
                      fontWeight: FontWeight.bold))));
    });
  }

  Widget productDescription1() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return widget.productPreviewController!.productDescription!.isEmpty
          ? Container()
          : (widget.productPreviewController!.productDescription!.isNotEmpty
              ? (widget.productPreviewController!.productDescription!.length < 64
                  ? Text(widget.productPreviewController!.productDescription!,
                      textAlign: TextAlign.left,
                      style: TextStore.textTheme.headlineSmall!.copyWith(
                          fontSize: 11.sp,
                          color: Get.isDarkMode ? Colors.white : borderColor))
                  : ExpandableText(
                      widget.productPreviewController!.productDescription!,
                      trimLines: 2))
              : Text(widget.productPreviewController!.productDescription!,
                  textAlign: TextAlign.left,
                  style: TextStore.textTheme.headlineSmall!.copyWith(
                      fontSize: 11.sp,
                      color: Get.isDarkMode ? Colors.white : borderColor)));
    });
  }

  Widget totalPrizeValues() {
    return Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Text('Total Price',
          //     style: TextStore.textTheme.headlineMedium?.copyWith(
          //         color: Get.isDarkMode ? Colors.white : Colors.black,
          //         fontWeight: FontWeight.bold)),
          GetBuilder<ProductPreviewController>(builder: (_) {
            String values = widget.productPreviewController!
                .priceCalculation1(
                    widget.productPreviewController!.productQuality.toInt(),
                    widget.productPreviewController!.totalPrice)
                .toStringAsFixed(2);
            return Text('\$ ${numberFormat.format(double.parse(values))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green));
          })
        ]);
  }

  Widget productDropdown() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return Container(
        padding: EdgeInsets.only(left: 1.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                GetBuilder<ProductPreviewController>(builder: (_) {
                  return HandlingDataView(
                      statusRequest: widget.productPreviewController!
                          .statusRequestProductPreview!,
                      widget: DropdownMethod(
                          controller: widget.productPreviewController!,
                          onViewbuttonpressed: (dynamic) {
                            widget. productPreviewController!.handleDropdownSelection(
                                item: widget.productPreviewController!
                                    .dropdownChooseingValues(dynamic));
                          }));
                })
              ]),
        ]),
      );
    });
  }

  horizontalListview() {
    return GetBuilder<ProductPreviewController>(builder: (_) {
      return SizedBox(
        height: 14.h,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.productPreviewController!.merchCategoryImages?.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                onTap: () {
                  widget.productPreviewController!.merchCategoryChangeImages(i);
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
                        imageUrl:imageview( widget.productPreviewController!.merchCategoryImages![i]),
                        // imageUrl:productPreviewController!.merchCategoryImages![i],
                        showValues: true,
                        mainImageViewWidth: 34.w,
                        bottomImageViewHeight: 5.h,
                        index: i,
                        selectedIndex:
                            widget.productPreviewController!.merchCategoryImageValues,
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
