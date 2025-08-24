import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dip_menu/data/model/forgot_password_screen.dart';
import 'package:dip_menu/domain/local_handler/Local_handler.dart';

import '../../data/model/sign_up_user_model.dart';
import '../../data/model/user_model.dart';
import '../provider/http_request.dart';

class AuthApi {
  /* String baseUrl = '/api';
  final shaedpref = SharedPrefs.instance;
  Future<bool> signupAPI(
      String phone, String fullName, String password, String email) async {
    var url = '${BaseAPI.authPath}' + '/register';

    var body = jsonEncode({
      'name': fullName,
      'phone_number': phone,
      'password': password,
      'email': email,
    });
    Response response = await Dio().post(
      url,
      data: body,
    );
    Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200) {
      if (data['message'] == 'fails') {
        return false;
      } else {
        shaedpref.setString("token", '${data['access_token']}');
        shaedpref.setString("phone_number", '${data['user']['phone_number']}');
        shaedpref.setString("email", '${data['user']['email']}');
        shaedpref.setString("image", '${data['user']['image']}');
        shaedpref.setString("name", '${data['user']['name']}');

        return true;
      }
    } else {
      throw Exception('Gagal Register');
    }
  }*/
  Future<Signin_values> login({
    required String email,
    required String password,
  }) async {
    var url = BaseAPI.signInAPI;

    var body = jsonEncode({
      'email': email,
      'password': password,
      "temp_token": SharedPrefs.instance.getString('tempToken')
    });

    var response = await Dio().post(
      url,
      data: body,
      // options: Options(headers: BaseAPI.headers),
    );
    int? statusCode = response.statusCode;
    if (statusCode == 200) {
      Signin_values user = Signin_values.fromJson(response.data);
      SharedPrefs.instance.setString("token", '${user.accessToken}');
      SharedPrefs.instance.setBool("First_Time_Entry", false);
      SharedPrefs.instance.setString("user_id", '${user.id}');
      SharedPrefs.instance.setString("first_name", '${user.username}');
      SharedPrefs.instance.setString("user_email", '${user.email}');
      return user;
    } else {
      throw Exception('not Login');
    }
  }

  Future<Signup_values> singup({
    required String fnName,
    required String lsName,
    required String mobileNo,
    // required String location,
    required String email,
    required String password,
  }) async {
    var url = BaseAPI.signUpAPI;

    var body = jsonEncode({
      "role_id": 2,
      "first_name": fnName,
      "last_name": lsName,
      "email": email,
      "password": password,
      "mobile": mobileNo,
      // "location": location,
      "profile_imageurl": ""
    });

    // print(body);
    var response = await Dio().post(
      url,
      data: body,
    );
    int? statusCode = response.statusCode;
    if (statusCode == 200) {
      Signup_values user = Signup_values.fromJson(response.data);
      return user;
    } else {
      throw Exception('not Login');
    }
  }

  Future forgotPassword({required String email}) async {
    var url = BaseAPI.forgotpassword;

    var body = jsonEncode({"email": email});

    var response = await Dio().post(
      url,
      data: body,
    );
    // print(response);
    int? statusCode = response.statusCode;
    // print(statusCode);
    if (statusCode == 200) {
      dynamic user = ForgotpasswordModel.fromJson(response.data);
      return user;
    } else {
      throw Exception('not Login');
    }
  }

  Future changePassword({required dynamic payload}) async {
    var url = BaseAPI.resetpassword;

    var body = jsonEncode({"payload": payload});

    // print(body);
    // print(url);
    var response = await Dio().post(
      url,
      data: body,
      options: Options(headers: {
        'x-access-token': SharedPrefs.instance.getString('token'),
        "Content-Type": "application/json"
      }),
    );
    // print(response);
    int? statusCode = response.statusCode;

    if (statusCode == 200) {
      String values = 'Reset password success';
      return values;
    } else {
      throw Exception('not Login');
    }
  }

  Future<String> editProfile({required var payload}) async {
    var url = BaseAPI.updateProfile;

    var body = jsonEncode({
      "payload": payload,
    });

    var response = await Dio().post(
      url,
      data: body,
      options: Options(
          headers: {'x-access-token': SharedPrefs.instance.getString('token')}),
    );
    // print(response);

    if (response.statusCode == 200) {
      String values22 = 'welcome';

      return values22;
      /*  Signup_values user = Signup_values.fromJson(response.data);
      return user;*/
    } else {
      throw Exception('not Login');
    }
  }

/* Future<bool> resetPasswordStep1({
    required String email,
  }) async {
    var url = '${BaseAPI.baseImage}' + '/password/email';

    var body = jsonEncode({
      'email': email,
    });

    var response = await Dio().post(
      url,
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );
    print(response.data);
    Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200 && data['message'] != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPasswordStep2({
    required String code,
  }) async {
    var url = '${BaseAPI.authPath}' + '/password/code/check';

    var body = jsonEncode({
      'code': code,
    });

    var response = await Dio().post(
      url,
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );

    Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200 && data['message'] != 'fails') {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPasswordStep3({
    required String code,
    required String password,
  }) async {
    var url = '${BaseAPI.authPath}' + '/password/reset';

    var body = jsonEncode({'code': code, 'password': password});

    var response = await Dio().post(
      url,
      data: body,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          }),
    );

    Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200 && data['message'] != 'fails') {
      return true;
    } else {
      // throw Exception('Gagal Login');
      return false;
    }
  }

  void logout() async {
    var url = '${BaseAPI.authPath}' + '/logout';

    await Dio()
        .post(url,
        options: Options(headers: {
          'Authorization':
          'Bearer ${SharedPrefs.instance.getString('token')}'
        }))
        .whenComplete(() {
      SharedPrefs.instance.remove('token');
    });
  }

  static Future<bool> changePassword({
    required String old_password,
    required String password,
  }) async {
    var url = '${BaseAPI.authPath}' + '/user/changePassword';
    var body = jsonEncode({
      'old_password': old_password,
      'password': password,
      'confirm_password': password
    });

    var response = await Dio().post(
      url,
      data: body,
      options: Options(headers: {
        'Authorization': 'Bearer ${SharedPrefs.instance.getString('token')}'
      }),
    );
    Map<String, dynamic> data = new Map<String, dynamic>.from(response.data);

    if (response.statusCode == 200 &&
        (data['status'] == 422 ||
            data['status'] == 200 ||
            data['status'] == 201)) {
      return true;
    } else {
      return false;
    }
  }*/
}
