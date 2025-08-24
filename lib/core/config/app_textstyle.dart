import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class TextStore {
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 22.sp : 44),
    displayMedium: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 18.sp : 28),
    displaySmall: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 16.sp : 25),
    headlineMedium: GoogleFonts.poppins(
      fontSize: getDeviceType() == 'phone' ? 14.sp : 20,
      color: Theme.of(Get.context!).textTheme.headlineMedium!.color,
    ),
    headlineSmall: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 12.sp : 17),
    titleLarge: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 10.sp : 14),
    titleMedium: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 4.sp : 18),
    titleSmall: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 2.sp : 17),
    bodyLarge: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 8.sp : 12),
    bodyMedium: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 6.sp : 18),
    bodySmall: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 5.sp : 15),
    labelLarge: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 9.sp : 12),
    labelSmall: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 7.sp : 10),
  );

  static String getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.implicitView!);
    return data.size.shortestSide < 600 ? 'phone' : 'tablet';
  }

  static TextTheme boldTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 25.sp),
    displayMedium: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 20.sp),
    titleLarge: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 10.sp : 20),
  );

  static TextTheme textTheme1 = TextTheme(
    headlineSmall: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 12.sp : 23),
    titleLarge: GoogleFonts.poppins(fontSize: getDeviceType() == 'phone' ? 10.sp : 20),
  );
}

class TextWithFont {
  Text textWithPoppinsFont({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
      textAlign: textAlign,
    );
  }

  Text textWithRalewayFont({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: GoogleFonts.raleway(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
      textAlign: textAlign,
    );
  }

  Text textWithNunitoSansFont({
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      style: GoogleFonts.nunitoSans(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
      textAlign: textAlign,
    );
  }
}
