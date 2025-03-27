import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/components/game_details_loader.dart';

class WishList extends StatelessWidget {
  // TODO
  final List<String> appIds = ["730" /* Base de donnée */];

  WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Ma liste de souhaits',
        style: Theme.of(context).textTheme.titleLarge,
      )),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(),
        child: appIds.isEmpty
            ? _emptyWishList(context)
            : SingleChildScrollView(
              child: Column(
                  children: [
                    ...appIds.map(
                      (appId) => SizedBox(
                        height: 146,
                        child: GameDetailsLoader(
                          appId: appId,
                          builder: (context, gameDetails) {
                            return GameCard(gameDetails: gameDetails);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }

  Widget _emptyWishList(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('res/svg/empty_wishlist.svg',
              width: 125, height: 125),
          SizedBox(height: 50),
          Text(
            "Vous n'avez encore pas liké de contenu.\nCliquez sur l'étoile pour en rajouter.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          )
        ]);
  }
}
