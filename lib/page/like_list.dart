import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/components/game_card.dart';

class LikeList extends StatelessWidget {
  final List<String> games;

  const LikeList({super.key, required this.games});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
            ),
            Text(
              'Mes likes',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsetsDirectional.only(
          top: 10
        ),
        decoration: BoxDecoration(
        ),
        width: double.infinity,
        child: games.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
                'res/svg/empty_likes.svg',
                width: 125,
                height: 125
            ),
            SizedBox(height: 50),
            Text(
              "Vous n'avez encore pas liké de contenu.\nCliquez sur le coeur pour en rajouter.",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                height: 1.5
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ):
        ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {

            }
        )
      ),
    );
  }
}
