import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme=ThemeData(
  progressIndicatorTheme:ProgressIndicatorThemeData(color: Colors.lightBlue) ,
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: Colors.lightBlue,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    backgroundColor: HexColor('333739'),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.lightBlue,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
      displayMedium:TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),
    titleMedium:TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black,height: 1,fontFamily: 'Janna LT Regular'
    ),
  ),
);

ThemeData lightTheme=ThemeData(
  primaryColor:Colors.lightBlue ,

  progressIndicatorTheme:ProgressIndicatorThemeData(color: Colors.lightBlue) ,
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.lightBlue,
  appBarTheme: AppBarTheme(
    systemOverlayStyle:SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ) ,
    backgroundColor: Colors.white,
    elevation: 0,
    // iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        fontFamily: 'Janna LT Regular'
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.lightBlue,
    unselectedItemColor: Colors.grey,
    backgroundColor:Colors.white,
  ),
  textTheme: TextTheme(displayMedium:TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),
    bodyMedium:TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Janna LT Regular'
    ),bodySmall:TextStyle(fontSize: 12,color: Colors.grey,fontFamily: 'Janna LT Regular'
      ), ),
);