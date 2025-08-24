import 'package:flutter/material.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class LogoContainer extends StatelessWidget {
  const LogoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: 80.w,
        height: 50.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageAsset.frontLogo), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
