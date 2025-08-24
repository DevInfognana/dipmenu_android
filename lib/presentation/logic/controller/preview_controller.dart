import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// import '../../../core/enum/permission_handling.dart';
import 'package:dip_menu/presentation/logic/controller/controller_Index.dart';

class PreviewController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageController;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
     // PermissionHandler.requestLocationPermission();
     // PermissionHandler.requestAllPermission();

  }

  next() {
    currentIndex.value++;
    pageController.animateToPage(currentIndex.value,
        duration: const Duration(microseconds: 900), curve: Curves.easeInOut);
  }

  @override
  void onClose() {
    currentIndex.value = 0;
    super.onClose();
  }

  onPageChanged(int index) {
    currentIndex.value = index;
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

  mainScreen(){
    SharedPrefs.instance.setBool("First_Time_Entry", false);
    SharedPrefs.instance.setString("tempToken", generateRandomString());

    // tempToken = generateRandomString();
     Get.offNamed(Routes.mainScreen);
  }
}