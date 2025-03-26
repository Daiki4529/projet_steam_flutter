import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_steam/pages/game_details_page.dart';
import 'package:projet_steam/pages/home_page.dart';

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
      home: HomePage(),
    );
  }
}

steamAppTheme(context) => ThemeData(
      textTheme:
          GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme.copyWith(
                displayLarge: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                displayMedium: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                displaySmall: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                headlineLarge: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                headlineMedium: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                headlineSmall: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                titleLarge: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                titleMedium: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                titleSmall: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                bodyLarge: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                bodyMedium: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                bodySmall: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                labelLarge: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                labelMedium: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
                labelSmall: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white.withValues(alpha: 0.7),
                  decorationThickness: 2.0,
                ),
              )),
      scaffoldBackgroundColor: Color(0xFF1A2025),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF0D131B),
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        titleTextStyle: GoogleFonts.openSans(textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white)),
      ),
    );
