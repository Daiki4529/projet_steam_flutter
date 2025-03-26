import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/blocs/game_details/game_details_bloc.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class LikeList extends StatelessWidget {
  final List<String> appIds = [];

  LikeList({super.key});

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
                child: appIds.isEmpty
                    ? _emptyLikeList(context)
                    : BlocBuilder<GameDetailsBloc, GameDetailsState>(
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
                            }
                        );
                      } else if (state is GameDetailsError) {
                        return Center(
                          child: Text('Erreur : ${state.message}'),
                        );
                      }
                      return _emptyLikeList(context);
                    }
                )
            )
        )
    );
  }

  Widget _emptyLikeList(BuildContext context) {
    return Column(
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
          )
        ]
    );
  }
}