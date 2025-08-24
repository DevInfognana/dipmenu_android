
import '../entities/crud_operation.dart';
import '../provider/http_request.dart';

/*class AboutUsViewServices {
  Future<AboutUsData> aboutUsAPi({
    required String values,
  }) async {
    var url = '${BaseAPI.api}/website/aboutus}';
    print(url);
    var response = await Dio().get(
        url,
        options: Options(headers: BaseAPI.headers)
    );
    int? statusCode = response.statusCode;
    if (statusCode == 200) {
      AboutUsData result = AboutUsData.fromJson(response.data);
      return result;
    } else {
      throw Exception('not Login');
    }
  }

}*/

class AboutUsServices {
  static aboutUsRequest() async {
    var url = '${BaseAPI.api}/website/aboutus';
    var response = await Crud.getData(url);
    return response.fold((l) => l, (r) => r);
  }
}