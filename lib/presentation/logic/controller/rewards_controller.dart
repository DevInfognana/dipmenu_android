import 'package:dip_menu/data/model/rewards_model.dart';
import 'package:dip_menu/domain/reporties/rewards_api.dart';
import 'package:get/get.dart';

import '../../../data/model/price.dart';
import '../../../domain/entities/handler_data.dart';
import '../../../domain/entities/status_reques.dart';

class RewardsController extends GetxController {

  late StatusRequest statusRequestRewards;
  var rewardsProductList = <RewardsProductsData>[].obs;
  @override
  void onInit() async {
    super.onInit();
    viewRewardsRequest();
  }


  void viewRewardsRequest() async {
    statusRequestRewards = StatusRequest.loading;
    var response = await RewardsViewServices.viewRewardsRequest();
    statusRequestRewards = handlingData(response);
    if (StatusRequest.success == statusRequestRewards) {
      rewardsProductList.clear();
      final dataList = (response['data'] as List)
          .map((e) => RewardsProductsData.fromJson(e))
          .toList();
      rewardsProductList.addAll(dataList);
    }else{
      statusRequestRewards = StatusRequest.failure;
    }
    update();
  }

  itemPointvalues(int? defalutSize, List<Price>? values){
    String? productPriceValues;
    for (var element in values!) {
      if(element.itemsizeId == defalutSize){
        productPriceValues= element.points;
      }
    }

    return productPriceValues;
  }

}

