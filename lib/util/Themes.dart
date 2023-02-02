import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


final ThemeData LIGHT_THEME_DATA = ThemeData(

  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    elevation: 5.0,

  ),

  iconTheme: IconThemeData(color: Colors.blueAccent),
  appBarTheme:  AppBarTheme(
    
    backgroundColor: Colors.white,

    elevation: 0,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    ),


      textTheme: TextTheme(
          displayMedium: TextStyle(color:Colors.black),
          bodyMedium: TextStyle(color:Colors.black),
          headlineLarge: TextStyle(color: Colors.black),
          headlineMedium:TextStyle(color:Colors.white),
          bodySmall: TextStyle(color: Colors.white,fontSize: 14.sp),

      )



  ),
  scaffoldBackgroundColor: Colors.white,
  // primaryColor: Colors.amber, //app bar and button color
  brightness: Brightness.light,
);
final DARK_THEME_DATA = ThemeData(

  iconTheme: IconThemeData(color: Colors.blueAccent),
  bottomAppBarTheme: const BottomAppBarTheme(
    color:Color(0xFF270E4D),

    elevation: 15.0,

  ),

  appBarTheme:  AppBarTheme(

    backgroundColor: Color(0xFF270E4D),
    foregroundColor: Colors.white,

    elevation: 1,
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 20,
    ),

    iconTheme: IconThemeData(
      color: Colors.white,
      size: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    ),
  ),
  scaffoldBackgroundColor: Color(0xFF270E4D),
  // primaryColor: Colors.amber, //app bar and button color
  brightness: Brightness.dark,
    textButtonTheme: TextButtonThemeData(style: ElevatedButton.styleFrom(foregroundColor: Colors.blue)),
  textTheme: TextTheme(
    displayMedium: TextStyle(color:Colors.white),
    bodyMedium: TextStyle(color:Colors.black),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium:TextStyle(color:Colors.black,),
    bodySmall: TextStyle(color: Colors.black,fontSize: 12.sp),

  ),

);
/*TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.black : Colors.red,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.red,
    ),
  );
}

TextStyle get titleTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.red,
    ),
  );
}

TextStyle get subtitleTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
    ),
  );
}*/

TextStyle get subjectTextStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
  );
}

InputDecoration formInputDecoration = InputDecoration(
  hintStyle: const TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.black45,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.black54,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.black,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
);