import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/sub_category/category_product.dart';
import '../../../extra/common_widgets/bottom_navigation.dart';
// import '../../../extra/common_widgets/floating_icon_button.dart';
import '../../logic/controller/main_controller.dart';
import '../../logic/controller/sub_category_controller.dart';
import '../sub_category/widget/sub_category_list.dart';
import '../sub_category/widget/sub_category_topcard.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final productController = Get.find<SubCategoryController>();
  Subcategories argumentData = Get.arguments;
  final homeControllervalues = Get.find<MainController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<SubCategoryController>(builder: (_) {
      return Scaffold(
        backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
        body: TextScaleFactorClamper(
          child: HandlingDataView(
              statusRequest: productController.statusRequestCategory!,
              widget: CustomScrollView(slivers: [
                SliverPersistentHeader(
                    delegate: MySliverAppBar(
                        expandedHeight: 30.h,
                        controller: productController,
                        length: productController.subCategoryProductList.length,
                        imageUrl: imageview(argumentData.image!),
                        onBackPressed: () {
                          Get.back();
                        },
                        title: argumentData.name),
                    pinned: true),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: productController.subCategoryProductList.length,
                  (_, index) {
                    final subCategoryProduct =
                        productController.subCategoryProductList[index];
                    return GestureDetector(
                        onTap: () {
                          Map values = {
                            'id': subCategoryProduct.id,
                            'name': subCategoryProduct.name,
                            'image': subCategoryProduct.image,
                            'route': 'others'
                          };
                          Get.toNamed(Routes.productPreviewScreen,
                              arguments: values);
                        },
                        child: cardView(
                            description: subCategoryProduct.description!,
                            imageUrl: subCategoryProduct.image!,
                            rewardValues: 0,
                            rewardIcon: 0,
                            name: subCategoryProduct.name!));
                  },
                )),
              ])),
        ),
        bottomNavigationBar: BottomNavigation(
          elevation: 0,
            onTap: homeControllervalues.onItemTapped1,
            index: homeControllervalues.selectedIndex),
        floatingActionButton:     FloatingButton(
          totalValues: homeControllervalues.totalCount.toString(),
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      );
    }));
  }
}
