import 'package:dip_menu/core/config/app_textstyle.dart';
import 'package:dip_menu/data/model/product_preview/product_preview_data.dart';
// import 'package:dip_menu/extra/common_widgets/discount_operations.dart';
import 'package:dip_menu/extra/packages/linear_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProductOperations {
  itemSizeValues(
      var list,
      int productSize,
      int? categoryIdValues,
      List<CustomSize> customSizeValues,
      List<String> itemSizeData,
      List<String> minData,
      List<String> maxData) {
    list.clear();
    if (categoryIdValues == 4) {
      for (var element in customSizeValues) {
        if (productSize == int.parse(element.itemSizeId!)) {
          itemSizeData = element.customMenuId!.split(',');
          minData = element.customMin!.split(',');
          maxData = element.customMax!.split(',');
        }
      }

      list = List.generate(
          itemSizeData.length,
          (i) => {
                'itemSize': itemSizeData[i],
                'min': minData[i],
                'max': maxData[i]
              });
    } else {
      list = List.generate(
          itemSizeData.length,
          (i) => {
                'itemSize': itemSizeData[i],
                'min': minData[i],
                'max': maxData[i]
              });
    }
    return list;
    // update();
  }


  Widget verticalBar(
      {String? name,
        String? isWeightCheck,
        int? subCategoryIdValues,
        double? percent,
        String? header,
        double? weightPercent,
        String? weightHeader}) {
    Widget buildVerticalBar(double percent, String header, double width) {
      return VerticalBarIndicator(
        percent: percent,
        height: 1.h,
        animationDuration: const Duration(seconds: 3),
        color: const [Colors.limeAccent, Colors.green],
        header: header,
        footer: '',
        footerStyle: TextStore.textTheme.titleLarge
            ?.copyWith(fontSize: 9.sp, color: Colors.black),
        headerStyle: TextStore.textTheme.titleLarge
            ?.copyWith(fontSize: 9.sp, color: Colors.black),
        width: width,
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name!,
            style: TextStore.textTheme.headlineSmall!.copyWith(
                color: Get.isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold)),
        if (isWeightCheck != '1' && subCategoryIdValues != 189)
          buildVerticalBar(percent!, header!, 40.w)
        else if (subCategoryIdValues == 189)
          buildVerticalBar(percent!, header!, 53.w)
        else
          buildVerticalBar(weightPercent!, weightHeader!, 53.w),
      ]),
    );
  }

//
// priceCalculation1(int quantity, double price) {
//   double quantityValue = quantity.toDouble();
//   double priceValue = price;
//   double subTotal = 0.0;
//   overAllPriceCalculation().forEach((element) {
//     subTotal += double.parse(element);
//   });
//   double totalValues =
//       (quantityValue * priceValue) + (quantityValue * subTotal);
//
//   return totalValues;
// }
// overAllPriceCalculation() {
//   List values = [];
//   for (var element in customMenu) {
//     if (element.selectedItems.isNotEmpty) {
//       for (var selectedElements in element.selectedItems) {
//         values.add(priceFinder(selectedElements.customProductId!));
//       }
//       values.sublist(0, element.selectedItems.length);
//     }
//   }
//   return values;
// }
//
// priceFinder(int element) {
//   dynamic values;
//   for (var item in customMenu) {
//     item.selectedItems.forEach((selectedElements) {
//       for (var productElement in item.customProducts!) {
//         if (element == productElement.customItemId &&
//             productElement.itemsizeId == productSize) {
//           values = productDiscountPrize(
//               productSlashValues(double.parse(productElement.price!)))
//               .toString();
//         }
//       }
//     });
//   }
//   return values ?? '0.0';
// }
}

class ProductOperationsController extends GetxController with StateMixin {
  itemSizeValues(
      var list,
      int productSize,
      int? categoryIdValues,
      List<CustomSize> customSizeValues,
      List<String> itemSizeData,
      List<String> minData,
      List<String> maxData) {
    list.clear();
    if (categoryIdValues == 4) {
      for (var element in customSizeValues) {
        if (productSize == int.parse(element.itemSizeId!)) {
          itemSizeData = element.customMenuId!.split(',');
          minData = element.customMin!.split(',');
          maxData = element.customMax!.split(',');
        }
      }

      list = List.generate(
          itemSizeData.length,
          (i) => {
                'itemSize': itemSizeData[i],
                'min': minData[i],
                'max': maxData[i]
              });
    } else {
      list = List.generate(
          itemSizeData.length,
          (i) => {
                'itemSize': itemSizeData[i],
                'min': minData[i],
                'max': maxData[i]
              });
    }
    // update();
  }
}
