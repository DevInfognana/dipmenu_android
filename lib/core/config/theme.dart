import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../extra/common_widgets/text_scalar_factor.dart';

// Color mainColor = const Color(0xffFF8A00);
Color mainColor = Colors.red;
const Color onBoardingDocsColor = Color.fromRGBO(144, 152, 177, 1);
const Color onBoardingIndcatorColor = Color.fromRGBO(229, 229, 229, 1);
const Color authTextFromFieldFillColor = Color.fromRGBO(241, 244, 254, 1);
const Color authTextFromFieldPorderColor = Color.fromRGBO(214, 218, 225, 1);
const Color authTextFromFieldHintTextColor = Color.fromRGBO(194, 189, 189, 1);
const Color authTextFromFieldErrorBorderColor = Color.fromRGBO(255, 0, 0, 1);
const Color headline1Color = Color.fromRGBO(0, 76, 255, 1);
const Color borderColor = Colors.black;
const Color hintColor = Color(0xffC1C6C6);

const Color descriptionColor = Color(0xff878D8D);
const Color titleColor = Color(0xff323637);
const Color tileColor = Color(0xffCFCFCF);
const Color drivethru = Color(0xffA3BA15);
const Color pickuporder = Color(0xffFFCD00);
const Color scheduledpickuporder = Color(0xffFF7A00);
const darkSeafoamGreen1 = Color(0xff45b080);

class ThemesApp {
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: mainColor,
    secondaryHeaderColor: Colors.grey.shade100,
    cardColor: const Color(0xffFFFFFF),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 22.sp : 44),
      displayMedium: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 18.sp : 28,
          color: Colors.black),
      displaySmall: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 16.sp : 25,
          color: Colors.black),
      headlineMedium: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 14.sp : 20,
          color: Colors.black),
      headlineSmall: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 12.sp : 17,
          color: Colors.black),
      titleLarge: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 10.sp : 14,
          color: Colors.black),
      bodyLarge: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 8.sp : 12,
          color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black45),
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(mainColor))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: mainColor, size: 3.h),
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 3.h)),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF18172B),
    primaryColor: Colors.deepPurple,
    secondaryHeaderColor: const Color(0xFF27273c),
    hoverColor: Colors.red,
    textTheme: TextTheme(
      displayLarge: const TextStyle(color: Colors.black),
      displayMedium: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 18.sp : 28,
          color: Colors.white),
      displaySmall: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 16.sp : 25,
          color: Colors.white),
      headlineMedium: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 14.sp : 20,
          color: Colors.white),
      headlineSmall: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 12.sp : 17,
          color: Colors.white),
      titleLarge: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 10.sp : 14,
          color: Colors.white),
      bodyLarge: GoogleFonts.poppins(
          fontSize: DeviceTypeValues.getDeviceType() == 'phone' ? 8.sp : 12,
          color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarTextStyle: TextStyle(color: Colors.white),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white)),
    cardColor: const Color(0xFF27273c),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: const Color(0xFF18172B),
        selectedIconTheme: IconThemeData(color: mainColor, size: 3.h),
        selectedItemColor: mainColor,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(color: Colors.white, size: 3.h)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(mainColor))),
    iconTheme: const IconThemeData(color: Colors.white),
    hintColor: Colors.white,
  );
}
