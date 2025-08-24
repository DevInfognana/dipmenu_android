import 'package:dip_menu/extra/common_widgets/text_scalar_factor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/theme.dart';

class AuthBackButton extends StatelessWidget {
  final Function? press;

  const AuthBackButton({Key? key, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
          child: SizedBox(
              height: 6.h,
              width: 12.w,
              child: Padding(
                  padding: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: Center(
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.black, size: 6.w),
                  ))),
        ),
      ),
    );
  }
}

class AuthTitleText extends StatelessWidget {
  final String? text;

  const AuthTitleText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!.tr,
      style: Theme.of(context)
          .textTheme
          .displaySmall
          ?.copyWith(fontWeight: FontWeight.bold),
      // style: TextStore.textTheme.displaySmall!
      //     .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}

class HtmlView extends StatelessWidget {
  final String? text;

  const HtmlView({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(data: text, style: {'html': testStyle()});
  }

  testStyle() {
    return Style(
        color: Get.isDarkMode ? Colors.white : Colors.black,
        fontSize:
            FontSize(DeviceTypeValues.getDeviceType() == 'phone' ? 20 : 17));
  }
}

class DividerView extends StatelessWidget {
  DividerView({Key? key, this.colorValues, this.values}) : super(key: key);
  Color? colorValues = Colors.grey;
  int? values;

  @override
  Widget build(BuildContext context) {
    return values == 0
        ? Divider(
            height: 20,
            thickness: 0.5,
            indent: 10,
            endIndent: 6,
            color: colorValues)
        : const Divider(
            height: 1.0,
            color: tileColor,
            thickness: 2.0,
          );
  }
}
