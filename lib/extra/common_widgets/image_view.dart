import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../core/config/icon_config.dart';
import '../../core/config/theme.dart';
import '../../domain/provider/http_request.dart';

class ImageView extends StatelessWidget {
  ImageView(
      {Key? key,
      this.imageUrl,
      this.name,
      this.index,
      required this.showValues,
      this.selectedIndex,
      this.mainImageViewWidth,
      this.bottomImageViewHeight})
      : super(key: key);
  String? imageUrl;
  String? name;
  int? index;
  bool showValues = false;
  int? selectedIndex;
  double? mainImageViewWidth;
  double? bottomImageViewHeight;




  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'The Product Image',
      child: Container(
         width: mainImageViewWidth,
        height: bottomImageViewHeight,
        margin: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              showValues == true
                  ? (index == selectedIndex
                      ? BoxShadow(
                          color: mainColor, // Change color of the shadow
                          blurRadius: 5.0,
                          spreadRadius: 3.0)
                      : const BoxShadow())
                  : const BoxShadow()
            ],
            borderRadius: BorderRadius.all(Radius.circular(2.w))),
        child:  ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(2.w)),
          child: CachedNetworkImage(
              fit:BoxFit.fill,
              imageUrl: imageUrl!,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: mainColor)),
              errorWidget: (context, url, error) => Image.asset(ImageAsset.errorImage,
                  fit: BoxFit.fill)),
        ),
      ),
    );

  }
}


String imageview(String ImageUrl){
  return '${BaseAPI.base}/$ImageUrl';
}
