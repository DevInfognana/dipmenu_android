import '../entities/crud_operation.dart';
import '../provider/http_request.dart';

class SubCategoryServices {
  static viewSubCategoryRequest(String? values) async {
    var url = '${BaseAPI.api}/website/category/${values!}' ;

    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }

  static viewSubCategoryProductRequest(String? values) async {
    var url = '${BaseAPI.api}/website/subcategory/products/$values?query=';

    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }




/*  static viewHomeFoods() async {
    var url = '${BaseAPI.api}' + '/products/popularProduct';

    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }

  static viewHomeOffers() async {
    var url = '${BaseAPI.authPath}' + '/discounts';

    var response = await Crud.getData(url, map: {
      "pagesize": 3,
      "page": 1,
    });
    return response.fold((l) => l, (r) => r);
  }*/
}