import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';

import '../../../logic/controller/rewards_controller.dart';
import '../../sub_category/widget/sub_category_list.dart';

class RewardsCardView extends StatelessWidget {
  RewardsCardView({super.key, this.rewardsController});

  RewardsController? rewardsController;

  @override
  Widget build(BuildContext context) {
    return TextScaleFactorClamper(
        child: Flexible(
            child: ListView.builder(
                itemCount: rewardsController?.rewardsProductList.length,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(1.w),
                itemBuilder: (BuildContext context, int index) {
                  dynamic rewardsPoint = rewardsController
                      ?.itemPointvalues(
                          rewardsController?.rewardsProductList[index]
                              .defaultSize,
                          rewardsController?.rewardsProductList[index]
                              .price!);
                  final rewardsProduct =
                      rewardsController?.rewardsProductList[index];
                  return GestureDetector(
                      onTap: () {
                        Map values = {
                          'id': rewardsProduct!.id,
                          'name': rewardsProduct.name,
                          'image': rewardsProduct.image,
                        };
                        Get.toNamed(Routes.rewardsProductViewScreen,
                            arguments: values);
                      },
                      child: cardView(
                          description: rewardsPoint,
                          rewardIcon: 0,
                          rewardValues: 1,
                          imageUrl: rewardsProduct!.image!,
                          name: rewardsProduct.name!));
                })));
  }
}
