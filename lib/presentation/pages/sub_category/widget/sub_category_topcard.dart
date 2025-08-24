// import 'package:cached_network_image/cached_network_image.dart';
import 'package:dip_menu/presentation/logic/controller/sub_category_controller.dart';

import 'package:flutter/material.dart';

import 'package:dip_menu/presentation/pages/index.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';


class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  SubCategoryController? controller;
  String? imageUrl;
  void Function()? onBackPressed;
  String? title;
  int? length;

  //var catLength = 15; //controller.subCategoryList.length;
  var topTittle = 0.0;

  MySliverAppBar(
      {required this.expandedHeight,
      this.imageUrl,
      this.controller,
      this.length,
      this.onBackPressed,
      this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / maxExtent;
    return Stack(fit: StackFit.expand, children: [
      AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: topTittle <= 120 ? 1.00 : 0.0, // progress,
          child: ColoredBox(color: mainColor)),
      AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: 1 - progress,
        child: OctoImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl!),
            // imageUrl: !,

          progressIndicatorBuilder: (context, progress) {
            double? value;
            var expectedBytes = progress?.expectedTotalBytes;
            if (progress != null && expectedBytes != null) {
              value = progress.cumulativeBytesLoaded / expectedBytes;
            }
            return CircularProgressIndicator(value: value,color: mainColor);
          },
          errorBuilder: (context, error, stacktrace) =>  Image.asset(ImageAsset.errorImage, fit: BoxFit.cover),
    //         progressIndicatorBuilder: (context, downloadProgress) {
    // double? value;
    // var expectedBytes = downloadProgress?.expectedTotalBytes;
    // if (progress != null && expectedBytes != null) {
    // value = downloadProgress!.cumulativeBytesLoaded / expectedBytes;
    // }
    // CircularProgressIndicator(
    //             value: value!, color: mainColor);
    // },
    //         errorWidget: (context, url, error) =>
    //             Image.asset(ImageAsset.errorImage, fit: BoxFit.cover)
        ),
      ),
      length! > 4
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
              padding: EdgeInsets.lerp(
                EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                EdgeInsets.only(bottom: 3.w),
                progress,
              ),
              alignment: Alignment.lerp(
                Alignment.bottomLeft,
                Alignment.bottomCenter,
                progress,
              ),
              child: Stack(children: <Widget>[
                Text(title!,
                    style: context.theme.textTheme.displaySmall!.copyWith(
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.black,
                        fontWeight: FontWeight.bold)),
                Text(title!,
                    style: context.theme.textTheme.displaySmall!.copyWith(
                        color: ThemesApp.light.scaffoldBackgroundColor,
                        fontWeight: FontWeight.bold)),
              ]))
          : const SizedBox(height: 0),
      AppBar(
          backgroundColor: Colors.transparent,
          leading: AuthBackButton(
            press: () {
              onBackPressed!();
            },
          ),
          elevation: 0),
    ]);
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
