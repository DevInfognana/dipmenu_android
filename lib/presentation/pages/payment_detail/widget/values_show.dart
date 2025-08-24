import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../../../core/config/app_textstyle.dart';

Widget rowValues({String? value1, String? value2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(value1!,
          style: Get.context?.theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold)),
      Text(
        value2!,
        style: Get.context?.theme.textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
