// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../logic/controller/sub_category_controller.dart';
// import 'package:dip_menu/presentation/pages/index.dart';


// ignore: camel_case_types
// class productList extends StatelessWidget {
//   final SubCategoryController controller;
//
//   productList({super.key, required this.controller});
//   final numberFormat =  NumberFormat("#,##,##.00");
//
//   @override
//   Widget build(BuildContext context) {
//
//     return TextScaleFactorClamper(
//       child: Flexible(
//         child: GridView.builder(
//             shrinkWrap: true,
//             physics: const ScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 200,
//               childAspectRatio: MediaQuery.of(context).size.width /
//                   (MediaQuery.of(context).size.height / 1.4),
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 0,
//             ),
//             itemCount: controller.subCategoryProductList.length,
//             itemBuilder: (BuildContext ctx, index) {
//               final subCategoryProduct = controller.subCategoryProductList[index];
//               final productprice=itemPriceId(subCategoryProduct.defaultSize!,subCategoryProduct.price);
//               return GestureDetector(
//                 onTap: (){
//                   Get.toNamed(Routes.productPreviewScreen,arguments: subCategoryProduct);
//                 },
//                 child: Card(
//                   elevation: 5.0,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(4.w)),
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 21.5.h,
//                         width: 43.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topRight: Radius.circular(4.w),
//                               topLeft: Radius.circular(4.w)),
//                         ),
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(4.w),
//                                   topLeft: Radius.circular(4.w)),
//                               child: CachedNetworkImage(
//                                   imageUrl: imageview(controller.subCategoryProductList[index].image!),
//                                   fit: BoxFit.cover,
//                                   progressIndicatorBuilder: (context, url, downloadProgress) =>
//                                       Center(
//                                           child: CircularProgressIndicator(
//                                               value: downloadProgress.progress,
//                                               color: mainColor)),
//                                   errorWidget: (context, url, error) => Image.asset(ImageAsset.errorImage,
//                                       fit: BoxFit.cover)),
//                               // child: Image.network(
//                               //   imageview(controller.subCategoryProductList[index].image),
//                               //   fit: BoxFit.cover,
//                               //   loadingBuilder: (BuildContext context, Widget child,
//                               //       ImageChunkEvent? loadingProgress) {
//                               //     if (loadingProgress == null) return child;
//                               //     return Center(
//                               //       child: CircularProgressIndicator(
//                               //         color: mainColor,
//                               //         value: loadingProgress.expectedTotalBytes !=
//                               //                 null
//                               //             ? loadingProgress.cumulativeBytesLoaded /
//                               //                 loadingProgress.expectedTotalBytes!
//                               //             : null,
//                               //       ),
//                               //     );
//                               //   },
//                               //   errorBuilder: (context, error, stackTrace) {
//                               //     return Image.asset(ImageAsset.errorImage,
//                               //         fit: BoxFit.cover);
//                               //   },
//                               // ),
//                             ),
//                             // Align(
//                             //   alignment: Alignment.topRight,
//                             //   child: Padding(
//                             //     padding: EdgeInsets.only(right: 1.h, top: 1.h),
//                             //     child: Card(
//                             //       color: Colors.grey,
//                             //       shape: RoundedRectangleBorder(
//                             //           borderRadius: BorderRadius.circular(2.w)),
//                             //       child: SizedBox(
//                             //           height: 4.h,
//                             //           width: 8.w,
//                             //           child: controller.onChange == true? const Icon(Icons.favorite_outline,
//                             //               color: Colors.white):const Icon(Icons.favorite,
//                             //               color: Colors.red)),
//                             //     ),
//                             //   ),
//                             // )
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 0.2.h),
//                       Flexible(
//                         child: Padding(
//                           padding: EdgeInsets.all(0.8.h),
//                           child: Text(
//                             controller.subCategoryProductList[index].name!,
//                             style: TextStore.textTheme.titleLarge!.copyWith(
//                                 color: Colors.black,
//                                 height: 1.1,
//                                 fontWeight: FontWeight.w900),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 0.2.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           const Spacer(flex: 1),
//                           Text('\$ ${numberFormat.format(double.parse(productprice))}',
//                             style: TextStore.textTheme.titleLarge!.copyWith(
//                                 color: Colors.black,
//                                 height: 1.1,
//                                 fontWeight: FontWeight.w900)),
//                           const Spacer(flex: 3),
//                           Icon(Icons.shopping_bag_outlined, color: mainColor),
//                           const Spacer(flex: 1),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }),
//       ),
//     );
//   }
//
//
//
//
// }
