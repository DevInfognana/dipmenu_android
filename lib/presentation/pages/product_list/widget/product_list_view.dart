
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import '../../../logic/controller/sub_category_controller.dart';
// import 'package:dip_menu/presentation/pages/index.dart';


// class productList extends StatelessWidget {
//   final SubCategoryController controller;
//
//   productList({super.key, required this.controller});
//   final numberFormat =  NumberFormat("#,##,##.00");
//
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//         child: ListView.builder(
//             itemCount: controller.subCategoryProductList.length,
//             scrollDirection: Axis.vertical,
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (BuildContext context, int index) {
//               final subCategoryProduct = controller.subCategoryProductList[index];
//               final productprice=itemPriceId(subCategoryProduct.defaultSize!,subCategoryProduct.price);
//               return GestureDetector(
//                 onTap: (){
//                   Get.toNamed(Routes.productPreviewScreen,arguments: subCategoryProduct);//, arguments: data);
//                 },
//                 child: Card(
//                   elevation: 5.0,
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(3.w)),
//                   child: Container(
//                     margin: EdgeInsets.all(1.w),
//                     alignment: Alignment.centerLeft,
//                     child: Column(
//                       children: [
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Flexible(
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(controller.subCategoryProductList[index].name!,
//                                               style: context.theme.textTheme.headlineMedium!.copyWith(
//                                                   color: Colors.black, overflow: TextOverflow.clip,
//                                                   fontWeight: FontWeight.bold)),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 1.h),
//                                     Row(
//                                       children: [
//                                         Text('\$ ${numberFormat.format(
//                                             double.parse(productprice.toString()))}',
//                                             style: TextStore.textTheme.headlineMedium!.copyWith(
//                                                 color: mainColor,
//
//                                                 fontWeight: FontWeight.bold)),
//                                       ],
//                                     ),
//                                     SizedBox(height: 1.h),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Text(controller.subCategoryProductList[index].description!, //controller.subCategoryProductList[index].name!,
//                                               style: TextStore.textTheme.headlineMedium!.copyWith(
//                                                   color: Colors.black),
//                                           overflow: TextOverflow.ellipsis),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 3.w),
//                             SizedBox(
//                               height: 15.h,
//                               width: 30.w,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(4.w),
//                                 child: ImageView(
//                                   imageUrl: imageview(controller.subCategoryProductList[index].image!),
//                                   showValues: false,
//                                   mainImageViewWidth:34.w,
//                                   bottomImageViewHeight: 5.h,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             })
//
//     );
//
//     /*return Flexible(
//       child: GridView.builder(
//           shrinkWrap: true,
//           physics: ScrollPhysics(),
//           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 200,
//             childAspectRatio: MediaQuery.of(context).size.width /
//                 (MediaQuery.of(context).size.height / 1.4),
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 0,
//           ),
//           itemCount: controller.subCategoryProductList.length,
//           itemBuilder: (BuildContext ctx, index) {
//             final subCategoryProduct = controller.subCategoryProductList[index];
//             final productprice=itemPriceId(subCategoryProduct.defaultSize!,subCategoryProduct.price);
//             return GestureDetector(
//               onTap: (){
//                 Get.toNamed(Routes.productPreviewScreen,arguments: subCategoryProduct);
//               },
//               child: Card(
//                 elevation: 5.0,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(4.w)),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 21.5.h,
//                       width: 43.w,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(4.w),
//                             topLeft: Radius.circular(4.w)),
//                       ),
//                       child: Stack(
//                         fit: StackFit.expand,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.only(
//                                 topRight: Radius.circular(4.w),
//                                 topLeft: Radius.circular(4.w)),
//                             child: Image.network(
//                               imageview(controller.subCategoryProductList[index].image),
//                               fit: BoxFit.cover,
//                               loadingBuilder: (BuildContext context, Widget child,
//                                   ImageChunkEvent? loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Center(
//                                   child: CircularProgressIndicator(
//                                     color: mainColor,
//                                     value: loadingProgress.expectedTotalBytes !=
//                                             null
//                                         ? loadingProgress.cumulativeBytesLoaded /
//                                             loadingProgress.expectedTotalBytes!
//                                         : null,
//                                   ),
//                                 );
//                               },
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(ImageAsset.errorImage,
//                                     fit: BoxFit.cover);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 0.2.h),
//                     Flexible(
//                       child: Padding(
//                         padding: EdgeInsets.all(0.8.h),
//                         child: Text(
//                           controller.subCategoryProductList[index].name!,
//                           style: TextStore.textTheme.titleLarge!.copyWith(
//                               color: Colors.black,
//                               height: 1.1,
//                               fontWeight: FontWeight.w900),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 0.2.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Spacer(flex: 1),
//                         Text('\$ ${numberFormat.format(double.parse(productprice))}',
//                           style: TextStore.textTheme.titleLarge!.copyWith(
//                               color: Colors.black,
//                               height: 1.1,
//                               fontWeight: FontWeight.w900)),
//                         const Spacer(flex: 3),
//                         Icon(Icons.shopping_bag_outlined, color: mainColor),
//                         const Spacer(flex: 1),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );*/
//   }
//
//
//
//
// }
