// import 'package:dip_menu/core/config/app_textstyle.dart';
// import 'package:dip_menu/presentation/routes/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import '../../../../core/config/theme.dart';
// import '../../../../extra/common_widgets/image_view.dart';
// import '../../../logic/controller/home_controller.dart';

// class CategoriesList extends StatelessWidget {
//   final HomeController controller;
//
//   const CategoriesList({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     return /*SizedBox(
//       height: 43.h,
//       //height: double.infinity,
//       width: double.infinity,
//       child: ListView.builder(
//           itemCount: controller.homeCategoryList.length,
//           shrinkWrap: true,
//           physics: const ScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () {
//                 var data = {
//                   'id': controller.homeCategoryList[index].id,
//                   'name': controller.homeCategoryList[index].name
//                 };
//                 Get.toNamed(Routes.subCategoryScreen, arguments: data);
//               },
//               child: ImageView(
//                 // imageUrl:  '${BaseAPI.base}/${controller.homeCategoryList[index].image}',
//                 imageUrl: imageview(controller.homeCategoryList[index].image),
//                 showValues: false,
//                 name: controller.homeCategoryList[index].name!,
//                 mainImageViewWidth:34.w,
//                 bottomImageViewHeight: 5.h,
//
//               ),
//             );
//           }),
//     );*/
//         Flexible(
//             child: ListView.builder(
//                 itemCount: controller.homeCategoryList.length,
//                 scrollDirection: Axis.vertical,
//                 physics: const ScrollPhysics(),
//                 shrinkWrap: true,
//                 padding: EdgeInsets.all(1.w),
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       var data = {
//                         'id': controller.homeCategoryList[index].id,
//                         'name': controller.homeCategoryList[index].name,
//                         'image': controller.homeCategoryList[index].image
//                       };
//                       Get.toNamed(Routes.subCategoryScreen, arguments: data);
//                     },
//                     child: Card(
//                       elevation: 0,
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.all(1.w),
//                             alignment: Alignment.centerLeft,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Flexible(
//                                   child: Container(
//                                     padding: const EdgeInsets.all(10),
//                                     child: Text(
//                                         controller.homeCategoryList[index].name!,
//                                         style: TextStore.textTheme.headlineMedium!
//                                             .copyWith(
//                                                 color: Colors.black,
//                                                 fontWeight: FontWeight.bold)),
//                                   ),
//                                 ),
//                                 SizedBox(width: 3.w),
//                                 SizedBox(
//                                   height: 15.h,
//                                   width: 30.w,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(4.w),
//                                     child: ImageView(
//                                       imageUrl: imageview(controller
//                                           .homeCategoryList[index].image!),
//                                       showValues: false,
//                                       mainImageViewWidth: 34.w,
//                                       bottomImageViewHeight: 5.h,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 2.h, right: 2.h),
//                             child: const Divider(
//                               color: tileColor,
//                               thickness: 2.0,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }));
//   }
// }
