// ignore_for_file: file_names

import 'package:get/get.dart';

import '../controller/preview_controller.dart';


class PreviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PreviewController());
  }

}