import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dip_menu/data/model/profile_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/dio_exception.dart';

class ProfileController extends GetxController with StateMixin {
  dynamic argumentData = Get.arguments;
  final fromKey = GlobalKey<FormState>();
  final singUpKey = GlobalKey<FormState>();
  // var isDataLoading = false.obs;
  // StatusRequest? statusRequestProfile;
  // String? token_value = SharedPrefs.instance.getString('token');
  //
  // String? user_id = SharedPrefs.instance.getString('user_id');

  // ProfileData? temp;
  ProfileDataValue? profileValues;

  // profile data
  String? name;
  String? mobileNumber;
  String? imageUrl;
  int? rewardpoints;
  int? wallet;
  RxBool isDarkMode=false.obs;
  RxBool isDeleting = false.obs;

  @override
  void onInit() async {
    super.onInit();
    if (SharedPrefs.instance.getString('user_id') != null) {
      profile(iD: SharedPrefs.instance.getString('user_id')!);
    }

    if(Get.isDarkMode){
      isDarkMode.value=true;
    }else{
      isDarkMode.value=false;
    }
  }



  profile({required String iD}) async {
    // statusRequestProfile = StatusRequest.loading;
    // var response = await ProfileViewServices().profileAPi(values: iD);
    //
    // profileValues =  ProfileDataValue.fromJson(response['datas']);
    // statusRequestProfile = handlingData(response);
    // if (StatusRequest.success == statusRequestProfile) {
    //    // profileValues =  ProfileDataValue.fromJson(response['datas']);
    //    name=profileValues!.firstName;
    //    mobileNumber=profileValues!.mobile;
    //
    //    if(profileValues!.driveThruDetails !=null){
    //      SharedPrefs.instance.setString('drive_thru',profileValues!.driveThruDetails);
    //    }
    //    if(profileValues!.profileImageurl !=null&& profileValues!.profileImageurl.toString().isNotEmpty){
    //      imageUrl=profileValues!.profileImageurl;
    //    }else{
    //      imageUrl=null;
    //    }
    //
    //    SharedPrefs.instance.setInt('rewards', profileValues!.rewardPoints!);
    //    print( SharedPrefs.instance.getInt('rewards'));
    //
    //
    //    statusRequestProfile = handlingData(response);
    //    change(profileValues);
    // } else {
    //   if(StatusRequest.serverfailure==statusRequestProfile){
    //     clearValues();
    //   }
    //   statusRequestProfile = StatusRequest.failure;
    // }
    // update();
    try{
      change(null, status: RxStatus.loading());
      var url = '${BaseAPI.profileAPI}/$iD';
      var response = await Dio().get(url,
          options: Options(headers: {
            'x-access-token': SharedPrefs.instance.getString('token')
          }));
      int? statusCode = response.statusCode;
      if (statusCode == 200) {
        ProfileData user = ProfileData.fromJson(response.data);

        name = user.datas!.firstName;
        mobileNumber = user.datas!.mobile;
        SharedPrefs.instance.setString('Email', user.datas!.email!);
        change(name, status: RxStatus.success());
        change(mobileNumber, status: RxStatus.success());
        change(rewardpoints = user.datas!.rewardPoints);
        change(wallet = user.datas!.wallet!.toInt());
        change(profileValues = user.datas);
        change(SharedPrefs.instance
            .setString('wallet', user.datas!.wallet.toString()));
        if (user.datas!.driveThruDetails != null) {

          SharedPrefs.instance
              .setString('drive_thru', user.datas!.driveThruDetails);

          /*final string2 = user.datas!.driveThruDetails.replaceAll("\"", "");
        final quotedString =
            string2.replaceAllMapped(RegExp(r'\b\w+\b'), (match) {
          return '"${match.group(0)}"';
        });*/
          // final decoded = json.decode(quotedString);
          Map<String, dynamic> decoded =
          json.decode(user.datas!.driveThruDetails);
          SharedPrefs.instance.setString('vehicleModel', decoded['vehicleModel']);

          SharedPrefs.instance.setString('vehicleColor', decoded['vehicleColor']);
          // SharedPrefs.instance.setString('vehicleNo', decoded['vehicleNo']);
        }
        if (user.datas!.profileImageurl != null &&
            user.datas!.profileImageurl.toString().isNotEmpty) {
          change(imageUrl = user.datas!.profileImageurl);
        } else {
          change(imageUrl = null);
          imageUrl = null;
        }
        change(SharedPrefs.instance.setInt('rewards', user.datas!.rewardPoints!));
        SharedPrefs.instance.setInt('rewards', user.datas!.rewardPoints!);
        return user;
      } else {
        logoutValues();
        change(null, status: RxStatus.error(response.statusMessage));
      }
    }on DioError catch (e){
      final errorMessage = DioExceptions.fromDioError(e).toString();
      logoutValues();
      change(null, status: RxStatus.error(errorMessage));
    }

  }

  toggleChanges(bool  values){

    if(values ==true){
      isDarkMode.value=true;
      Get.changeThemeMode(ThemeMode.dark);
      SharedPrefs.instance.setBool('darkMode',isDarkMode.value );
    }else{
      isDarkMode.value=false;
      Get.changeThemeMode(ThemeMode.light);
      SharedPrefs.instance.setBool('darkMode',isDarkMode.value );
    }

    // print(isDarkMode);
    // Get.offAllNamed(Routes.mainScreen, arguments: 3);
    update();
  }

  logoutValues() async {
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
    Get.offAllNamed(Routes.mainScreen);
  }

  // Delete Account
  Future<void> deleteAccount() async {
    isDeleting.value = true;
    try {
      String userId = SharedPrefs.instance.getString('user_id') ?? '';
      if (userId.isEmpty) {
        throw Exception("User ID not found");
      }

      String? token = SharedPrefs.instance.getString('token');
      if (token == null || token.isEmpty) {
        throw Exception("Token not found");
      }

      var url = '${BaseAPI.deleteAccountAPI}/$userId';
      var response = await Dio().delete(
        url,
        options: Options(headers: {'x-access-token': token}),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Your account has been deleted successfully.',
          snackPosition: SnackPosition.BOTTOM,
        );
        await clearUserData();
      } else if (response.statusCode == 401) {
        Get.snackbar(
          'Error',
          'Unauthorized access. Please log in again.',
          snackPosition: SnackPosition.BOTTOM,
        );
        await clearUserData();
      } else {
        Get.snackbar(
          'Error',
          'Failed to delete account. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isDeleting.value = false;
    }
  }

  // Renamed Method for Clearing Data
  Future<void> clearUserData() async {
    await SharedPrefs.instance.clear();
    Get.offAllNamed(Routes.mainScreen);
  }



}
