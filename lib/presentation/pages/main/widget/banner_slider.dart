// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dip_menu/domain/provider/http_request.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/config/theme.dart';
// import '../../../logic/controller/home_controller.dart';
//
// class CarouselSliderExample extends StatefulWidget {
//   final HomeController controller;
//
//   const CarouselSliderExample({super.key, required this.controller});
//
//   @override
//   State<CarouselSliderExample> createState() => _CarouselSliderExampleState();
// }
//
// class _CarouselSliderExampleState extends State<CarouselSliderExample> {
//   int currentPos1 = 0;
//   final CarouselController carouselController = CarouselController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         widget.controller.bannerImages.isNotEmpty
//             ? Stack(
//                 children: [
//                   CarouselSlider.builder(
//                     itemCount: widget.controller.bannerImages.length,
//                     options: CarouselOptions(
//                         height: 30.h,
//                         viewportFraction: 1.0,
//                         enlargeCenterPage: false,
//                         autoPlay: true,
//                         autoPlayInterval: const Duration(seconds: 6),
//                         reverse: false,
//                         onPageChanged: (index, reason) {
//                           setState(() {
//                             widget.controller.currentPos = index;
//                           });
//                         },
//                         aspectRatio: 5.0,
//                         initialPage: 0),
//                     itemBuilder: (context, i, id) {
//                       return CachedNetworkImage(
//                         width: double.infinity,
//                         fit: BoxFit.fill,
//                         imageUrl:
//                             '${BaseAPI.base}/${widget.controller.bannerImages[i]}',
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) => Center(
//                                 child: CircularProgressIndicator(
//                           value: downloadProgress.progress,
//                           color: mainColor,
//                         )),
//                         errorWidget: (context, url, error) => const Icon(
//                           Icons.error,
//                           size: 100,
//                           color: Colors.red,
//                         ),
//                       );
//                     },
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     left: 0,
//                     right: 0,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: widget.controller.bannerImages
//                           .asMap()
//                           .entries
//                           .map((entry) {
//                         return GestureDetector(
//                           onTap: () =>
//                               carouselController.animateToPage(entry.key),
//                           child: Container(
//                             width: 8.0,
//                             height: 8.0,
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 10.0, horizontal: 2.0),
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: widget.controller.currentPos == entry.key
//                                     ? mainColor
//                                     : Colors.white),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ],
//               )
//             :Stack(
//           children: [
//             CarouselSlider.builder(
//               itemCount: widget.controller.emptyBannerImages.length,
//               options: CarouselOptions(
//                   height: 33.h,
//                   viewportFraction: 1.0,
//                   enlargeCenterPage: false,
//                   autoPlay: true,
//                   autoPlayInterval: const Duration(seconds: 6),
//                   reverse: false,
//                   onPageChanged: (index, reason) {
//                     setState(() {
//                       widget.controller.currentPos = index;
//                     });
//                   },
//                   aspectRatio: 5.0,
//                   initialPage: 0),
//               itemBuilder: (context, i, id) {
//                 return CachedNetworkImage(
//                   width: double.infinity,
//                   fit: BoxFit.fill,
//                   imageUrl:
//                   widget.controller.emptyBannerImages[i],
//                   progressIndicatorBuilder:
//                       (context, url, downloadProgress) => Center(
//                       child: CircularProgressIndicator(
//                         value: downloadProgress.progress,
//                         color: mainColor,
//                       )),
//                   errorWidget: (context, url, error) => const Icon(
//                     Icons.error,
//                     size: 100,
//                     color: Colors.red,
//                   ),
//                 );
//               },
//             ),
//             Positioned(
//               bottom: 10,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: widget.controller.emptyBannerImages
//                     .asMap()
//                     .entries
//                     .map((entry) {
//                   return GestureDetector(
//                     onTap: () =>
//                         carouselController.animateToPage(entry.key),
//                     child: Container(
//                       width: 8.0,
//                       height: 8.0,
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 10.0, horizontal: 2.0),
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: widget.controller.currentPos == entry.key
//                               ? mainColor
//                               : Colors.white),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ) ,
//         /* widget.controller.bannerImages.isNotEmpty
//             ? Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: widget.controller.bannerImages.map((url) {
//                   int index = widget.controller.bannerImages.indexOf(url);
//                   return Container(
//                     width: 8.0,
//                     height: 8.0,
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: widget.controller.currentPos == index
//                           ? const Color.fromRGBO(0, 0, 0, 0.9)
//                           : const Color.fromRGBO(0, 0, 0, 0.4),
//                     ),
//                   );
//                 }).toList(),
//               )
//             : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: widget.controller.emptyBannerImages.map((url) {
//                   int index = widget.controller.emptyBannerImages.indexOf(url);
//                   return Container(
//                     width: 8.0,
//                     height: 8.0,
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 10.0, horizontal: 2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: currentPos1 == index
//                           ? const Color.fromRGBO(0, 0, 0, 0.9)
//                           : const Color.fromRGBO(0, 0, 0, 0.4),
//                     ),
//                   );
//                 }).toList(),
//               ),*/
//       ],
//     );
//   }
// }
