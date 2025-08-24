import 'package:dip_menu/extra/common_widgets/counter_increment.dart';
import 'package:dip_menu/extra/common_widgets/description_text.dart';
import 'package:dip_menu/extra/common_widgets/fav_login_alert_dialog.dart';
import 'package:dip_menu/presentation/logic/controller/customize_edit_controller.dart';
import 'package:dip_menu/presentation/pages/product_preview/cutomize_edit_screen/widget/customize_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dip_menu/presentation/pages/index.dart';



// ignore: must_be_immutable
class CustomMerchCategory extends StatefulWidget {
  CustomMerchCategory({Key? key, this.customizeEditController}) : super(key: key);
  CustomizeEditController? customizeEditController;


  @override
  State<CustomMerchCategory> createState() => _CustomMerchCategoryState();

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}

class _CustomMerchCategoryState extends State<CustomMerchCategory> {
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
                  padding: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: SizedBox(
                      height: 40.h,
                      width: 70.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.w),
                          child: ImageView(
                              imageUrl: imageview( widget.customizeEditController!.merchCategoryImages![
                              widget.customizeEditController!
                                  .merchCategoryImageValues]),
                              showValues: false,
                              mainImageViewWidth: 35.w,
                              bottomImageViewHeight: 5.h))),
                )),
            horizontalListview(),
            productName(),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: productDescription1()),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [priceContent(), totalPrizeValues(),const Spacer(flex: 2),favouriteContent()]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [productDropdown(), addButton()])
          ]),
    );
  }

  Widget productName() {
    return Flexible(
      child: Text(widget.customizeEditController?.argumentData['name'],
          overflow: TextOverflow.clip,
          style: TextStore.textTheme.headlineMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.white : Colors.black)),
    );
  }

  Widget priceContent() {
    return widget.customizeEditController?.slashedPrice == 0.0
        ? const SizedBox()
        : GetBuilder<CustomizeEditController>(builder: (_) {
      return Padding(
        padding: EdgeInsets.only(
            left: 1.w,
            right: 1.w,
            bottom: widget.customizeEditController
                !.productDescription!.isEmpty
                ? 0
                : 0.h),
        child: Text(
            '\$ ${numberFormat.format(widget.customizeEditController?.slashedPrice)}',
            style: TextStore.textTheme.displaySmall?.copyWith(
                decoration: TextDecoration.lineThrough,
                fontWeight: FontWeight.w300,
                color: mainColor)),
      );
    });
  }

  Widget addButton() {
    return GetBuilder<CustomizeEditController>(builder: (_) {
      return HandlingDataView(
          statusRequest: widget.customizeEditController!.statusRequestProductPreview!,
          widget: CounterButton(
              onIncrementSelected: () {
                widget.customizeEditController!.increaseCount();
              },
              onDecrementSelected: () {
                widget.customizeEditController!.decreaseCount();
              },
              label: Text(widget.customizeEditController!.custProductQuanity.toString(),
                  style: TextStore.textTheme.displaySmall?.copyWith(
                      color: Get.isDarkMode ? Colors.white : borderColor,
                      fontWeight: FontWeight.bold))));
    });
  }

  Widget productDescription1() {
    return GetBuilder<CustomizeEditController>(builder: (_) {
      return widget.customizeEditController!.productDescription!.isEmpty
          ? Container()
          : (widget.customizeEditController!.productDescription!.isNotEmpty
          ? (widget.customizeEditController!.productDescription!.length < 64
          ? Text(widget.customizeEditController!.productDescription!,
          textAlign: TextAlign.left,
          style: TextStore.textTheme.headlineSmall!.copyWith(
              fontSize: 11.sp,
              color: Get.isDarkMode ? Colors.white : borderColor))
          : ExpandableText(
          widget.customizeEditController!.productDescription!,
          trimLines: 2))
          : Text(widget.customizeEditController!.productDescription!,
          textAlign: TextAlign.left,
          style: TextStore.textTheme.headlineSmall!.copyWith(
              fontSize: 11.sp,
              color: Get.isDarkMode ? Colors.white : borderColor)));
    });
  }

  Widget favouriteContent() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (SharedPrefs.instance.getString('token') != null) {
            if (widget.customizeEditController!.isFavourite == true) {
              widget.customizeEditController!.favouriteValues =
              'favouriteScreen';
              widget.customizeEditController!.isFavourite = false;
              widget.customizeEditController!.removeFavourite(
                  productCode: widget.customizeEditController!.productID!);
            } else if (widget.customizeEditController!.isFavourite == false) {
              widget.customizeEditController!.favouriteValues =
              'favouriteScreen';
              widget.customizeEditController!.isFavourite = true;
              widget.customizeEditController!.someFavouriteValuesChecking();
            }
          } else {
            FavLoginPopUp().showFavLoginAlertDialog(Get.context!,
                userNameController:
                widget.customizeEditController!.emailController,
                passWordController: widget.customizeEditController!
                    .passwordController, onButtonTapped: () {
                  String email =
                  widget.customizeEditController!.emailController.text.trim();
                  String password = widget.customizeEditController!
                      .passwordController.text
                      .trim();
                  widget.customizeEditController!.productPreviewFavLogin(
                      email: email,
                      password: password,
                      productCode: widget.customizeEditController!.productID!,
                      status: '0');
                });
          }
        });
      },
      child: widget.customizeEditController!.isFavourite == true
          ? SizedBox(
          height: 5.h,
          width: 12.w,
          child: Icon(Icons.favorite,
              size: CustomMerchCategory.getDeviceType() == 'phone' ? 26.sp : 13.sp,
              color: Colors.red))
          : SizedBox(
          height: 5.h,
          width: 12.w,
          child: Icon(Icons.favorite_outline_outlined,
              size: CustomMerchCategory.getDeviceType() == 'phone' ? 26.sp : 13.sp,
              color: Colors.grey)),
    );
  }

  Widget totalPrizeValues() {
    return Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          GetBuilder<CustomizeEditController>(builder: (_) {
            String values = widget.customizeEditController!
                .priceCalculation1(
                widget.customizeEditController!.custProductQuanity.toInt(),
                widget.customizeEditController!.defaultPrice)
                .toStringAsFixed(2);
            return Text('\$ ${numberFormat.format(double.parse(values))}',
                style: TextStore.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.green));
          })
        ]);
  }

  Widget productDropdown() {
    return GetBuilder<CustomizeEditController>(builder: (_) {
      return Container(
        padding: EdgeInsets.only(left: 1.w),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                GetBuilder<CustomizeEditController>(builder: (_) {
                  return HandlingDataView(
                      statusRequest: widget.customizeEditController!
                          .statusRequestProductPreview!,
                      widget: CustomizeDropdown(
                          controller: widget.customizeEditController!,
                          onViewbuttonpressed: (dynamic) {
                            widget.customizeEditController!.handleDropdownSelection(
                                item: widget.customizeEditController!
                                    .dropdownChooseingValues(dynamic));
                          }));
                })
              ]),
        ]),
      );
    });
  }

  horizontalListview() {
    return GetBuilder<CustomizeEditController>(builder: (_) {
      return SizedBox(
        height: 14.h,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.customizeEditController!.merchCategoryImages?.length,
            itemBuilder: (BuildContext context, int i) {
              return InkWell(
                onTap: () {
                  widget.customizeEditController!.merchCategoryChangeImages(i);
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
                        imageUrl:imageview( widget.customizeEditController!.merchCategoryImages![i]),
                        showValues: true,
                        mainImageViewWidth: 34.w,
                        bottomImageViewHeight: 5.h,
                        index: i,
                        selectedIndex:
                        widget.customizeEditController!.merchCategoryImageValues,
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
