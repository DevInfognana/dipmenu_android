import 'package:dip_menu/presentation/logic/controller/about_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({Key? key}) : super(key: key);
  final aboutUsController = Get.find<AboutUsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: AuthBackButton(
                press: () {
                  Get.back();
                },
              ),
              centerTitle: true,
              title: TextScaleFactorClamper(child: AuthTitleText(text: NameValues.history))),
          body: TextScaleFactorClamper(
            child: GetBuilder<AboutUsController>(builder: (_) {
              return HandlingDataView(
                  statusRequest: aboutUsController.statusRequestBanner,
                  widget: histroyWidget());
            }),
          )),
    );
  }

  histroyWidget() {
    return ListView.builder(
        itemCount: aboutUsController.aboutUsList.length,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
              child: Text(aboutUsController.aboutUsList[index].name!,
                  overflow: TextOverflow.clip,
                  softWrap: true,


                  style: context.theme.textTheme.headlineMedium!.copyWith(
                    // color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
                  ),
                ]),
              SizedBox(height: 1.h),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  SizedBox(
              height: 30.h,
              width: 90.w,
              child: ImageView(
                imageUrl: imageview(
                    aboutUsController.aboutUsList[index].image!),
                showValues: false,
                mainImageViewWidth: 34.w,
                bottomImageViewHeight: 5.h,
              ),
                  ),
                ]),
              SizedBox(height: 1.h),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                child: HtmlView(
                    text: aboutUsController.aboutUsList[index].content!))
                ]),
            ]),
          );
        });
  }
}
