import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_steam/page/wish_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: steamAppTheme(context),
      debugShowCheckedModeBanner: false,
      home: WishList(appIds: ["431960", "730"]),
    );
  }
}

steamAppTheme(context) => ThemeData(
    textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme.copyWith(
          displayLarge: TextStyle(color: Colors.white),
          displayMedium: TextStyle(color: Colors.white),
          displaySmall: TextStyle(color: Colors.white),
          headlineLarge: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
          headlineSmall: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white),
          labelSmall: TextStyle(color: Colors.white),
        )),
    scaffoldBackgroundColor: Color(0xFF111822),
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF0D131B),
        iconTheme: IconThemeData(color: Colors.white, size: 30)));