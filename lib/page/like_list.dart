import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/component/card_game.dart';

class LikeList extends StatelessWidget {
  const LikeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
              color: Colors.white,
              iconSize: 30,
            ),
            Text(
              'Mes likes',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF111822),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.only(
          top: 10
        ),
        decoration: BoxDecoration(
          color: Color(0xFF131B27)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardGame(),
            CardGame(),
            CardGame()
          ],
        ),
      ),
    );
  }
}
