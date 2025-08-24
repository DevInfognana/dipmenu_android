// import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
// import 'package:dip_menu/presentation/logic/controller/main_controller.dart';
// import 'package:flutter/material.dart';
//
//
// class BottomNavigation extends StatefulWidget {
//
//
//   const BottomNavigation({super.key});
//
//   @override
//   State<BottomNavigation> createState() => _bottomNavigationState();
// }
//
// class _bottomNavigationState extends State<BottomNavigation> {
//
//    MainController? controller;
//   @override
//   Widget build(BuildContext context) {
//     return CircularBottomNavigation(
//       controller!.tabItems,
//       controller: controller!.navigationController,
//       selectedPos: controller!.tabindex,
//       barHeight: 60,
//       // use either barBackgroundColor or barBackgroundGradient to have a gradient on bar background
//       barBackgroundColor: Colors.white,
//       // barBackgroundGradient: LinearGradient(
//       //   begin: Alignment.bottomCenter,
//       //   end: Alignment.topCenter,
//       //   colors: [
//       //     Colors.blue,
//       //     Colors.red,
//       //   ],
//       // ),
//       backgroundBoxShadow: <BoxShadow>[
//         BoxShadow(color: Colors.black45, blurRadius: 10.0),
//       ],
//       animationDuration: Duration(milliseconds: 300),
//       selectedCallback: (int? selectedPos) {
//         setState(() {
//           this.controller!.tabindex = selectedPos ?? 0;
//         });
//       },
//     );
//   }
// }
