import 'package:dip_menu/presentation/pages/sub_category/widget/sub_category_list.dart';
import 'package:dip_menu/presentation/pages/index.dart';
import 'package:dip_menu/presentation/pages/sub_category/widget/sub_category_topcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../extra/common_widgets/bottom_navigation.dart';
// import '../../../extra/common_widgets/floating_icon_button.dart';
import '../../logic/controller/main_controller.dart';
import '../../logic/controller/sub_category_controller.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final homeController = Get.find<SubCategoryController>();
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
              statusRequest: homeController.statusRequestBanner!,
              widget: CustomScrollView(slivers: [
                SliverPersistentHeader(
                    delegate: MySliverAppBar(
                        expandedHeight: 30.h,
                        controller: homeController,
                        length: homeController.subCategoryList.length,
                        imageUrl:
                            imageview(homeController.argumentData['image']),
                        onBackPressed: () {
                          // Get.back();
                          Get.offAllNamed(Routes.mainScreen, arguments: 0);
                        },
                        title: homeController.argumentData['name']),
                    pinned: true,
                    floating: false),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: homeController.subCategoryList.length,
                  (_, index) {
                    final subCategoryProduct =
                        homeController.subCategoryList[index];
                    return GestureDetector(
                        onTap: () {
                          homeController.viewproductListCategory(
                              subCategoryProduct.id.toString());
                          Get.toNamed(Routes.productListScreen,
                              arguments: subCategoryProduct);
                        },
                        child: cardView(
                            description: subCategoryProduct.description!,
                            imageUrl: subCategoryProduct.image!,
                            rewardValues: 0,
                            rewardIcon: 0,
                            name: subCategoryProduct.name!)
                    );
                  },
                )),
              ])),
        ),
        bottomNavigationBar: BottomNavigation(
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
