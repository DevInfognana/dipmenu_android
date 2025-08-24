//
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/config/app_textstyle.dart';
// import '../../../../core/config/theme.dart';
// import '../../../../core/static/stactic_values.dart';
//
// class PopularList extends StatelessWidget {
//   const PopularList({super.key,
//     this.margin
//   });
//
//   final double? margin;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Flexible(
//       child: ListView.builder(
//           itemCount: popularCategoriesList.length,
//           scrollDirection: Axis.vertical,
//           physics: const ScrollPhysics(),
//           shrinkWrap: true,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               elevation: 3.0,
//               color: Colors.white70,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(3.w)),
//               child: Container(
//                 margin: EdgeInsets.all(1.w),
//                 alignment: Alignment.centerLeft,
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 21.h,
//                           width: 26.w,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(4.w),
//                             child: Image.network(
//                               'https://dipmenu-api-dev.demomywebapp.com/category_images/1673865958676_burger2.jpg',
//                               fit: BoxFit.fill,
//                               loadingBuilder: (BuildContext context,
//                                   Widget child,
//                                   ImageChunkEvent? loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Center(
//                                   child: CircularProgressIndicator(
//                                     color: mainColor,
//                                     value: loadingProgress.expectedTotalBytes !=
//                                         null
//                                         ? loadingProgress
//                                         .cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes!
//                                         : null,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 3.w),
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                             /*  Wrap(
//                                 direction: Axis.horizontal,
//                                 children: [
//                                 Icon(Icons.workspace_premium,color: mainColor,size: 25,),
//                                 Text('Best Seller of the Week',
//                                     style: TextStore.textTheme.titleLarge!
//                                         .copyWith(
//                                         color: mainColor,
//                                         fontWeight: FontWeight.bold)),
//                               ],),*/
//                               SizedBox(height: 1.h),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Flexible(
//                                     child: Column(
//                                         children: [
//                                           Text('Chicken Fried Hamburger',
//                                               style: TextStore.textTheme.headlineMedium!
//                                                   .copyWith(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold)),
//                                         ]
//                           ),
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {},
//                                     style: ElevatedButton.styleFrom(
//                                       fixedSize: Size(19.w, 3.h),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(6.w)),
//                                         backgroundColor: mainColor,
//                                         textStyle: const TextStyle(fontSize: 10)),
//                                     child: const Text('ADD'),
//                                   ),
//                               ],),
//
//                               SizedBox(height: 1.h),
//                               Text(
//                                   'Lorem ipsum, or lipsum as it is sometimes,Lorem ipsum, or lipsum as it is sometimes,',
//                                   style: TextStore.textTheme.bodyLarge!
//                                       .copyWith(
//                                       color: descriptionColor,
//                                       fontWeight: FontWeight.w900)),
//
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

