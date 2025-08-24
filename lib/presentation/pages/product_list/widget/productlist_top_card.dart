import 'package:dip_menu/presentation/logic/controller/sub_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:dip_menu/presentation/pages/index.dart';


// ignore: must_be_immutable
class ProductListTopCardScreen extends StatelessWidget {
  String? imageUrl;
  SubCategoryController? controller;


  ProductListTopCardScreen({Key? key,this.imageUrl,this.onBackPressed}) : super(key: key);
  void Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 32.h,
            width: MediaQuery.of(context).size.width / 1,
            child: ClipRRect(
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                        color: mainColor,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(ImageAsset.errorImage,
                      fit: BoxFit.cover);
                },
              ),
            ),
          ),
        ),
        AuthBackButton(
          press: (){
            onBackPressed!();
          },
        ),
        /*Positioned(
          top: 3.h,
          left: 4.w,
          child: GestureDetector(
            onTap: () {
              onBackPressed!();
            },
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.w)),
              child: SizedBox(
                  height: 6.h,
                  width: 12.w,
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 2.w),
                      child: Icon(Icons.arrow_back_ios, size: 6.w))),
            ),
          ),
        ),*/
      ],
    );
  }
}
