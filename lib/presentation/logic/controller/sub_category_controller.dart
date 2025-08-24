import 'package:get/get.dart';
import '../../../data/model/sub_category/category_product.dart';
import '../../../data/model/sub_category/sub_category_product_data.dart';
import '../../../domain/reporties/sub_category_service.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';

class SubCategoryController extends GetxController {
  dynamic argumentData = Get.arguments;


  var subCategoryList = <Subcategories>[].obs;
  var subCategoryProductList = <SubCategoryProductModelData>[].obs;
  List<String>bannerImages=[];
  StatusRequest? statusRequestBanner;
  StatusRequest? statusRequestCategory;
  Subcategories? categoryValues;
  int selectedValues=0;
  RxBool onChange = false.obs;





  @override
  void onInit() async {
    super.onInit();
     viewSubCategory();



    // viewproductListCategory();
  }



   viewSubCategory() async {
    statusRequestBanner = StatusRequest.loading;
    var response = await SubCategoryServices.viewSubCategoryRequest(argumentData['id'].toString());
    statusRequestBanner = handlingData(response);
    if (StatusRequest.success == statusRequestBanner) {
      subCategoryList.clear();
      final dataList = (response['subcategories'] as List)
          .map((e) => Subcategories.fromJson(e))
          .toList();
      subCategoryList.addAll(dataList);
      categoryValues=subCategoryList.first;
    }else{
      statusRequestBanner = StatusRequest.failure;
    }
    update();
  }

  //categoryValues?.id.toString()

  void viewproductListCategory(String? value) async {
    statusRequestCategory = StatusRequest.loading;
    var response = await SubCategoryServices.viewSubCategoryProductRequest(value);
    statusRequestCategory = handlingData(response);
    if (StatusRequest.success == statusRequestCategory) {
      subCategoryProductList.clear();
      final dataList = (response['data'] as List)
          .map((e) => SubCategoryProductModelData.fromJson(e))
          .toList();
      subCategoryProductList.addAll(dataList);

    }else{
      statusRequestCategory = StatusRequest.failure;
    }
    update();
  }
}