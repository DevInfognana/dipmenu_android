import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controller/favourite_controller.dart';
import '../../../routes/routes.dart';
import '../../sub_category/widget/sub_category_list.dart';
import 'package:dip_menu/presentation/pages/index.dart';


// ignore: camel_case_types
class cartCard extends StatefulWidget {
  cartCard({super.key, this.margin, this.favouriteController});

  final double? margin;
  FavouriteController? favouriteController;

  @override
  State<cartCard> createState() => _cartCardState();
}

class _cartCardState extends State<cartCard> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.builder(
            itemCount: widget.favouriteController?.favouriteProductList.length,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final subCategoryProduct =
                  widget.favouriteController?.favouriteProductList[index];
              return GestureDetector(
                  onTap: () {
                    if (subCategoryProduct?.reward == 0) {
                      Map values = {
                        'id': subCategoryProduct!.productId,
                        'name': subCategoryProduct.product!.name,
                        'image': subCategoryProduct.product!.image,
                        'route': 'favouriteScreen',
                        'protuctquantiy': subCategoryProduct.quantity,
                        'SelectedItem': subCategoryProduct.itemIds!.split(','),
                        'defaultsize': subCategoryProduct.defaultSize,
                      };
                      Get.toNamed(Routes.productPreviewScreen,
                          arguments: values);
                    } else {
                      Map values = {
                        'id': subCategoryProduct!.productId,
                        'name': subCategoryProduct.product!.name,
                        'image': subCategoryProduct.product!.image,
                        'route': 'favouriteScreen',
                        'protuctquantiy': subCategoryProduct.quantity,
                        'SelectedItem': subCategoryProduct.itemIds!.split(','),
                        'defaultsize': subCategoryProduct.defaultSize,
                      };
                      Get.toNamed(Routes.rewardsProductViewScreen,
                          arguments: values);
                    }
                  },
                  child: cardView(
                      imageUrl: subCategoryProduct!.product!.image!,
                      name: subCategoryProduct.product!.name!,
                      rewardValues: 0,
                      rewardIcon:  subCategoryProduct.reward!,
                      description: subCategoryProduct.description!));
            }));
  }
}
