import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/blocs/game_details/game_details_bloc.dart';
import 'package:projet_steam/components/game_cart.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class GameDetailsPage extends StatelessWidget {
  final String appId;

  const GameDetailsPage({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameDetailsBloc(steamRepository: SteamRepository())
        ..add(FetchGameDetails(appId: appId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game Details'),
        ),
        body: BlocBuilder<GameDetailsBloc, GameDetailsState>(
          builder: (context, state) {
            if (state is GameDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GameDetailsLoaded) {
              final gameDetails = state.gameDetails;
              return GameCard(gameDetails: gameDetails);
            } else if (state is GameDetailsError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
