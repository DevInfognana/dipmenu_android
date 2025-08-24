import 'package:dip_menu/presentation/logic/controller/recent_order_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../data/model/recent_order_model.dart';
import '../../../extra/common_widgets/bottom_navigation.dart';
import '../../logic/controller/main_controller.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:dip_menu/presentation/pages/index.dart';


class RecentOrderScreen extends StatefulWidget {
  const RecentOrderScreen({Key? key}) : super(key: key);

  @override
  State<RecentOrderScreen> createState() => RecentOrderScreenState();
}

class RecentOrderScreenState extends State<RecentOrderScreen> {
  final recentOrderController = Get.find<RecentOrderController>();
  final numberFormat = NumberFormat("#,##0.00", "en_US");

  final homeController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(onWillPop: () async {
        setState(() {
          if (homeController.selectedIndex == 3) {
            homeController.outValue = false;
            homeController.selectedIndex = 0;
            Get.offAllNamed(Routes.mainScreen, arguments: 0);
          } else if (homeController.selectedIndex == 2) {
            homeController.outValue = false;
            homeController.selectedIndex = 0;
            Get.offAllNamed(Routes.mainScreen, arguments: 0);
          } else if (homeController.selectedIndex == 1) {
            homeController.outValue = false;
            homeController.selectedIndex = 0;
            Get.offAllNamed(Routes.mainScreen, arguments: 0);
          } else if (homeController.selectedIndex == 0) {
            homeController.outValue = true;
          }
        });
        return homeController.outValue;
      }, child: GetBuilder<RecentOrderController>(builder: (controller) {
        return controller.status.isEmpty
            ? Scaffold(
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(ImageAsset.emptyResult,
                        height: 40.h,
                        width: 12.w,
                        reverse: true,
                        fit: BoxFit.fill),
                    SizedBox(height: 5.h),
                    Text(NameValues.youHaveNoOrders,
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.displaySmall!.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.w600))
                  ],
                ),
            )
            : controller.status.isError
                ? Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    alignment: Alignment.center,
                    child:
                        Text('Api error - ${controller.status.errorMessage}'))
                : controller.status.isLoading
                    ? Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(color: mainColor))
                    : Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(10.h),
                          child: AppBar(
                              leading: AuthBackButton(
                                press: () {
                                  Get.back(); //Get.offAllNamed(Routes.mainScreen,arguments: 0);
                                },
                              ),
                              centerTitle: true,
                              title: TextScaleFactorClamper(
                                  child: AuthTitleText(
                                      text: NameValues.myOrders))),
                        ),
                        body: TextScaleFactorClamper(
                            child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.all(1.h),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Flexible(
                                            child: Container(
                                          padding: EdgeInsets.all(0.2.h),
                                          child: ListView.builder(
                                              itemCount: recentOrderController
                                                  .recentOrderData!
                                                  .data!
                                                  .length,
                                              scrollDirection: Axis.vertical,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                    onTap: () {
                                                      try {
                                                        Get.toNamed(
                                                            Routes
                                                                .recentOrderDetailScreen,
                                                            arguments:
                                                                recentOrderController
                                                                    .recentOrderData!
                                                                    .data![
                                                                        index]
                                                                    .id);
                                                      } catch (e) {
                                                        if (kDebugMode) {
                                                          print(e);
                                                        }
                                                      }
                                                    },
                                                    child: Card(
                                                        elevation: 0,
                                                        color: Theme.of(
                                                                Get.context!)
                                                            .scaffoldBackgroundColor,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0.4.h,
                                                                    top: 0.8.w,
                                                                    bottom:
                                                                        0.8.w,
                                                                    right:
                                                                        0.4.h),
                                                            child:
                                                                TextScaleFactorClamper(
                                                                    child:
                                                                        OrderingView(
                                                              values: recentOrderController
                                                                  .recentOrderData!
                                                                  .data![index],
                                                            )))));
                                              }),
                                        )),
                                      ]),
                                ))),
                        bottomNavigationBar: BottomNavigation(
                          elevation: 0,
                            onTap: homeController.onItemTapped1,
                            index: homeController.selectedIndex),
                        floatingActionButton: FloatingButton(
                          totalValues: homeController.totalCount.toString(),
                        ),
                        resizeToAvoidBottomInset: false,
                        floatingActionButtonLocation:
                            FloatingActionButtonLocation.endDocked,
                      );
      })),
    );
  }
}

// ignore: must_be_immutable
class OrderingView extends StatelessWidget {
  OrderingView({Key? key, this.values}) : super(key: key);

  RecentOrderValue? values;

  String? formatCstTime = SharedPrefs.instance.getString('timeZone');

  @override
  Widget build(BuildContext context) {
    String? dateValues = values?.createdAt;
    DateTime utcDateTime = DateTime.parse(dateValues!).toUtc();
    tz.Location cstLocation = tz.getLocation('America/Chicago');
    tz.TZDateTime cstDateTime = tz.TZDateTime.from(utcDateTime, cstLocation);
    String formattedCSTDateTime =
        DateFormat('MM-dd-yyyy').format(cstDateTime.toLocal());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textView(
              labelText: 'Order ID : ',
              valuesText: '# ${values?.orderNumber!}',
              colorValues1: mainColor,
              context: context),
          textView(
              labelText: 'Transaction ID : ',
              valuesText: values?.transactionid == '0'
                  ? 'Gift Card/Reward Purchase'
                  : values?.transactionid,
              colorValues1: mainColor,
              context: context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textView(
                          labelText: 'Item Count : ',
                          valuesText: values?.orderDetails?.length.toString(),
                          colorValues1: mainColor,
                          context: context),
                      textView(
                          labelText: 'Total : ',
                          valuesText:values?.transactionid == '0'? values?.orderTotal:"\$ ${values?.orderTotal}",
                          colorValues1: mainColor,
                          context: context),
                      textView(
                          labelText: 'Date : ',
                          valuesText: formattedCSTDateTime,
                          colorValues1: mainColor,
                          context: context),
                    ]),
              ),
              SizedBox(width: 1.w),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.recentOrderDetailScreen,
                        arguments: values?.id);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.w)),
                      padding: EdgeInsets.symmetric(
                          vertical: 1.2.h, horizontal: 6.w)),
                  child: Text('View Order',
                      style: context.theme.textTheme.headlineMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal))),
            ],
          ),
          textView(
              labelText: 'Order Status : ',
              valuesText: orderStatusValues(values?.orderStatus),
              colorValues1: mainColor,
              context: context),
          textView(
              labelText: 'Mode : ',
              valuesText: orderModeValues(values!.orderMode!),
              colorValues1: mainColor,
              context: context),
          DividerView(),
        ]);
  }

  Widget textView(
      {String? labelText,
      String? valuesText,
      Color? colorValues1,
      BuildContext? context}) {
    Color colorValues = Get.isDarkMode ? Colors.white : borderColor;
    return Text.rich(
      textAlign: TextAlign.justify,
      TextSpan(children: [
        TextSpan(
            text: labelText!,
            style: context?.theme.textTheme.headlineSmall
                ?.copyWith(color: colorValues, fontWeight: FontWeight.bold)),
        TextSpan(
            text: valuesText!,
            style: context?.theme.textTheme.headlineSmall
                ?.copyWith(color: colorValues1, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  orderModeValues(String orderModeValues) {
    return orderModeValues == '1'
        ? 'Drive-Thru'
        : orderModeValues == '2'
            ? 'Schedule Pickup'
            : 'Pick Up';
  }

  orderStatusValues(int? values) {
    return values == 0
        ? ' Initiated'
        : values == 1
            ? ' Confirmed'
            : values == 2
                ? ' Refund'
                : values == 3
                    ? ' Payment Failed'
                    : values == 4
                        ? ' CheckIn Pending'
                        : values == 5
                            ? ' Delivered'
                            : '';
  }
}
