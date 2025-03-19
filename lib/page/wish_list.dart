import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

import '../blocs/game_details/game_details_bloc.dart';

class WishList extends StatelessWidget {
  final List<String> appIds;

  const WishList({super.key, required this.appIds});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameDetailsBloc(
        steamRepository: SteamRepository()
      )..add(FetchAllGameDetails(appIds: appIds)),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.close),
                iconSize: 30,
              ),
              Text(
                'Ma liste de souhaits',
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          centerTitle: false,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
          ),
          child: BlocBuilder<GameDetailsBloc, GameDetailsState>(
            builder: (context, state) {
              if (state is GameDetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator()
                );
              } else if (state is AllGamesDetailsLoaded) {
                return ListView.builder(
                  itemCount: state.gameDetailsList.length,
                  itemBuilder: (context, index) {
                    final gameDetails = state.gameDetailsList[index];
                    return GameCard(gameDetails: gameDetails);
                  },
                );
                //return CardGame(gameDetails: state.gameDetails);
              } else if (state is GameDetailsError) {
                return Center(
                  child: Text('Erreur : ${state.message}')
                );
              }
              return Column(
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
                        height: 1.5
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
          )
        ),
      ),
    );
  }
}
