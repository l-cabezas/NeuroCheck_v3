
import 'package:flutter/material.dart';

ThemeData dayData() {
  return ThemeData(
      brightness: Brightness.light,
      textTheme: const TextTheme(titleLarge: TextStyle(color: Color(0xffe1f5fe))),
      buttonTheme: const ButtonThemeData(buttonColor: Color(0xff004999)) ,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primarySwatch: Colors.blue,
      primaryColorLight: Colors.white,
      appBarTheme: const AppBarTheme(color: Color(0xFF0055b3),),
      backgroundColor:  const Color(0xFFdcffff),
      primaryColor: const Color(0xFF5DADE2),
      cardColor: const Color(0xFF85C1E9),
      dividerColor: const Color(0xFFAED6F1),
      bottomAppBarColor:const Color(0xFF1B4F72),
      tabBarTheme:  const TabBarTheme(labelColor: Color(0xFF1B4F72)),
    useMaterial3: true

  );
}

ThemeData darkData() {
  return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
      primaryColor: const Color(0xFFBB8FCE),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF6C3483)),
      backgroundColor: Colors.black,//const Color(0xFF5B2C6F),
      cardColor: const Color(0xFFAF7AC5),
      dividerColor: const Color(0xFFD2B4DE),
      bottomAppBarColor:Colors.deepPurple,
      useMaterial3: true,

  );
}