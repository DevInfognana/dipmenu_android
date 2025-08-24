import 'package:dip_menu/presentation/pages/sub_category/widget/sub_category_list.dart';
import 'package:dip_menu/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../extra/common_widgets/empty_widget.dart';
import '../../../logic/controller/dim_menu_search_controller.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class SearchCard extends StatelessWidget {
  SearchCard({super.key, this.margin, this.controller});

  final double? margin;
  final DipMenuSearchController? controller;

  final numberFormat = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: SizedBox(
      child: controller!.searchProductList.isNotEmpty
          ? ListView.builder(
              itemCount: controller!.searchProductList.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final subCategoryProduct = controller!.searchProductList[index];
                return GestureDetector(
                    onTap: () {
                      Map values = {
                        'id': subCategoryProduct.id,
                        'name': subCategoryProduct.name,
                        'image': subCategoryProduct.image
                      };
                      Get.toNamed(Routes.productPreviewScreen,
                          arguments: values);
                    },
                    child: cardView(
                        imageUrl: subCategoryProduct.image!,
                        name: subCategoryProduct.name!,
                        rewardValues: 0,
                        rewardIcon: 1,
                        description: subCategoryProduct.description!)
                );
              })
          : emptyWidget('Nothing in our product'),
    ));
  }
}
