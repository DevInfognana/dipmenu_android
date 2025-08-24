import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class ProfileListValues extends StatefulWidget {
  ProfileListValues({Key? key, required this.onChanged, this.title, this.icon})
      : super(key: key);

  final Function() onChanged;
  String? title;
  IconData? icon;

  @override
  State<ProfileListValues> createState() => _ProfileListValuesState();
}

class _ProfileListValuesState extends State<ProfileListValues> {
  @override
  Widget build(BuildContext context) {
    Color? color =Get.isDarkMode?Colors.white: borderColor;
    return ListTile(
      contentPadding: EdgeInsets.only(left: 1.w, right: 5.w),
      onTap: () {
        widget.onChanged();
      },
      leading: FittedBox(
        fit: BoxFit.fill,
        child: Icon(widget.icon, color: color, size: 16.sp),
      ),
      title: Text(widget.title!,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color, fontWeight: FontWeight.w400),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 3.5.w,
        color: color,
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileExpanisonValues extends StatefulWidget {
  ProfileExpanisonValues(
      {Key? key, required this.onCreateGiftChanged,required this.onPurchasedHistoryChanged,required this.onTransactionsHistoryChanged, this.title,this.title1, this.title2,this.title3,this.icon})
      : super(key: key);

  final Function() onCreateGiftChanged;
  final Function() onPurchasedHistoryChanged;
  final Function() onTransactionsHistoryChanged;
  String? title;
  String? title1;
  String? title2;
  String? title3;
  IconData? icon;

  @override
  State<ProfileExpanisonValues> createState() => _ProfileExpanisonValuesState();
}

class _ProfileExpanisonValuesState extends State<ProfileExpanisonValues> {
  @override
  Widget build(BuildContext context) {
    Color? color =Get.isDarkMode?Colors.white: borderColor;

    return  Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
    child:

      ExpansionTile(
        tilePadding: EdgeInsets.only(left: 1.w, right: 5.w),
      leading: FittedBox(
        fit: BoxFit.fill,
        child: Icon(widget.icon, color: color, size: 16.sp),
      ),
      title: Text(
        widget.title!,
          style: context.theme.textTheme.headlineMedium!
              .copyWith(color: color, fontWeight: FontWeight.w400)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 3.5.w,
        color: color,
      ),
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.only(left: 1.w, right: 5.w),
          onTap: () {
            widget.onCreateGiftChanged();
          },
          // leading: FittedBox(
          //   fit: BoxFit.fill,
          //   child: Icon(widget.icon, color: borderColor, size: 16.sp),
          // ),
          title: Text(widget.title1!,
              style: context.theme.textTheme.headlineMedium!
                  .copyWith(color: color, fontWeight: FontWeight.w400)),
          // trailing: Icon(
          //   Icons.arrow_forward_ios,
          //   size: 3.5.w,
          //   color: borderColor,
          // ),
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 1.w, right: 5.w),
          onTap: () {
            widget.onPurchasedHistoryChanged();
          },
          // leading: FittedBox(
          //   fit: BoxFit.fill,
          //   child: Icon(widget.icon, color: borderColor, size: 16.sp),
          // ),
          title: Text(widget.title2!,
              style: context.theme.textTheme.headlineMedium!
                  .copyWith(color: color, fontWeight: FontWeight.w400)),
          // trailing: Icon(
          //   Icons.arrow_forward_ios,
          //   size: 3.5.w,
          //   color: borderColor,
          // ),
        ),
        ListTile(
          contentPadding: EdgeInsets.only(left: 1.w, right: 5.w),
          onTap: () {
            widget.onTransactionsHistoryChanged();
          },
          // leading: FittedBox(
          //   fit: BoxFit.fill,
          //   child: Icon(widget.icon, color: borderColor, size: 16.sp),
          // ),
          title: Text(widget.title3!,
              style: context.theme.textTheme.headlineMedium!
                  .copyWith(color: color, fontWeight: FontWeight.w400)),
          // trailing: Icon(
          //   Icons.arrow_forward_ios,
          //   size: 3.5.w,
          //   color: borderColor,
          // ),
        )
      ],
    ));
  }
}
