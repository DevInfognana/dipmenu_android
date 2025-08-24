// import 'package:dio/dio.dart';
//
//
// import '../local_handler/Local_handler.dart';
// import '../provider/http_request.dart';


class CartListServices {
  // static cartListRequest() async {
  //   var url = BaseAPI.cartListApi;
  //   var response = await Dio().post(
  //     url,
  //     options: Options(headers: {
  //       'x-access-token':
  //       SharedPrefs.instance.getString('token')
  //     }),
  //   );
  //   int? statusCode = response.statusCode;
  //   if (statusCode == 200) {
  //    // Signup_values user = Signup_values.fromJson(response.data);
  //     //return user;
  //   } else {
  //     throw Exception('not Login');
  //   }
  //  // var response = await Crud.getData(url);
  //  // return response.fold((l) => l, (r) => r);
  // }

 // -------similar that signup api
  /*Future<Signup_values> singup({
    required String fnName,
    required String lsName,
    required String mobileNo,
    required String location,
    required String email,
    required String password,
  }) async {
    var url = BaseAPI.signUpAPI;

    var body = jsonEncode({
      "role_id": "1",
      "first_name": fnName,
      "last_name": lsName,
      "email": email,
      "password":password,
      "mobile":mobileNo,
      "location":location,
      "status": 1
    });

    var response = await Dio().post(
      url,
      data: body,
      // options: Options(headers: BaseAPI.headers),
    );
    int? statusCode = response.statusCode;
    if (statusCode == 200) {
      Signup_values user = Signup_values.fromJson(response.data);
      return user;
    } else {
      throw Exception('not Login');
    }
  }*/

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

}