import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_steam/services/router.dart';
import 'package:projet_steam/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: steamAppTheme(context),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
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
        titleTextStyle: GoogleFonts.openSans(
            textStyle: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: Colors.white)),
      ),
    );
