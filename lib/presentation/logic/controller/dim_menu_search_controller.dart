import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/model/search/search_data_model.dart';
import '../../../domain/reporties/search_api.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';

class DipMenuSearchController extends GetxController {

  final TextEditingController searchController = TextEditingController();

  var searchProductList = <ProductData>[].obs;

  // StatusRequest? statusRequestCategory;
 late StatusRequest statusRequestSearchValues;
   // String searchValues='';
   // int totalValues=0;
  Timer? _debounce;



  @override
  void onInit() async {
    viewHomeBanners();
    super.onInit();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }


  onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if(query.isNotEmpty){
        viewSearchServices(query);
      }else{
        viewHomeBanners();
      }

    });
  }

  void viewHomeBanners() async {
    statusRequestSearchValues = StatusRequest.loading;
    var response = await SearchServices.viewSearchRequest('');
    statusRequestSearchValues = handlingData(response);
    if (StatusRequest.success == statusRequestSearchValues) {
      searchProductList.clear();
      final dataList = (response['data'] as List)
          .map((e) => ProductData.fromJson(e))
          .toList();
      searchProductList.addAll(dataList);

    }else{
      statusRequestSearchValues = StatusRequest.failure;
    }
    update();
  }

  void viewSearchServices(String? searchList) async {
    statusRequestSearchValues = StatusRequest.loading;
    var response = await SearchServices.viewEditSearchRequest(searchList);
    statusRequestSearchValues = handlingData(response);
    if (StatusRequest.success == statusRequestSearchValues) {
      searchProductList.clear();
      final dataList = (response['data'] as List)
          .map((e) => ProductData.fromJson(e))
          .toList();
      searchProductList.addAll(dataList);
      // totalValues=searchProductList.length;
      // print('----->${searchProductList.length}');

    }else{
      statusRequestSearchValues = StatusRequest.failure;
    }
    update();
  }



}

