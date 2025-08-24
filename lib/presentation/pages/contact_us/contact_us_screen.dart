import 'package:dip_menu/presentation/logic/controller/contact_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  final contactUsController = Get.find<ContactUsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: AuthBackButton(press: () {
                Get.back();
              }),
              centerTitle: true,
              title: TextScaleFactorClamper(
                  child: AuthTitleText(text: NameValues.contactUs))),
          body: TextScaleFactorClamper(
              child: GetBuilder<ContactUsController>(builder: (_) {
            return HandlingDataView(
                statusRequest: contactUsController.statusRequestBanner,
                widget: contactUsWidget());
          }))),
    );
  }

  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  contactUsWidget() {
    return ListView.builder(
        itemCount: contactUsController.contactUsList.length,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Expanded(
                  child: Text(contactUsController.contactUsList[index].name!,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: context.theme.textTheme.headlineMedium!.copyWith(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: getDeviceType() == 'phone' ? 20.0 : 23.0)),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                    child: Center(
                  child:  HtmlView(text: contactUsController.contactUsList[index].content!,))
                )

              ]),
            ]),
          );
        });
  }

}
