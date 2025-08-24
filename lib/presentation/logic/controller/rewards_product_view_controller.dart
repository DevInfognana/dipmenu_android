import 'package:dip_menu/data/model/price.dart';
import 'package:dip_menu/extra/common_widgets/common_product_page_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/model/product_preview/custom_menu_data.dart';
import '../../../data/model/product_preview/item_size_data.dart';
import '../../../data/model/product_preview/product_preview_data.dart';
import '../../../data/model/product_preview/product_preview_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import '../../../domain/reporties/product_preview.dart';

class RewardsProductController extends GetxController with StateMixin {
  dynamic argumentData = Get.arguments;
  var productPreviewList = <ProductPreviewData>[].obs;
  var itemSize = <ItemSizeData>[].obs;
  var priceRange = <Price>[].obs;
  var customMenu = <CustomMenuData>[].obs;
  StatusRequest? statusRequestProductPreview;
  StatusRequest? statusRequestProductPricePreview;
  StatusRequest? statusRequestCustomMenu;
  StatusRequest? statusRequestFavourite;
  double totalPrice = 0.00;
  double defaultPrice = 0.00;
  RxInt productQuality = 1.obs;
  String? selectedValue;
  bool isFavourite = false;
  bool loading = false;
  bool endPoint = false;
  int productTotal = 0;

  // double cumulative = 0.00;
  List<String> itemSizeData = [];
  List<String> minData = [];
  List<String> maxData = [];
  List<int> defaultProduct = [];
  var list = [];

  // product customization main values
  int productSize = 0;

  // List<Price> productPriceValues = [];

  // String? productImage;
  String? productDescription;

  // String? productName;
  String? productID;
  String? favouriteValues;

  var minCustMenuName = [];
  String? favouriteValuesChecking;

  // for reward product itemSize to useing values
  int? categoryIdValues = 0;
  List<CustomSize> customSizeValues = [];

  //favourite screen  to redirect to  used
  List<String> selectedData = [];
  RxInt custProductQuanity = 1.obs;

  //weight feature
  String? isWeightCheck;
  String? weightValues;
  bool isProductWeightCheck = false;

  // ice cream  weight feature
  var customWeightValues = <CustomWeight>[];

  //merchCategory
  int merchCategoryImageValues = 0;
  List<String>? merchCategoryImages = [];

  // linegraphvalues
  double lineGraphValues = 0.0;
  RxInt productIndex = 0.obs;

  // for hybrid weight function
  int? subCategoryIdValues = 0;

  Map<String, dynamic> sizerValues = {};
  String? sizerWeightValues;

  // custom Menu empty
  RxBool customMenuBoolValues = false.obs;

  // duplicate itemId remove
  List<int> uniquestList = [];
  List<int> customMenuId = [];

  // hybrid different form use
  int productWeightTotalValues = 0;
  int countValues = 0;

  // hybrid new  version
  int?  hybridProduct =0;

  //ignore multiple time click add button
  bool _isAdding = false;

  @override
  void onInit() async {
    super.onInit();
    favouriteValues = argumentData['route'];
    // print(argumentData);
    favouriteValuesChecking = argumentData['route'] ?? '';
    selectedData = argumentData['SelectedItem'] ?? [];
    custProductQuanity = RxInt(argumentData['protuctquantiy'] ?? 0);
    viewProductPreviewBanners();
  }

  defaultSizeValues() {
    selectedValue = chooseSetVALUES(productSize, itemSize);
  }

  chooseSetVALUES(int size, List<ItemSizeData>? values) {
    var productPriceValues;
    for (var element in values!) {
      if (element.id == size) {
        productPriceValues = element.code;
      }
    }
    return productPriceValues;
  }

  priceCalculation(int quantity, double price) {
    double quantityValue = quantity.toDouble();
    double priceValue = price;
    double totalValues = quantityValue * priceValue;
    return totalValues.toInt();
  }

  void viewProductPreviewBanners() async {
    statusRequestProductPreview = StatusRequest.loading;
    statusRequestCustomMenu = StatusRequest.loading;
    var response = await ProductPreviewServices.viewProductPreviewRequest(
        '${argumentData['id']}?query=');
    statusRequestProductPreview = handlingData(response);
    if (StatusRequest.success == statusRequestProductPreview) {
      final dataList = (response['data'] as List)
          .map((e) => ProductPreviewData.fromJson(e))
          .toList();
      productPreviewList.addAll(dataList);
      for (var element in productPreviewList) {
        itemSizeData = element.customMenuIds!.split(',');
        minData = element.customMenuMin!.split(',');
        maxData = element.customMenuMax!.split(',');

        categoryIdValues = element.category?.id;
        element.customSize!.isNotEmpty
            ? customSizeValues = element.customSize!
            : customSizeValues.clear();
        productID = element.id.toString();
        productDescription =
            element.description!.replaceAll("\n", " , ").toString();
        // totalPrice = double.parse(
        //     itemPriceId(element.defaultSize!, element.price!));
        if (favouriteValuesChecking == 'favouriteScreen') {
          productSize = int.parse(argumentData['defaultsize']);
          totalPrice = double.parse(itemPointsId(
              int.parse(argumentData['defaultsize']), element.price!));
          defaultPrice = double.parse(itemPointsId(
              int.parse(argumentData['defaultsize']), element.price!));
          priceCalculation1(custProductQuanity.toInt(), totalPrice);
          productQuality = custProductQuanity;
        } else {
          productSize = element.defaultSize!;
          totalPrice =
              double.parse(itemPointsId(element.defaultSize, element.price!));
          defaultPrice =
              double.parse(itemPointsId(element.defaultSize, element.price!));
        }
        productID = element.id.toString();
        weightValues = element.weight!;
        isWeightCheck = element.isWeight;
        subCategoryIdValues = element.subcategoryId;
        hybridProduct=element.hybridProduct!;
        if (element.customWeight!.isNotEmpty && categoryIdValues == 4) {
          customWeightValues = element.customWeight!;
        } else if (categoryIdValues == 5) {
          for (var element in element.merchimages!) {
            merchCategoryImages = element.images?.split(',');
          }
        }
      }

      viewItemSize();
      weightFeature();
      if (isWeightCheck != '1') {
        itemSizeValues();
      }
      if (hybridProduct == 1) {
        itemSizeValues();
      }
      if (categoryIdValues != 5) {
        viewCustomMenu();
      }

      final favouriteValues = ProductPreviewModel.fromJson(response);
      if (favouriteValues.favourite == 0) {
        isFavourite = false;
      } else {
        isFavourite = true;
      }
    } else {
      statusRequestProductPreview = StatusRequest.failure;
    }
    merchCategory();
    update();
  }


  merchCategory() {
    if (categoryIdValues == 5) {
      statusRequestCustomMenu = StatusRequest.success;
    }
  }

  merchCategoryChangeImages(int values) {
    return change(merchCategoryImageValues = values);
  }

  Future<void> viewItemSize() async {
    statusRequestProductPricePreview = StatusRequest.loading;
    var response = await ProductPreviewServices.itemSize(
        values: argumentData['id'].toString());
    statusRequestProductPricePreview = handlingData(response);
    if (StatusRequest.success == statusRequestProductPricePreview) {
      // final itemSizeDataValues = (response['data'] as List)
      //     .map((e) => ItemSizeData.fromJson(e))
      //     .toList();
      // itemSize.addAll(itemSizeDataValues);
      for (var element in response['price']) {
        for (var element1 in response['data']) {
          if (element['itemsize_id'] == element1['id']) {
            itemSize.add(ItemSizeData(
                id: element1['id'],
                code: element1['code'],
                description: element1['description'],
                position: element['position']));
          }
        }
      }
      itemSize.sort((a, b) => a.position!.compareTo(b.position!));
      final dataList =
          (response['price'] as List).map((e) => Price.fromJson(e)).toList();
      priceRange.addAll(dataList);
      defaultSizeValues();
      viewCustomMenu();
      merchCategory();
    } else {
      statusRequestProductPricePreview = StatusRequest.failure;
    }
    update();
  }

  Future<void> viewCustomMenu() async {
    statusRequestCustomMenu = StatusRequest.loading;
    var response = await ProductPreviewServices.customMenu(
        values: argumentData['id'].toString());
    statusRequestCustomMenu = handlingData(response);
    if (StatusRequest.success == statusRequestCustomMenu) {
      if (response['errors'] == "Product Not Found.!") {
        customMenuBoolValues.value = true;
      }else{
        statusRequestCustomMenu=StatusRequest.success;
        customMenuBoolValues.value = false;
        final itemSizeDataValues = (response['data'] as List)
            .map((e) => CustomMenuData.fromJson(e))
            .toList();
        customMenu.clear();
        customMenu.addAll(itemSizeDataValues);
        defaultProduct.clear();
        if (favouriteValuesChecking == 'favouriteScreen') {
          for (var element in customMenu) {
            for (var element1 in selectedData) {
              element.editSelectedItems.add((element1));
            }
          }
          int proWeightValues=0;

          for (var element in customMenu) {
            for (var valuesFirst in element.customMenuItems!) {
              for (var valueSecond in element.customProducts!) {
                if (valuesFirst.id == valueSecond.customItemId &&
                    valueSecond.itemsizeId == productSize &&
                    valuesFirst.trash == 0) {
                  uniquestList.add(element.id!);
                  element.customizeMenuItems.add(CustomizeMenuValueItems(
                      name: valuesFirst.name,
                      customMenuId: valuesFirst.customMenuId,
                      id: valuesFirst.id,
                      image: valuesFirst.image,
                      defaultSelect: 0,
                      orderId: valuesFirst.orderNo,
                      weight: int.parse(valuesFirst.weight.toString().isEmpty
                          ? '0'
                          : valuesFirst.weight.toString()),
                      isChecked: element.editSelectedItems
                          .contains(valuesFirst.id.toString())));
                  element.customizeMenuItems
                      .sort((a, b) => a.orderId!.compareTo(b.orderId!));
                  if (element.editSelectedItems
                      .contains(valuesFirst.id.toString()) ==
                      true) {
                    element.selectedItems.add(SelectedItems(
                        customProductId: valuesFirst.id,
                        customProductMenuId: valuesFirst.customMenuId,
                        weight: int.parse(valuesFirst.weight.toString().isEmpty
                            ? '0'
                            : valuesFirst.weight.toString()),
                        itemName: valuesFirst.name));
                  }
                  priceCalculation1(custProductQuanity.toInt(), totalPrice);
                  for (var valuesecond in element.customProducts!) {
                    if (valuesecond.defaultSelect == 1) {
                      defaultProduct.add(valuesFirst.id!);
                    }
                  }
                }

                productTotal += element.customMenuItems!.length;
              }
            }
            if(element.selectedItems.isNotEmpty  && element.isHybrid =='1') {
              for (var selectElement in element.selectedItems) {
                proWeightValues += (selectElement.weight ?? 0);
              }
            }
          }
          productWeightTotalValues=proWeightValues;
        } else {
          for (var element in customMenu) {
            for (var valuesFirst in element.customMenuItems!) {
              for (var valueSecond in element.customProducts!) {
                if (valuesFirst.id == valueSecond.customItemId &&
                    valueSecond.itemsizeId == productSize &&
                    valuesFirst.trash == 0) {
                  uniquestList.add(element.id!);
                  element.customizeMenuItems.add(CustomizeMenuValueItems(
                      name: valuesFirst.name,
                      customMenuId: valuesFirst.customMenuId,
                      id: valuesFirst.id,
                      image: valuesFirst.image,
                      defaultSelect: valueSecond.defaultSelect,
                      orderId: valuesFirst.orderNo,
                      weight: int.parse(valuesFirst.weight.toString().isEmpty
                          ? '0'
                          : valuesFirst.weight.toString()),
                      isChecked: valueSecond.defaultSelect == 1 ? true : false));
                  element.customizeMenuItems
                      .sort((a, b) => a.orderId!.compareTo(b.orderId!));
                  if (valueSecond.defaultSelect == 1) {
                    defaultProduct.add(valuesFirst.id!);
                    element.selectedItems.add(SelectedItems(
                        customProductId: valuesFirst.id,
                        customProductMenuId: valuesFirst.customMenuId,
                        weight: int.parse(valuesFirst.weight.toString().isEmpty
                            ? '0'
                            : valuesFirst.weight.toString()),
                        itemName: valuesFirst.name));
                  }
                }
              }
            }
            productTotal += element.customMenuItems!.length;
          }
        }
        if (isWeightCheck == '1') {
          weightBasedLineGraphValues(weightCalculation() + 0);
        }
        var seen = <int>{};
        customMenuId =
            uniquestList.where((element) => seen.add(element)).toList();
        var list1 = [];
        for (var element1 in customMenuId) {
          for (var element in list) {
            if (int.parse(element['itemSize']) == element1) {
              list1.add(element);
            }
          }
        }
        list.clear();
        for (var element in list1) {
          list.add(element);
        }
      }



    } else {
      statusRequestCustomMenu = StatusRequest.failure;
    }
    update();
  }

  itemSizeValues() {
    list.clear();
    if (categoryIdValues == 4) {
      list = prepareListFromItemSizeData(productSize);
    } else {
      list = List.generate(
          itemSizeData.length,
          (i) => {
                'itemSize': itemSizeData[i],
                'min': minData[i],
                'max': maxData[i]
              });
    }
    update();
  }
  scrollingValues() {
    endPoint = true;
    update();
  }

  Future<void> removeFavourite({required String productCode}) async {
    statusRequestFavourite = StatusRequest.loading;
    var response =
        await ProductPreviewServices.removeFavourites(productCode: productCode);
    statusRequestFavourite = handlingData(response);

    if (StatusRequest.success == statusRequestFavourite) {
      showSnackBar('Favorite product removed successfully');
    } else {
      statusRequestFavourite = StatusRequest.failure;
    }
    update();
  }

  someFavouriteValuesChecking() {
    double subTotal = 0.0;
    overAllPriceCalculation().forEach((element) {
      subTotal += double.parse(element);
    });
    if (customMenu.isNotEmpty) {
      final priceValues = overAllPriceCalculation().join(',');
      dynamic selectIDValues = selectedID().join(',');
      dynamic selectNameValues = selectedName().join(',');
      newFavouriteAdded(
          itemPrize: valuescheck() == false ? '0' : priceValues,
          itemID: valuescheck() == false ? '' : selectIDValues,
          totalCost: allProductTotalValues(subTotal),
          defaultCustom: deafulatCustomItems() == true ? 1 : 0,
          itemNames: valuescheck() == false ? '' : selectNameValues);
    } else {
      newFavouriteAdded(
          itemPrize: '0',
          itemID: '',
          totalCost: allProductTotalValues(subTotal),
          defaultCustom: deafulatCustomItems() == true ? 1 : 0,
          itemNames: '');
    }
  }

  Future<void> newFavouriteAdded(
      {required String itemPrize,
      required String itemID,
      required double totalCost,
      required int defaultCustom,
      required String itemNames}) async {
    statusRequestFavourite = StatusRequest.loading;
    var response = await ProductPreviewServices.newFavouriteAdded(
        productId: argumentData['id'].toString(),
        quanity: productQuality.toInt(),
        productPrice: totalPrice.toString(),
        itemPrice: itemPrize,
        itemId: itemID,
        totalCost: double.parse(
            priceCalculation1(productQuality.toInt(), totalPrice).toString()),
        status: 1,
        defaultSize: productSize,
        defaultCustom: defaultCustom,
        defaultSizeName: findSizeName(selectedValue),
        defaultSizeCode: findSizeCode(selectedValue),
        // defaultSizeName: selectedValue!,
        // defaultSizeCode: findSizeCode(selectedValue),
        itemNames: itemNames,
        rewards: true,
        description: productDescription!);
    statusRequestFavourite = handlingData(response);
    if (StatusRequest.success == statusRequestFavourite) {
      showSnackBar('Favorite product added successfully');
    } else {
      statusRequestFavourite = StatusRequest.failure;
    }
    update();
  }

  minMaxShow(int? id) {
    var min;
    for (var element in list) {
      if (element['itemSize'] == id.toString()) {
        min = element;
      }
    }
    return min;
  }

  weightFeature() {
    if (categoryIdValues == 4 && isWeightCheck == '1') {
      for (var element in customWeightValues) {
        if (int.parse(element.itemsizeId!) == productSize) {
          weightValues = element.weightValue.toString();
        }
      }
    }
    weightBasedLineGraphValues(weightCalculation() + 0);
    update();
  }

  // weightFeatureBasedClearValues() {
  //   for (var element in customMenu) {
  //     element.selectedItems.clear();
  //     for (var element1 in element.customizeMenuItems) {
  //       element1.isChecked = false;
  //     }
  //   }
  //   weightBasedLineGraphValues(weightCalculation() + 0);
  //   update();
  // }

  bool loadDataFromCompute(
      List<CustomMenuData> customMenuValues, List<dynamic> list) {
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
      for (var elementOne in customMenu) {
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
                  .addAll({elementOne.name!: num.parse(sizerWeightValues!)});
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

  dropdownChooseingValues(dynamic values) {
    dynamic chooseingval;
    for (var element in itemSize) {
      if (element.code == values) {
        chooseingval = element;
      }
    }
    return chooseingval;
  }

  void handleDropdownSelection({ItemSizeData? item}) async {
    if (item != null && selectedValue != item.code) {
      List<Map<String, dynamic>> list1 = prepareListFromItemSizeData(item.id!);
      for (var element in customWeightValues) {
        if (int.parse(element.itemsizeId!) == item.id!) {
          sizerWeightValues = element.weightValue.toString();
        }
      }

      if (categoryIdValues == 4 && loadDataFromCompute(customMenu, list1)) {
        handleSuccessfulSelection(item);
      } else if (categoryIdValues != 4) {
        handleSuccessfulSelection(item);
      } else {
        try {
          CommonWidget().showLimitReachedDialogBox(
              customMenuName: sizerValues.toString().replaceAll('{', ''),
              productSize: findSizeName(item.code));
        } catch (e) {}
      }
    }
    update();
  }

  List<Map<String, dynamic>> prepareListFromItemSizeData(int itemID) {
    var list1 = <Map<String, dynamic>>[];
    for (var element in customSizeValues) {
      if (element.itemSizeId!.isNotEmpty &&
          itemID == int.parse(element.itemSizeId!)) {
        itemSizeData = element.customMenuId!.split(',');
        minData = element.customMin!.split(',');
        maxData = element.customMax!.split(',');
      }
    }

    list1 = List.generate(
      itemSizeData.length,
      (i) => {
        'itemSize': itemSizeData[i],
        'min': minData[i],
        'max': maxData[i],
      },
    );
    return list1;
  }

  void handleSuccessfulSelection(ItemSizeData item) {
    selectedValue = item.code;
    productSize = item.id!;
    defaultPrice = double.parse(itemPointsId(item.id!, priceRange));

    totalPrice = double.parse(itemPointsId(item.id!, priceRange));
    if (isWeightCheck != '1') {
      itemSizeValues();
    }
    if (isWeightCheck == '1' || categoryIdValues == 4) {
      weightFeature();
    }
    if (hybridProduct == 1) {
      itemSizeValues();
    }
  }

  pointsValues(List<CustomProducts>? customProducts, int itemSizeId) {
    dynamic priceValues;
    // customProducts!.forEach((element) {
    //   if(element.customItemId !=itemSizeId){
    //     priceValues = '0.0';
    //   }else{
    //     if (element.customItemId == itemSizeId &&
    //         element.itemsizeId == productSize) {
    //       priceValues = element.points;
    //     }
    //   }
    // });
    List values = [];
    values.clear();
    for (var element in customProducts!) {
      values.add(element.itemsizeId);
      if (element.itemsizeId == productSize) {
        if (element.customItemId == itemSizeId) {
          priceValues = element.points ?? '0.0';
        }
      }
    }

    if (values.contains(productSize) == false) {
      priceValues = '0.0';
    }
    return priceValues;
  }

  priceCalculation1(int quantity, double price) {
    double quantityValue = quantity.toDouble();
    double priceValue = price;
    double subTotal = 0.0;
    overAllPriceCalculation().forEach((element) {
      subTotal += double.parse(element);
    });
    double totalValues =
        (quantityValue * priceValue) + (quantityValue * subTotal);

    return totalValues.toInt();
  }

  increaseCount() {
    productQuality++;
    update();
    priceCalculation1(productQuality.toInt(), totalPrice);
  }

  decreaseCount() {
    if (productQuality.toInt() != 0 && productQuality.toInt() != 1) {
      productQuality--;
    }
    update();
    priceCalculation1(productQuality.toInt(), totalPrice);
  }

  minimumCheckValues1() {
    list.sort((a, b) => a['itemSize'].compareTo(b['itemSize']));
    bool minimumValues1 = false;
    var listBooleanValues = [];
    minCustMenuName.clear();
    for (var elementone in list) {
      bool minimumValues = CommonWidget().checkAddMinimumValues(
          isWeightCheck: isWeightCheck,
          elementOne: elementone,
          weightValues:  hybridWeightCalculation() ?? 0 ,
          customMenuValues: customMenu,
          minCustMenuName: minCustMenuName);
      listBooleanValues.add(minimumValues);
    }
    minimumValues1 = !listBooleanValues.contains(false);
    return minimumValues1;
  }

  overAllPriceCalculation() {
    List values = [];
    for (var element in customMenu) {
      if (element.selectedItems.isNotEmpty) {
        for (var selectedElements in element.selectedItems) {
          values.add(priceFinder(selectedElements.customProductId!));
        }
        values.sublist(0, element.selectedItems.length);
      }
    }
    return values;
  }

  priceFinder(int element) {
    dynamic values;
    for (var item in customMenu) {
      item.selectedItems.forEach((selectedElements) {
        for (var productElement in item.customProducts!) {
          if (element == productElement.customItemId &&
              productElement.itemsizeId == productSize) {
            values = productElement.points ?? '0.0';
          }
        }
      });
    }
    return values;
  }

  valuescheck() {
    bool values = false;
    List listValues = [];
    for (var element in customMenu) {
      listValues.add(element.selectedItems);
      if (listValues.isNotEmpty) {
        values = true;
      } else {
        values = false;
      }
    }
    return values;
  }

  selectedName() {
    List values = [];
    for (var element in customMenu) {
      if (element.selectedItems.isNotEmpty) {
        for (var element1 in element.selectedItems) {
          values.add(element1.itemName);
        }
      }
    }
    return values;
  }

  selectedID() {
    List values = [];
    for (var element in customMenu) {
      if (element.selectedItems.isNotEmpty) {
        for (var element1 in element.selectedItems) {
          values.add(element1.customProductId.toString());
        }
      }
    }
    return values;
  }

  allProductTotalValues(double subtotal) {
    return totalPrice + subtotal;
  }

  void startLoding() {
    loading = true;
    update();
  }

  void stopLoding() {
    loading = false;
    update();
  }

  deafulatCustomItems() {
    List values = selectedID();
    List values1 = defaultProduct;
    if (values.isEmpty && values1.isEmpty) {
      return true;
    } else if (values.isNotEmpty && values1.isNotEmpty) {
      if (values.length != values1.length) {
        return false;
      }
      for (int i = 0; i < values.length; i++) {
        if (values[i] != values1[i].toString()) {
          return false;
        }
      }
    } else if (values.isNotEmpty) {
      return false;
    }
    return true;
  }

  findSizeName(String? values) {
    for (var element in itemSize) {
      if (element.code == values) {
        return element.description;
      }
    }
  }
  findSizeCode(String? values) {
    for (var element in itemSize) {
      if (element.code == values) {
        return element.code;
      }
    }
  }

  addToCartCalculations() {
    double subTotal = 0.0;
    overAllPriceCalculation().forEach((element) {
      subTotal += double.parse(element);
    });

    if (customMenu.isNotEmpty) {
      final priceValues = overAllPriceCalculation().join(',');
      dynamic selectIDValues = selectedID().join(',');
      dynamic selectNameValues = selectedName().join(',');
      addCart(
          itemPrize: valuescheck() == false ? '0' : priceValues,
          itemID: valuescheck() == false ? '' : selectIDValues,
          totalCost: allProductTotalValues(subTotal),
          defaultCustom: deafulatCustomItems() == true ? 1 : 0,
          itemNames: valuescheck() == false ? '' : selectNameValues);
    } else {
      addCart(
          itemPrize: '0',
          itemID: '',
          totalCost: allProductTotalValues(subTotal),
          defaultCustom: deafulatCustomItems() == true ? 1 : 0,
          itemNames: '');
    }
  }

  Future<void> addCart(
      {required String itemPrize,
      required String itemID,
      required double totalCost,
      required int defaultCustom,
      required String itemNames}) async {
    if (_isAdding) {
      debugPrint("AddCart called again while already processing.");
      return; // Ignore repeated taps
    }

    _isAdding = true;
    startLoding();

    try {
      var response = await ProductPreviewServices.addCart(
        productId: argumentData['id'].toString(),
        quanity: productQuality.toInt(),
        productPrice: defaultPrice.toString(),
        itemPrice: itemPrize,
        itemId: itemID,
        totalCost: double.parse(
            priceCalculation1(productQuality.toInt(), totalPrice).toString()),
        status: 1,
        tempToken: SharedPrefs.instance.getString('tempToken')!,
        defaultSize: productSize,
        defaultCustom: defaultCustom,
        defaultSizeName: findSizeName(selectedValue),
        defaultSizeCode: findSizeCode(selectedValue),
        itemNames: itemNames,
        rewards: true,
        description: productDescription!);
    debugPrint(response);
    if (response != null) {
      stopLoding();
      showSnackBar(
          "Product added successfully! Your item has been added to the cart");
      Get.offAllNamed(Routes.mainScreen);
    } else {
      showSnackBar("Oops! Something went wrong.");
    }
    } catch (e) {
      debugPrint("Exception in addCart: $e");
      showSnackBar("Failed to add product.");
    } finally {
      _isAdding = false;
    }
  }

  weightWithOutItemSelection(
      {List<SelectedItems>? selectedItemsValues,
      dynamic maxValues,
      List<CustomizeMenuValueItems>? customizeMenuItemsValues,
      int? customizeMenuItemsId,
      int? customProductMenuId,
      int? productCustomWeight,
      String? customMenuName,
      String? customMenuDataName}) {
    if (selectedItemsValues!.length == int.parse(maxValues)) {
      CommonWidget().showLimitReachedDialog(
          customMenuName: customMenuDataName,
          values1: 0,
          productSize: findSizeName(selectedValue));
      isProductWeightCheck = false;
    }
    if (num.parse(maxValues) > selectedItemsValues.length) {
      CommonWidget().addSelectedItem(customizeMenuItemsId, customProductMenuId,
          productCustomWeight, customMenuName, selectedItemsValues);
      isProductWeightCheck = true;
      priceCalculation1(productQuality.toInt(), totalPrice);
    } else {
      maxminumchoose("Oops! Something went wrong.");
    }
    update();
  }

  weightWithOutItemRemove(
      {List<SelectedItems>? selectedItemsValues,
      int? customizeMenuItemsId,
      int? productWeightValues}) {
    selectedItemsValues!
        .removeWhere((item) => item.customProductId == customizeMenuItemsId);
    priceCalculation1(productQuality.toInt(), totalPrice);
    weightBasedLineGraphValues(weightCalculation() + 0);
    if (hybridProduct == 1) {
      productWeightTotalValues =
          productWeightTotalValues - productWeightValues!;
    }
    update();
  }

  weightCalculation() {
    int productTotal = 0;
    for (var elementValues in customMenu) {
      for (var selectElement in elementValues.selectedItems) {
        productTotal += (selectElement.weight ?? 0);
      }
    }
    return productTotal;
  }

  weightWithInItemSelection(
      {List<SelectedItems>? selectedItemsValues,
      String? customMenuName,
      int? customizeMenuItemsId,
      int? productCustomWeight,
      String? customMenuDataName,
      int? customProductMenuId}) {
    int totalValues = weightCalculation() + productCustomWeight;
    // print(totalValues);
    // print(productCustomWeight);

    if (totalValues.isGreaterThan(num.parse(weightValues!))) {
      CommonWidget().showLimitReachedDialog(
          customMenuName: customMenuDataName,
          values1: 1,
          productSize: findSizeName(selectedValue));
      isProductWeightCheck = false;
    } else {
      CommonWidget().addSelectedItem(customizeMenuItemsId, customProductMenuId,
          productCustomWeight, customMenuName, selectedItemsValues);
      isProductWeightCheck = true;
      weightBasedLineGraphValues(totalValues);
    }
    priceCalculation1(productQuality.toInt(), totalPrice);
    update();
  }

  selectItemsDifferentFormsCalculation(
      List<SelectedItems>? selectedItemsValues) {
    int productTotal = 0;
    for (var selectElement in selectedItemsValues!) {
      productTotal += (selectElement.weight ?? 0);
    }
    return productTotal;
  }

  hybridWeightCalculation(){
    int productTotal = 0;
    for (var elementValues in customMenu) {
      if(elementValues.selectedItems.isNotEmpty  && elementValues.isHybrid =='1') {
        for (var selectElement in elementValues.selectedItems) {
          productTotal += (selectElement.weight ?? 0);
        }
      }
    }
    return productTotal;
  }
  productMinsValues(String values, String values2, String hybridvalues) {
    if (isWeightCheck != '1' && hybridProduct != 1) {
      return "Min: $values Max: $values2";
    }
    if (hybridProduct == 1) {
      if (hybridvalues == '1') {
        return "Weight : $values , $values2";
      } else {
        return "Min: $values Max: $values2";
      }
    }
    if (isWeightCheck == '1') {
      return "Weight :$weightValues";
    }
  }

  selectItemsDifferentFormsSelection(
      {List<SelectedItems>? selectedItemsValues,
      String? customMenuName,
      int? customizeMenuItemsId,
      dynamic maxValues,
      String? customMenuDataName,
      String? isHybrid,
      int? productCustomWeight,
      int? customProductMenuId}) {
    if (isHybrid == '1') {
      productWeightTotalValues = hybridWeightCalculation() + productCustomWeight;
      // if(favouriteValues ==null){
      //
      //   if (countValues == 0) {
      //     countValues++;
      //
      //     productWeightTotalValues =
      //         selectItemsDifferentFormsCalculation(selectedItemsValues) +
      //             productCustomWeight;
      //   }else{
      //     productWeightTotalValues =
      //         productWeightTotalValues + productCustomWeight!;
      //   }
      //
      // }
      //
      //  else {
      //   productWeightTotalValues =
      //       productWeightTotalValues + productCustomWeight!;
      // }
      if (productWeightTotalValues
          .isGreaterThan(num.parse(maxValues.toString()))) {
        productWeightTotalValues =
            productWeightTotalValues - productCustomWeight!;
        CommonWidget().showLimitReachedDialog(
            customMenuName: customMenuDataName,
            values1: 1,
            productSize: findSizeName(selectedValue));
        isProductWeightCheck = false;
      } else {
        CommonWidget().addSelectedItem(
            customizeMenuItemsId,
            customProductMenuId,
            productCustomWeight,
            customMenuName,
            selectedItemsValues);

        weightBasedLineGraphValues(productWeightTotalValues);
        isProductWeightCheck = true;
      }
    } else {
      if (selectedItemsValues!.length == int.parse(maxValues)) {
        CommonWidget().showLimitReachedDialog(
            customMenuName: customMenuDataName,
            values1: 0,
            productSize: findSizeName(selectedValue));
        isProductWeightCheck = false;
      }
      if (num.parse(maxValues) > selectedItemsValues.length) {
        CommonWidget().addSelectedItem(
            customizeMenuItemsId,
            customProductMenuId,
            productCustomWeight,
            customMenuName,
            selectedItemsValues);
        isProductWeightCheck = true;
      }
    }
    priceCalculation1(productQuality.toInt(), totalPrice);
    update();
  }

  weightBasedLineGraphValues(int? totalLength) {
    return change(lineGraphValues = (totalLength! / num.parse(weightValues!)));
  }

  weightOthersBasedLineGraphValues(
      {int? customMenuId,
      List<SelectedItems>? selectedItemsValues,
      final String? isHybrid,
      int? totalLength}) {
    double values = 0.0;
    final size = minMaxShow(customMenuId);
    if (isWeightCheck != '1' && hybridProduct != 1) {
      if (size['itemSize'] == customMenuId.toString()) {
        if (selectedItemsValues!.isEmpty) {
          values = 0;
        } else {
          values =
              selectedItemsValues.length / int.parse(size['max'].toString());
        }
      }
      return values;
    } else if (hybridProduct == 1) {
      if (isHybrid == '1') {
        int totalValues=hybridWeightCalculation();
        if (totalValues != 0) {
          values = totalValues / int.parse(size['max'].toString());
        } else {
          values = 0;
        }
      } else {
        if (size['itemSize'] == customMenuId.toString()) {
          if (selectedItemsValues!.isEmpty) {
            values = 0;
          } else {
            values =
                selectedItemsValues.length / int.parse(size['max'].toString());
          }
        }
      }
      return values;
    }
    update();
  }

  valuesChanges(int index, String values) {
    productIndex = index.obs;
    if (values == 'productValues') {
      return double.parse(weightOthersBasedLineGraphValues(
                      selectedItemsValues: customMenu[index].selectedItems,
                      customMenuId: customMenu[index].id!,
                      isHybrid: customMenu[index].isHybrid)
                  .toString())
              .isNegative
          ? 0.0
          : double.parse(weightOthersBasedLineGraphValues(
                  selectedItemsValues: customMenu[index].selectedItems,
                  customMenuId: customMenu[index].id!,
                  isHybrid: customMenu[index].isHybrid)
              .toString());
    }
    update();
  }
}
