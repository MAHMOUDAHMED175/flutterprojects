import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkThem=ThemeData(
    scaffoldBackgroundColor: HexColor('375563'),

    primarySwatch: dafultColor,//علشان يغير لون اللودنج وهيا بتلف لبرتقالى
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey.withOpacity(0.28),
          statusBarIconBrightness:Brightness.light
      ),
      backgroundColor:HexColor('375563'),
      elevation:0.0,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
      ),
      iconTheme:IconThemeData(
        color: Colors.white,
      ) ,
    ),
    textTheme:TextTheme(
      bodyText1:TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
    ) ,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: dafultColor,
      unselectedItemColor: Colors.grey,
      elevation: 3.0,
      backgroundColor: HexColor('375563'),
    ),
  fontFamily: 'Short',
);
ThemeData lightThem=ThemeData(
    primarySwatch: dafultColor,//علشان يغير لون اللودنج وهيا بتلف لبرتقالى
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.grey.withOpacity(0.28),
          statusBarIconBrightness:Brightness.dark
      ),
      backgroundColor: Colors.white,
      elevation:0.0,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold
      ),
      iconTheme:IconThemeData(
        color: Colors.black,
      ) ,
    ),
    textTheme:TextTheme(
      bodyText1:TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ) ,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: dafultColor,
      unselectedItemColor: Colors.grey,
      elevation: 3.0,
      backgroundColor: Colors.white,
    ),
  fontFamily: 'Short',
);