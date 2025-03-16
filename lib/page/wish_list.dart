import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/component/card_game.dart';

class WishList extends StatelessWidget {
  final List<String> games;

  const WishList({super.key, required this.games});

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
              'Ma liste de souhaits',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF111822),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF131B27)
        ),
        child: games.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'res/svg/empty_wishlist.svg',
              width: 125,
              height: 125
            ),
            SizedBox(height: 50),
            Text(
              "Vous n'avez encore pas liké de contenu.\nCliquez sur l'étoile pour en rajouter.",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                height: 2
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ):
          ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              return CardGame(gameName: games[index]);
            }
          )
      ),
    );
  }
}
