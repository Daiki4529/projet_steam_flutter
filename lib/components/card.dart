import 'package:flutter/material.dart';
import 'package:projet_steam/models/game_details.dart';

class GameCard extends StatelessWidget {
  final GameDetails gameDetails;

  const GameCard({super.key, required this.gameDetails});

  @override
  Widget build(BuildContext context) {
    return _buildGameCard(context, gameDetails);
  }

  Widget _buildGameCard(BuildContext context, GameDetails gameDetails) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 10, top: 5, end: 10, bottom: 5),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          color: const Color(0xFF182332),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Image.network(
            gameDetails.coverImage,
            width: 100,
            height: 100,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameDetails.gameName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  gameDetails.editors.join(", "),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (!gameDetails.isFree)
                  Text(
                    "Prix : ${gameDetails.price.toString()}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                else
                  Text(
                    "Gratuit",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                padding: const EdgeInsetsDirectional.only(start: 25, end: 25),
                backgroundColor: const Color(0xFF4800FF),
                minimumSize: const Size(120, double.infinity),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5)))),
            child: Text(
              "En savoir\nplus",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
