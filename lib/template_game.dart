import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/blocs/game_details/game_details_bloc.dart';
import 'package:projet_steam/components/game_cart.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class GameDetailsPage extends StatelessWidget {
  // final String appId;
  final List<String> appIds;

  const GameDetailsPage({super.key, required this.appIds});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameDetailsBloc(steamRepository: SteamRepository())
        ..add(FetchAllGameDetails(appIds: appIds)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Game Details'),
        ),
        body: Column(
          children: appIds.map((appId) => GameCard(appId: appId)).toList(),
        ),
      ),
    );
  }
}
