import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/components/game_card.dart';

import '../components/game_details_loader.dart';

class LikeList extends StatelessWidget {
  final List<String> appIds = ["730"];

  LikeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
            Text(
              'Mes likes',
              style: Theme.of(context).textTheme.titleLarge,
            )
        ),
        body: Container(
          padding: EdgeInsetsDirectional.only(top: 10),
          decoration: BoxDecoration(),
          width: double.infinity,
          child: appIds.isEmpty
              ? _emptyLikeList(context)
              : Column(
                  children: [
                    ...appIds.map(
                      (appId) => GameDetailsLoader(
                        appId: appId,
                        builder: (context, gameDetails) {
                          return GameCard(gameDetails: gameDetails);
                        },
                      ),
                    ),
                  ],
                ),
        ));
  }

  Widget _emptyLikeList(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('res/svg/empty_likes.svg', width: 125, height: 125),
          SizedBox(height: 50),
          Text(
            "Vous n'avez encore pas liké de contenu.\nCliquez sur le coeur pour en rajouter.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          )
        ]);
  }
}
