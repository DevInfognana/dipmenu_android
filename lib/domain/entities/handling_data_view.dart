// import 'package:dip_menu/domain/entities/status_reques.dart';
import 'package:dip_menu/presentation/pages/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../core/config/theme.dart';
// import '../../core/static/stactic_values.dart';
import '../../presentation/logic/controller/controller_Index.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? containerView(context: context, errorValues: "Loading")
        : statusRequest == StatusRequest.offlinefailure
            ? containerView(context: context, errorValues: "Offline Failure")
            : statusRequest == StatusRequest.serverfailure
                ? containerView(context: context, errorValues: "Server Failure")
                : statusRequest == StatusRequest.failure
                    ? containerView(context: context, errorValues: "No Data")
                    : statusRequest == StatusRequest.pleaseCheckAfterSomeTime
                        ? containerView(
                            context: context, errorValues: "No Data",values: 1)
                        : widget;
  }

  Widget containerView({required BuildContext context, String? errorValues, int values=0}) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

        errorValues == "Loading"
        ? CircularProgressIndicator(color: mainColor)
          : Text(
      errorValues!,
      style: Get.context?.theme.textTheme.headlineMedium
          ?.copyWith(fontWeight: FontWeight.bold),),

            SizedBox(height: 5.h,),
            values==1?
            ElevatedButton(
              onPressed: () {
                SharedPrefs.instance.setInt('bottomBar', 0);
                Get.offAllNamed(Routes.mainScreen, arguments: 0);
                // controller.getConnectivityType();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                // primary: mainColor,
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                textStyle: context.theme.textTheme.headlineMedium!
                    .copyWith(color: Colors.black),
              ),
              child: Text(NameValues.backToHome),
            ): const SizedBox(),

          ],
        ));
  }
}
