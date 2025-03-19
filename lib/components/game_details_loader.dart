import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/blocs/game_details/game_details_bloc.dart';
import 'package:projet_steam/models/game_details.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class GameDetailsLoader extends StatelessWidget {
  final String appId;
  final Widget Function(BuildContext, GameDetails) builder;

  const GameDetailsLoader({
    super.key,
    required this.appId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameDetailsBloc>(
      create: (_) => GameDetailsBloc(
        steamRepository: SteamRepository(),
      )..add(FetchGameDetails(appId: appId)),
      child: BlocBuilder<GameDetailsBloc, GameDetailsState>(
        builder: (context, state) {
          if (state is GameDetailsLoading || state is GameDetailsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GameDetailsLoaded) {
            return builder(context, state.gameDetails);
          } else if (state is GameDetailsError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return Container();
        },
      ),
    );
  }
}
