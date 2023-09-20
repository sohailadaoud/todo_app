import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff5D9CEC);
  static Color backgroundLight = Color(0xffDFECDB);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff383838);
  static Color greyColor = Color(0xff949495);
  static Color whiteColor = Color(0xffffffff);
  static Color backgroundDark = Color(0xff060E1E);
  static Color blackDark = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryLight,
        unselectedItemColor: greyColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          shape: StadiumBorder(
              side: BorderSide(
            color: whiteColor,
            width: 4,
          ))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: MyTheme.primaryLight, // Background color
        ),
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: whiteColor),
          titleMedium: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: blackColor),
          titleSmall: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: blackColor)));
  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryLight,
        unselectedItemColor: whiteColor,
        backgroundColor: MyTheme.blackDark,
        elevation: 0,
        showUnselectedLabels: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          shape: StadiumBorder(
              side: BorderSide(
            color: blackDark,
            width: 4,
          ))),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: blackDark),
          titleMedium: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: whiteColor),
          titleSmall: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: greyColor)));

// ===================================
// static ThemeData darkTheme = ThemeData(
//   primaryColor: redColor,
//   scaffoldBackgroundColor: Colors.transparent,
//   appBarTheme: AppBarTheme(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       centerTitle: true,
//       iconTheme: IconThemeData(color: whiteColor)),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     selectedItemColor: greenColor,
//     unselectedItemColor: whiteColor,
//     showUnselectedLabels: true,
//   ),
//   textTheme: TextTheme(
//       titleLarge: TextStyle(
//         fontSize: 30,
//         fontWeight: FontWeight.bold,
//         color: whiteColor,
//       ),
//       titleMedium: TextStyle(
//         fontSize: 25,
//         fontWeight: FontWeight.w500,
//         color: whiteColor,
//       ),
//       titleSmall: TextStyle(
//         fontSize: 25,
//         fontWeight: FontWeight.w300,
//         color: greenColor,
//       )),
// );
}
