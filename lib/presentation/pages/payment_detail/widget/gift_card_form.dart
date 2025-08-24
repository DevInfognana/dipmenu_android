// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../../../core/config/app_textstyle.dart';
// import '../../../../core/config/theme.dart';
// import '../../../../core/static/stactic_values.dart';
// import '../../../logic/controller/payment_detail_controller.dart';
//
// class GiftCard extends StatefulWidget {
//   GiftCard(
//       {Key? key,
//       required this.controller
//       // required this.onApplyButtonPressed,
//       // required this.onRemoveButtonPressed
//   })
//       : super(key: key);
//
//   PaymentDetailController controller;
//   // void Function(dynamic) onApplyButtonPressed;
//   // void Function(dynamic) onRemoveButtonPressed;
//
//   @override
//   State<GiftCard> createState() => _GiftCardState();
// }
//
// class _GiftCardState extends State<GiftCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: widget.controller.applyCodeFormKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 2.w),
//             child: SizedBox(
//               width: 35.w,
//               height: 8.h,
//               child: TextFormField(
//                 controller: widget.controller.applyGiftCardController,
//                 cursorColor: mainColor,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.done,
//                 style: TextStyle(
//                     color: Theme.of(context).textTheme.displayLarge!.color),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Enter the Gift Card';
//                   } else {
//                     return null;
//                   }
//                 },
//                 decoration: InputDecoration(
//                   contentPadding:
//                       const EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
//                   fillColor: Theme.of(context).cardColor,
//                   filled: true,
//                   hintText: 'Ex: GC-0000',
//                   hintStyle: const TextStyle(color: Colors.grey),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: borderColor),
//                       borderRadius: BorderRadius.circular(10)),
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: mainColor),
//                       borderRadius: BorderRadius.circular(10)),
//                   errorBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           color: authTextFromFieldErrorBorderColor
//                               .withOpacity(.5)),
//                       borderRadius: BorderRadius.circular(10)),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: borderColor),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 2.h),
//             child: widget.controller.discountValue.value == 0.0
//                 ? ElevatedButton(
//                     onPressed: () {
//                       if (widget.controller.applyCodeFormKey.currentState!
//                           .validate()) {}
//                       widget.controller.giftCard();
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: EdgeInsets.symmetric(
//                             vertical: 1.h, horizontal: 2.w)),
//                     child: Text(
//                       NameValues.apply,
//                       style: TextStore.textTheme.titleLarge!
//                           .copyWith(color: Colors.white),
//                     ))
//                 : ElevatedButton(
//                     onPressed: () {
//                       widget.controller.applyGiftCardController.clear();
//                       widget.controller.removeGiftCardValues();
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: EdgeInsets.symmetric(
//                             vertical: 1.h, horizontal: 2.w)),
//                     child: Text(
//                       NameValues.remove,
//                       style: TextStore.textTheme.titleLarge!
//                           .copyWith(color: Colors.white),
//                     )),
//           )
//         ],
//       ),
//     );
//   }
// }
