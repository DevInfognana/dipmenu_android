import 'package:dip_menu/presentation/pages/splash/widget/logo_container.dart';
import 'package:flutter/material.dart';
import 'package:dip_menu/presentation/pages/index.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(children: <Widget>[
              Positioned(
                top: 12.h,
                left: 5.w,
                child: Container(
                  width: 90.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.w),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 14.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children:  <Widget>[
                      const Spacer(flex: 7,),
                      const LogoContainer(),
                      const Spacer(flex: 2),
                      CircularProgressIndicator(
                        color: mainColor,
                      ),
                      // Text('VELVET\nCREAM',
                      //     style: TextStore.textTheme.displayMedium!.copyWith(
                      //         color: Colors.black,
                      //         height: 1.1,
                      //         letterSpacing: 5.0,
                      //         fontWeight: FontWeight.w900)),
                      const Spacer(flex: 6,),
                    ],
                  ),
                ),
              ),
            ])
            ),
      ),
    );
  }
}
