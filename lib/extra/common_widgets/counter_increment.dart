import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/config/app_textstyle.dart';

class CounterButton extends StatelessWidget {
  final Function() onIncrementSelected;
  final Function() onDecrementSelected;
  final Widget label;
  final Axis orientation;
  final Size size;
  final double padding;

  const CounterButton(
      {Key? key,
      required this.onIncrementSelected,
      required this.onDecrementSelected,
      required this.label,
      this.padding = 10.0,
      this.size = const Size(36, 36),
      this.orientation = Axis.horizontal})
      : super(key: key);

  Widget button(Icon icon, Function() onTap) {
    return RawMaterialButton(
        constraints: BoxConstraints.tight(getDeviceType() =='phone'?Size(8.w, 4.5.h):Size(10.w, 5.h)),
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(5)),
        fillColor: Colors.white,
        onPressed: () => onTap(),
        child: icon);
  }

  List<Widget> body() {
    return [
      button(
          const Icon(Icons.remove, color: Colors.black), onDecrementSelected),
      SizedBox(height: 2.w),
      Padding(padding: EdgeInsets.symmetric(horizontal: padding), child: label),
      SizedBox(height: 2.w),
      button(const Icon(Icons.add, color: Colors.black), onIncrementSelected)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return orientation == Axis.horizontal
        ? Row(mainAxisAlignment: MainAxisAlignment.end, children: body())
        : Column(children: body().reversed.toList());
  }
   String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }
}



Widget addButton(
    {required int quanity,
    final Function()? onDecrementSelected,
    final Function()? onIncrementSelected}) {
  return Row(
    children: [
      InkWell(
          onTap: () {
            if (0 > 1) {
              onDecrementSelected!();
            }
          },
          child: Container(
              padding: EdgeInsets.all(0.6.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), //color: mainColor,
                  border: Border.all(width: 1, color: Colors.grey.shade500)),
              child: Icon(Icons.remove, color: Colors.black, size: 2.h))),
      Container(
          width: 14.w,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.6.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3), color: Colors.white),
          child: Center(
            child: Text('$quanity',
                style: TextStore.textTheme.displaySmall!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          )),
      InkWell(
          onTap: () {
            onIncrementSelected!();
          },
          child: Container(
              padding: EdgeInsets.all(0.6.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), //color: mainColor,
                  border: Border.all(width: 1, color: Colors.grey.shade500)),
              child: Icon(Icons.add, color: Colors.black, size: 2.h))),
    ],
  );
}
