import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const primaryColor = Color(0xffD0A2F7);
const secondaryColor = Color(0xffF1EAFF);
const titleColor=Color(0xffDCBFFF);
final appTheme = ThemeData(
    ///01#:
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
        systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: Colors.black,
            statusBarIconBrightness:Brightness.light
        )
    ),
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    ///02#:
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: primaryColor),
    ///03#:
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: secondaryColor,
    ),
    ///04#:
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(color: primaryColor),
        iconColor: secondaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: secondaryColor,width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: primaryColor,width: 2),
          borderRadius: BorderRadius.circular(8),
        )),
    ///05#:
   textTheme:const TextTheme(
     displayLarge: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
     displayMedium: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Times New Roman',color: titleColor),
     displaySmall: TextStyle(fontSize: 20,fontFamily: 'Times New Roman',color: secondaryColor),

   ),

);
