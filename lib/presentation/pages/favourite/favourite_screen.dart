// import 'package:dip_menu/core/config/theme.dart';
import 'package:dip_menu/presentation/pages/favourite/widget/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../extra/common_widgets/empty_widget.dart';
import '../../logic/controller/favourite_controller.dart';

import 'package:lottie/lottie.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> with SingleTickerProviderStateMixin  {
  var tokenValue = (SharedPrefs.instance.getString('token'));

  final favouriteController = Get.find<FavouriteController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.7.h),
          child: AppBar(
            leading: AuthBackButton(
              press: (){
                Get.offAllNamed(Routes.mainScreen,arguments: 0);
              },
            ),
            centerTitle: true,
            title: TextScaleFactorClamper(child: AuthTitleText(text: NameValues.favorite))
          ),
        ),
        body: TextScaleFactorClamper(
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    tokenValue == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(ImageAsset.noResult,
                                  height: 50.h,
                                  width: 12.w,
                                  reverse: true,
                                  fit: BoxFit.fill),
                              SizedBox(height: 5.h),
                              Text(NameValues.nothingFavourite,
                                  textAlign: TextAlign.center,
                                  style: context.theme.textTheme.displaySmall!.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600))
                            ],
                          )
                        : GetBuilder<FavouriteController>(builder: (_) {
                            return HandlingDataView(
                                statusRequest:
                                favouriteController.statusRequestBanner!,
                                widget: favouriteController
                                        .favouriteProductList.isNotEmpty
                                    ? cartCard(
                                    favouriteController: favouriteController)
                                    : emptyWidget(NameValues.nothingFavourite));
                          }),
                    SizedBox(height: 3.h)
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
