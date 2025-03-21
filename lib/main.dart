import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_steam/template_game.dart';

void main() {
  const appId = "431960";
  runApp(MyApp(appId: appId));
}

class MyApp extends StatelessWidget {
  final String appId;
  const MyApp({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: steamAppTheme(context),
      debugShowCheckedModeBanner: false,
      home: GameDetailsPage(appId: appId),
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
