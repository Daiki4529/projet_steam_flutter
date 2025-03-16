import 'package:flutter/material.dart';
import 'package:projet_steam/page/like_list.dart';
import 'package:projet_steam/page/wish_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: LikeList(games: ["Forza", "Valorant", "Summoners War", "Dokkan Battle"]),
        ),
      ),
    );
  }
}
