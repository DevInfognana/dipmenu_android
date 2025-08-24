import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dip_menu/data/model/user_model.dart';
import 'package:dip_menu/domain/reporties/auth_api.dart';
// import 'package:dip_menu/domain/entities/encryption_file.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../domain/entities/dio_exception.dart';

class AuthController extends GetxController with StateMixin {
  dynamic argumentData = Get.arguments;
  bool isSignInVisibilty = true;
  bool isVisibilty = true;
  bool isConfirmVisibilty = true;

  final fromKey = GlobalKey<FormState>();
  final singUpKey = GlobalKey<FormState>();
  final forgotpasswordKey = GlobalKey<FormState>();
  final changepasswordKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  bool loding = false;

  void signInVisibilty() {
    change(isSignInVisibilty = !isSignInVisibilty);
  }

  void visibility() {
    change(isVisibilty = !isVisibilty);
  }

  void confirmVisibility() {
    change(isConfirmVisibilty = !isConfirmVisibilty);
  }

  String generateRandomString() {
    Random random = Random();
    String characters = '0123456789abcdefghijklmnopqrstuvwxyz';
    String randomString = '';
    for (int i = 0; i < 15; i++) {
      randomString += characters[random.nextInt(characters.length)];
    }
    return randomString;
  }

  Future<void> login({required String email, required String password}) async {
    change(null, status: RxStatus.loading());
    var url = BaseAPI.signInAPI;
    var cardInput = jsonEncode({
      'email': email,
      'password': password,
      "temp_token": SharedPrefs.instance.getString('tempToken')
    });

    try {
      var response = await Dio().post(
        url,
        data: cardInput,
      );

      if (response.statusCode == 200) {
        change(null, status: RxStatus.success());
        Signin_values user = Signin_values.fromJson(response.data);
        SharedPrefs.instance.setString("token", '${user.accessToken}');
        SharedPrefs.instance.setBool("First_Time_Entry", false);
        SharedPrefs.instance.setString("user_id", '${user.id}');
        SharedPrefs.instance.setString("first_name", '${user.username}');
        SharedPrefs.instance.setString("user_email", '${user.email}');
        showSnackBar("Successfully logged in");
        Get.offNamed(Routes.mainScreen);
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      // print(errorMessage);
      showSnackBar("Invalid User Name or Password");
      change(null, status: RxStatus.error('Invalid User Name or Password'));
    }

    // try {
    //   dynamic user = await AuthApi.login(
    //     email: email,
    //     password: password,
    //   );
    //   print(user);
    //   // if (user != null) {
    //   //   showSnackBar("Successfully Login");
    //   //   Get.offNamed(Routes.mainScreen);
    //   //   change(null, status: RxStatus.success());
    //   // } else {
    //   //   change(null, status: RxStatus.error('something went wrong'));
    //   // }
    // } catch (e) {
    //   print(e);
    //   // change(null, status: RxStatus.error('Invalid User Name or Password'));
    //   // showSnackBar("Invalid User Name or Password");
    // }
  }

  Future<bool> favLogin(
      {required String email, required String password}) async {
    change(null, status: RxStatus.loading());
    try {
      return await AuthApi()
          .login(email: email, password: password)
          .then((value) {
        if (value == null) {
          change(null, status: RxStatus.error('something went wrong'));
          showSnackBar("Oops! Something went wrong.");
        }
        return value != null ? true : false;
      });
    } catch (e) {
      showSnackBar("Invalid User Name or Password");
      change(null, status: RxStatus.error('something went wrong'));
      return false;
    }
  }

  Future singUp(
      {required String fnName,
      required String lsName,
      // required String location,
      required String mobileNo,
      required String email,
      required String password}) async {
    change(null, status: RxStatus.loading());
    var url = BaseAPI.signUpAPI;
    var body = jsonEncode({
      "role_id": 2,
      "first_name": fnName,
      "last_name": lsName,
      "email": email,
      "password": password,
      "mobile": mobileNo,
      "profile_imageurl": "",
      "imageUpload": false
    });


    try {
      var response = await Dio().post(
        url,
        data: body,
      );
      if (response.statusCode == 200) {
        showSnackBar("Your account has been created successfully");

        Get.offAllNamed(Routes.loginScreen);
        change(null, status: RxStatus.success());
      } else {
        showSnackBar(response.statusMessage);
      }
    } on DioError catch (e) {
      // print(e);
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showSnackBar(errorMessage);
      change(null, status: RxStatus.error('Invalid User Name or Password'));
    }
  }

  // Future<void> SingUp(
  //     {required String fnName,
  //     required String lsName,
  //     // required String location,
  //     required String mobileNo,
  //     required String email,
  //     required String password}) async {
  //   startLoding();
  //   try {
  //     Signup_values user = await AuthApi().singup(
  //       fnName: fnName,
  //       // location: location,
  //       lsName: lsName,
  //       mobileNo: mobileNo,
  //       email: email,
  //       password: password,
  //     );
  //
  //     print(user);
  //     if (user != null) {
  //       showSnackBar("Your account has been created successfully");
  //       // showSnackBar("Successfully signUp");
  //       Get.offAllNamed(Routes.loginScreen);
  //       stopLoding();
  //     } else {
  //       showSnackBar("Oops! Something went wrong.");
  //     }
  //   } catch (e) {
  //     stopLoding();
  //     showSnackBar("Oops! Something went wrong.");
  //   }
  // }

  Future<void> forgotPassword({required String email}) async {
    var url = BaseAPI.forgotpassword;
    change(null, status: RxStatus.loading());
    var cardInput = jsonEncode({"email": email});

    try {
      var response = await Dio().post(
        url,
        data: cardInput,
      );
      // print(response);
      if (response.statusCode == 200) {
        showSnackBar(
            "The link has been sent, please check your email to reset your password.");
        Get.offAllNamed(Routes.loginScreen);
        change(null, status: RxStatus.success());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();

      showSnackBar(errorMessage);
      change(null, status: RxStatus.error('Invalid User Name or Password'));
    }
    // change(null, status: RxStatus.success());
    // try {
    //   dynamic user = await AuthApi().forgotPassword(
    //     email: email,
    //   );
    //   if (user != null) {
    //     showSnackBar("forgot password Link Send your Email.please check");
    //     Get.offAllNamed(Routes.loginScreen);
    //     change(null, status: RxStatus.error('Invalid User Name or Password'));
    //   } else {
    //     showSnackBar("Oops! Something went wrong.");
    //   }
    // } catch (e) {
    //   change(null, status: RxStatus.error('Invalid User Name or Password'));
    //   showSnackBar("Oops! Something went wrong.");
    // }
  }

  Future<void> changePassword(
      {required String oldpassword,
      required String newpassword,
      int? id}) async {
    change(null, status: RxStatus.success());

    var url = BaseAPI.resetpassword;
    Map values = {
      "password": oldpassword,
      "confirmpassword": newpassword,
      "id": argumentData
    };
    // print(values);
    final encryptingDataValues = Encrypt.encryptingData(values);
    var cardInput = jsonEncode({"payload": encryptingDataValues});
    // print(cardInput);
    try {
      var response = await Dio().post(
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'x-access-token': SharedPrefs.instance.getString('token'),
            },
          ),
          url,
          data: cardInput);
      if (response.statusCode == 200) {
        showSnackBar("Change password successfully");
        Get.offAllNamed(Routes.loginScreen,
            arguments: afterChangePasswordLogoutValues());
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      showSnackBar(errorMessage);
      change(null, status: RxStatus.error('Invalid User Name or Password'));
    }
    // try {
    //   Map values = {
    //     "password": oldpassword,
    //     "confirmpassword": newpassword,
    //     "id": argumentData
    //   };
    //   final encryptingDataValues = Encrypt.encryptingData(values);
    //
    //   print(encryptingDataValues);
    //   dynamic user =
    //       await AuthApi().changePassword(payload: encryptingDataValues);
    //   if (user != null) {
    //     showSnackBar("Change password successfully");
    //     Get.offAllNamed(Routes.loginScreen,
    //         arguments: afterChangePasswordLogoutValues());
    //   } else {
    //     showSnackBar("Oops! Something went wrong.");
    //   }
    // } catch (e) {
    //   change(null, status: RxStatus.error('Invalid User Name or Password'));
    //   showSnackBar("Oops! Something went wrong.");
    // }
  }

  afterChangePasswordLogoutValues() async {
    await SharedPrefs.instance.remove('user_id');
    await SharedPrefs.instance.remove('token');
    await SharedPrefs.instance.remove('first_name');
    await SharedPrefs.instance.remove('user_email');
    await SharedPrefs.instance.remove('drive_thru');
    await SharedPrefs.instance.remove('rewards');
    await SharedPrefs.instance.remove('startingTime');
    await SharedPrefs.instance.remove('endingTime');
    await SharedPrefs.instance.remove('vehicleModel');
    await SharedPrefs.instance.remove('vehicleColor');
    await SharedPrefs.instance.remove('vehicleNo');
    await SharedPrefs.instance.remove('bottomBar');
    await SharedPrefs.instance.remove('Email');
    await SharedPrefs.instance.remove('wallet');
    await SharedPrefs.instance.remove('disclaimer');
    await SharedPrefs.instance.remove('OrderNumberList');
    await SharedPrefs.instance.remove('shopLatitude');
    await SharedPrefs.instance.remove('shopLongitude');
    await SharedPrefs.instance.remove('shopRadius');
    // Get.offAllNamed(Routes.mainScreen);
  }

  guestLogin() {
    Get.offNamed(Routes.mainScreen, arguments: 3);
  }
}
