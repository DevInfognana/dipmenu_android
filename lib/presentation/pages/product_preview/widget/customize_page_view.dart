import 'package:cached_network_image/cached_network_image.dart';
import 'package:dip_menu/core/config/icon_config.dart';
import 'package:dip_menu/data/model/product_preview/custom_menu_data.dart';

import 'package:dip_menu/presentation/logic/controller/product_preview_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_textstyle.dart';
import '../../../../core/config/theme.dart';

// ignore: must_be_immutable
class TabbarView extends StatefulWidget {
  TabbarView({Key? key, this.controller}) : super(key: key);

  ProductPreviewController? controller;

  @override
  State<TabbarView> createState() => _TabbarViewState();
}

class _TabbarViewState extends State<TabbarView> {
  dynamic customProductlen;
  bool expansionValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: widget.controller!.customMenu.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final customMenu = widget.controller!.customMenu[index];
            // final size = widget.controller!.minMaxShow(customMenu.id);
            return Card(
              color: Colors.white,
              elevation: 4,
              child: ExpansionTile(
                controlAffinity: ListTileControlAffinity.trailing,
                childrenPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                expandedCrossAxisAlignment: CrossAxisAlignment.end,
                iconColor: mainColor,
                title: Text(customMenu.name!,
                    style:
                    TextStore.textTheme.headlineMedium?.copyWith(color: titleColor)),

                onExpansionChanged: (bool value) {
                  setState(() {


                  });
                },
                children: [
                  SizedBox(
                      height: 35.h,
                      child: ListViewCard(
                      ))

                ],
              ),
            );
          },
        )
    );
  }
}



// ignore: must_be_immutable
class ListViewCard extends StatelessWidget {
  ListViewCard({Key? key, this.customMenuItems,this.customProducts}) : super(key: key);
  final numberFormat = NumberFormat("#,##,##.00");
  List<CustomMenuItems>? customMenuItems;
  List<CustomProducts>? customProducts;

  @override
  Widget build(BuildContext context) {

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
      mainAxisSpacing: 28,
      childAspectRatio: 0.68,
      ),
      itemBuilder: (BuildContext context, int index) {
      // final subCustomMenuItems = customMenuItems![index];
      return Card(
        color: Colors.grey.shade100,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w)),
        child: Column(
          children: [
            Container(
              height: 12.h,
              width: 20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.w),
                    topLeft: Radius.circular(4.w)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.w),
                    topLeft: Radius.circular(4.w)),
                child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: 'https://images.unsplash.com/photo-1549611016-3a70d82b5040?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJ1cmdlciUyMHBuZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=2000&q=60',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: mainColor)),
                    errorWidget: (context, url, error) => Image.asset(
                        ImageAsset.errorImage,
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(height: 0.2.h),
            Flexible(
                child: Text('Burger',
                    style: TextStore.textTheme.bodyLarge!
                        .copyWith(color: Colors.black))),

            Text(
                'Price : \$ ${numberFormat.format(double.parse('3.00'))}',
                style: TextStore.textTheme.bodyLarge!
                    .copyWith(color: Colors.black))

          ],
        ),
      );
    },);
    /*View.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        // final subCustomMenuItems = customMenuItems![index];
        return GestureDetector(
          onTap: () {
            // print('----->${subCustomMenuItems.name}');
          },
          child: Card(
            color: Colors.grey.shade100,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.w)),
            child: Column(
              children: [
                Container(
                  height: 12.h,
                  width: 20.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4.w),
                        topLeft: Radius.circular(4.w)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4.w),
                        topLeft: Radius.circular(4.w)),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: 'https://images.unsplash.com/photo-1549611016-3a70d82b5040?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJ1cmdlciUyMHBuZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=2000&q=60',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: mainColor)),
                        errorWidget: (context, url, error) => Image.asset(
                            ImageAsset.errorImage,
                            fit: BoxFit.cover)),
                  ),
                ),
                SizedBox(height: 0.2.h),
                Flexible(
                    child: Text('Burger',
                        style: TextStore.textTheme.bodyLarge!
                            .copyWith(color: Colors.black))),

                     Text(
                    'Price : \$ ${numberFormat.format(double.parse('3.00'))}',
                    style: TextStore.textTheme.bodyLarge!
                        .copyWith(color: Colors.black))

              ],
            ),
          ),
        );
      },
    );*/
  }
}

// class PageViewCustomize extends StatefulWidget {
//   PageViewCustomize(
//       {Key? key, this.customProducts, this.customMenuItems, this.controller})
//       : super(key: key);
//   List<CustomMenuItems>? customMenuItems = [];
//   List<CustomProducts>? customProducts = [];
//   ProductPreviewController? controller;
//
//   @override
//   State<PageViewCustomize> createState() => _PageViewCustomizeState();
// }
//
// class _PageViewCustomizeState extends State<PageViewCustomize> {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         shrinkWrap: true,
//         physics: ScrollPhysics(),
//         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//           maxCrossAxisExtent:
//               widget.customMenuItems!.length % 3 != 0 ? 109 : 145,
//           childAspectRatio: widget.customMenuItems!.length % 3 != 0
//               ? MediaQuery.of(context).size.width /
//                   (MediaQuery.of(context).size.height / 1.15)
//               : MediaQuery.of(context).size.width /
//                   (MediaQuery.of(context).size.height / 1.15),
//           crossAxisSpacing: widget.customMenuItems!.length % 3 != 0 ? 7 : 5,
//           mainAxisSpacing: 0,
//         ),
//         itemCount: widget.customMenuItems!.length,
//         itemBuilder: (BuildContext ctx, index) {
//           final subCustomProductItems = widget.customMenuItems![index];
//           return GestureDetector(
//             onTap: () {
//               // Get.toNamed(Routes.productPreviewScreen,arguments: subCategoryProduct);
//             },
//             child: Card(
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4.w)),
//               child: Column(
//                 children: [
//                   Container(
//                     height:
//                         widget.customMenuItems!.length % 3 != 0 ? 10.h ,
//                     width: 43.w,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(4.w),
//                           topLeft: Radius.circular(4.w)),
//                     ),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(4.w),
//                               topLeft: Radius.circular(4.w)),
//                           child: CachedNetworkImage(
//                               fit: BoxFit.cover,
//                               imageUrl: imageview(subCustomProductItems.image),
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) => Center(
//                                       child: CircularProgressIndicator(
//                                           value: downloadProgress.progress,
//                                           color: mainColor)),
//                               errorWidget: (context, url, error) => Image.asset(
//                                   ImageAsset.errorImage,
//                                   fit: BoxFit.cover)),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 0.2.h),
//                   Flexible(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 0.9.h, left: 0.4.h),
//                       child: Text(
//                         subCustomProductItems.name!,
//                         style: TextStore.textTheme.bodyLarge!
//                             .copyWith(color: Colors.black),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     '0.00',
//                     style: TextStore.textTheme.titleLarge!.copyWith(
//                         color: Colors.black,
//                         height: 1.1,
//                         fontWeight: FontWeight.w900),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//
// }



/*    maxCrossAxisExtent:
              widget.customMenuItems!.length % 3 != 0 ? 109 : 145,
          childAspectRatio: widget.customMenuItems!.length % 3 != 0
              ? MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.15)
              : MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.15),
          crossAxisSpacing: widget.customMenuItems!.length % 3 != 0 ? 7 : 5,
          mainAxisSpacing: 0,*/