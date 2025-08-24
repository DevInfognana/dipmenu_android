import 'package:dip_menu/domain/reporties/auth_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../data/model/profile_model.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';


class EditProfileController extends GetxController {
  bool isVisibilty = true;
  bool isConfirmVisibilty = true;

  bool validate = true;
  String? currentTextPin;
  final fromKey = GlobalKey<FormState>();
  final singUpKey = GlobalKey<FormState>();
  ProfileDataValue argumentData = Get.arguments;

  File? imageFile;
  String? fileNamevalue;
  bool? imageupload;

  bool loding = false;



  changeValues(XFile? pickedFile){
    imageFile = File(pickedFile!.path);
    String fileName = pickedFile.path.split("image_picker").last;
    fileNamevalue =
        fileName.replaceAll(fileName, 'upload_image');
    // widget.imageUrl = '';
  imageupload = true;
  update();
  }



  void startLoding() {
    loding = true;
    update();
  }

  void stopLoding() {
    loding = false;
    update();
  }

  Future<void> editProfile(
      {required String fnName,
      required String lsName,
      // required String location,
      required String mobileNo,
      required String email,
      required String imageUrl,
      required String imageName,
      required bool imageUpload}) async {
    startLoding();
    Map values = {
      "id": argumentData.id,
      "first_name": fnName,
      "last_name": lsName,
      "email": email,
      "role_id": 2,
      "mobile": mobileNo,
      // "location": location,
      "reward_points": argumentData.rewardPoints,
      "profile_imageurl": imageUrl,
      "imageName": imageName,
      "imageUpload": imageUpload
    };
    final encryptingDataValues = Encrypt.encryptingData(values);

    // print(encryptingDataValues);
    try {
      dynamic user = await AuthApi().editProfile(payload: encryptingDataValues);
      if (user != null) {
        Get.offAllNamed(Routes.mainScreen, arguments: 3);
        showSnackBar("Profile updated successfully ");
      } else {
        showSnackBar("Oops! Something went wrong.");
      }
    } catch (e) {
      stopLoding();
      showSnackBar("Oops! Something went wrong.");
    }
  }
}
