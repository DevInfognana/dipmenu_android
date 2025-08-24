import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/data/model/price.dart';
import 'package:dip_menu/data/model/product_preview/item_size_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_textstyle.dart';
import '../../data/model/product_preview/custom_menu_data.dart';
import 'alert_dialog.dart';
import 'image_view.dart';

class CommonWidget {
  void showLimitReachedDialog(
      {String? customMenuName,
      String? productSize,
      String? values,
      int? values1}) {
    ShowDialogBox.alertDialogBoxValues(
      content: '$customMenuName',
      content1: productSize,
      content2: values,
      values: values1,
      context: Get.context,
      title: 'Alert',
      textOkButton: "Back",
      onButtonTapped: () {
        Get.back();
      },
    );
  }

  void addSelectedItem(
      int? customizeMenuItemsId,
      int? customProductMenuId,
      int? productCustomWeight,
      String? customMenuName,
      List<SelectedItems>? selectedItemsValues) {
    selectedItemsValues!.add(SelectedItems(
      customProductId: customizeMenuItemsId,
      customProductMenuId: customProductMenuId,
      weight: productCustomWeight,
      itemName: customMenuName,
    ));
  }

  paddingView({String? test}) {
    return Padding(
        padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
        child: Text(test!,
            style: TextStore.textTheme.titleLarge!.copyWith(
                color: Get.isDarkMode ? Colors.white70 : Colors.black54)));
  }

  Widget productName(BuildContext context, String data) {
    return Flexible(
      child: Text(
        data,
        overflow: TextOverflow.clip,
        style: context.theme.textTheme.displaySmall
            ?.copyWith(fontWeight: FontWeight.bold),
        // style: TextStore.textTheme.displaySmall!
        //     .copyWith(fontWeight: FontWeight.bold, color: Colors.black)
      ),
    );
  }

  void showLimitReachedDialogBox(
      {String? customMenuName, String? productSize, String? values}) {
    ShowDialogBox.alertDialogBoxValues1(
      content1: customMenuName,
      content: '$productSize',
      context: Get.context,
      title: 'Alert',
      textOkButton: "Back",
      onButtonTapped: () {
        Get.back();
      },
    );
  }

  bool checkAddMinimumValues(
      {elementOne,
      List<CustomMenuData>? customMenuValues,
      String? isWeightCheck,
      List<dynamic>? minCustMenuName,
      int? weightValues}) {
    if (customMenuValues!.isNotEmpty) {
      for (var element in customMenuValues) {
        if (element.id == int.parse(elementOne['itemSize'])) {
          if (isWeightCheck == '1') {
            return true;
          }
          if (element.isHybrid == '1') {
            if ((weightValues! >= int.parse(elementOne['min']) &&
                    weightValues <= int.parse(elementOne['max'])) ==
                false) {
              minCustMenuName?.add(element.name);
            }

            return weightValues >= int.parse(elementOne['min']) &&
                weightValues <= int.parse(elementOne['max']);
          } else {
            if ((element.selectedItems.length >= int.parse(elementOne['min']) &&
                    element.selectedItems.length <=
                        int.parse(elementOne['max'])) ==
                false) {
              minCustMenuName?.add(element.name);
            }

            return element.selectedItems.length >=
                    int.parse(elementOne['min']) &&
                element.selectedItems.length <= int.parse(elementOne['max']);
          }
        }
      }
    }
    return true;
  }

  bool loadDataFromCompute(
      List<CustomMenuData> customMenuValues,
      List<dynamic> list,
      int categoryIdValues,
      String? isWeightCheck,
      String? sizerWeightValues,
      Map<String, dynamic> sizerValues,
      int productWeightTotalValues) {
    // Sort the list by 'itemSize'
    list.sort((a, b) => a['itemSize'].compareTo(b['itemSize']));

    // Initialize variables
    bool minimumValues1 = false;

    // Check if categoryIdValues is 4
    if (categoryIdValues == 4) {
      // Clear sizerValues list
      sizerValues.clear();

      // Initialize list to store boolean values
      List<bool> listBooleanValues = [];
      // Iterate over customMenu
      for (var elementOne in customMenuValues) {
        for (var elementIdValues in list) {
          // Calculate total weight
          dynamic total = 0;
          for (var element1 in elementOne.selectedItems) {
            total += element1.weight;
          }
          // Check conditions based on business logic
          if (elementOne.id == int.parse(elementIdValues['itemSize']) &&
              isWeightCheck == '1') {
            if (total <= num.parse(sizerWeightValues!)) {
              minimumValues1 = false;
              sizerValues
                  .addAll({elementOne.name!: num.parse(sizerWeightValues)});
            } else {
              minimumValues1 = true;
            }
          }

          if (elementOne.id == int.parse(elementIdValues['itemSize'])) {
            if (elementOne.isHybrid == '1') {
              if (productWeightTotalValues != 0) {
                if (productWeightTotalValues
                    .isGreaterThan(num.parse(elementIdValues['max']))) {
                  minimumValues1 = false;
                  sizerValues.addAll(
                      {elementOne.name!: int.parse(elementIdValues['max'])});
                } else {
                  minimumValues1 = true;
                }
              } else {
                minimumValues1 = true;
              }
            } else {
              if (elementOne.selectedItems.isNotEmpty) {
                if (!(elementOne.selectedItems.length >=
                        int.parse(elementIdValues['min']) &&
                    elementOne.selectedItems.length <=
                        int.parse(elementIdValues['max']))) {
                  minimumValues1 = false;
                  sizerValues.addAll(
                      {elementOne.name!: int.parse(elementIdValues['max'])});
                } else {
                  minimumValues1 = true;
                }
              } else {
                minimumValues1 = true;
              }
            }
          }
        }
        listBooleanValues.add(minimumValues1);
      }
      // Check if any false value exists in listBooleanValues
      minimumValues1 = !listBooleanValues.contains(false);
    }
    return minimumValues1;
  }

  Widget floatingButton(
      {bool? endPointValues,
      required Function() onViewbuttonpressed,
      int? totalLength,
      required String name}) {
    return getDeviceType() == 'phone'
        ? (totalLength! > 6
            ? FloatingActionButton.extended(
                onPressed: () {
                  endPointValues == true ? onViewbuttonpressed() : null;
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w)),
                label: Text(name,
                    style: TextStore.textTheme.displaySmall!
                        .copyWith(color: Colors.white)),
                backgroundColor:
                    endPointValues == true ? mainColor : Colors.grey)
            : FloatingActionButton.extended(
                onPressed: () {
                  onViewbuttonpressed();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w)),
                label: Text(name,
                    style: TextStore.textTheme.displaySmall!
                        .copyWith(color: Colors.white)),
                backgroundColor: mainColor))
        : (totalLength! > 15
            ? FloatingActionButton.extended(
                onPressed: () {
                  endPointValues == true ? onViewbuttonpressed() : null;
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w)),
                label: Text(name,
                    style: TextStore.textTheme.displaySmall!
                        .copyWith(color: Colors.white)),
                backgroundColor:
                    endPointValues == true ? mainColor : Colors.grey)
            : FloatingActionButton.extended(
                onPressed: () {
                  onViewbuttonpressed();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w)),
                label: Text(name,
                    style: TextStore.textTheme.displaySmall!
                        .copyWith(color: Colors.white)),
                backgroundColor: mainColor));
  }
}

String getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? 'phone' : 'tablet';
}

class ProductCard extends StatelessWidget {
  ProductCard(
      {Key? key,
      this.imageUrl,
      this.productName,
      this.priceContent,
      this.totalPrizeValues,
      this.isReward,
      this.favouriteContent,
      this.addButton,
      this.chooseSize,
      this.productDescription1})
      : super(key: key);

  String? imageUrl;
  String? productName;
  Widget? priceContent;
  Widget? totalPrizeValues;
  int? isReward;
  Widget? favouriteContent;
  Widget? addButton;
  Widget? chooseSize;
  Widget? productDescription1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 1.w, right: 1.w),
        child: Card(
          elevation: 0,
          color: Theme.of(Get.context!).scaffoldBackgroundColor,
          child: Column(children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 15.h,
                      width: getDeviceType() == 'phone' ? 27.w : 23.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.w),
                          child: ImageView(
                              imageUrl: imageview(imageUrl!),
                              showValues: false,
                              mainImageViewWidth: 34.w,
                              bottomImageViewHeight: 5.h))),
                  Flexible(
                      child: Container(
                    padding: EdgeInsets.all(0.1.h),
                    child: Column(children: [
                      Row(children: [
                        CommonWidget().productName(context, productName!)
                      ]),
                      Row(children: [
                        priceContent!,
                        isReward == 1 ? const Spacer() : const SizedBox(),
                        isReward == 1 ? totalPrizeValues! : const SizedBox(),
                        const Spacer(flex: 2),
                        favouriteContent!,
                      ])
                    ]),
                  ))
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [addButton!, chooseSize!]),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: productDescription1),
          ]),
        ),
      ),
    );
  }
}

