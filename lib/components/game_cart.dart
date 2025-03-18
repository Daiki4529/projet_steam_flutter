import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/blocs/game_details/game_details_bloc.dart';
import 'package:projet_steam/models/game_details.dart';

class GameCard extends StatelessWidget {
  final String appId;

  const GameCard({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameDetailsBloc, GameDetailsState>(
      builder: (context, state) {
        if (state is GameDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllGamesDetailsLoaded) {
          final data = state.gameDetailsList.where((gameDetails) => gameDetails.appId == appId).first;
          return _buildGameCard(context, data);
        } else if (state is GameDetailsError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGameCard(BuildContext context, GameDetails gameDetails) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 10, top: 5, end: 10, bottom: 5),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
          color: Color(0xFF182332), borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Image.network(
            gameDetails.coverImage,
            width: 100,
            height: 100,
          ),
          SizedBox(width: 10),
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
          Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                padding: EdgeInsetsDirectional.only(start: 25, end: 25),
                backgroundColor: Color(0xFF4800FF),
                minimumSize: Size(120, double.infinity),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(0),
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
