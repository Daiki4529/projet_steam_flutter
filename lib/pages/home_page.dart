import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_steam/assets/app_colors.dart';
import 'package:projet_steam/assets/app_icons.dart';
import 'package:projet_steam/blocs/most_played_games/most_played_games_bloc.dart';
import 'package:projet_steam/components/featured_game_card.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/components/game_details_loader.dart';
import 'package:projet_steam/models/game.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MostPlayedGamesBloc(
        steamRepository: SteamRepository(),
      )..add(FetchMostPlayedGames()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4.0,
          title: Text(
            "Accueil",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(
              icon: AppIcons.like.icon,
              onPressed: () => context.go("/likelist"),
            ),
            IconButton(
              icon: AppIcons.wishlist.icon,
              onPressed: () => context.go("/wishlist"),
            )
          ],
        ),
        body: BlocBuilder<MostPlayedGamesBloc, MostPlayedGamesState>(
          builder: (context, state) {
            if (state is MostPlayedGamesLoading ||
                state is MostPlayedGamesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MostPlayedGamesError) {
              return Center(child: Text("Error: ${state.message}"));
            } else if (state is MostPlayedGamesLoaded) {
              final List<Game> games = state.games.take(10).toList();
              if (games.isEmpty) {
                return const Center(child: Text("No games found."));
              }

              // The first game will be used as the featured game.
              final Game featuredGame = games.first;
              // The rest are best sellers.
              final List<Game> bestSellerGames = games.sublist(1);

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search field remains unchanged.
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Rechercher un jeu...',
                            hintStyle: Theme.of(context).textTheme.bodyLarge,
                            suffixIcon: const Icon(
                              Icons.search,
                              color: AppColors.purpleBlue,
                              size: 30,
                            ),
                            filled: true,
                            fillColor: AppColors.slateGray,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      // Featured game loaded individually.
                      SizedBox(
                        height: 250,
                        child: GameDetailsLoader(
                          appId: featuredGame.appId,
                          builder: (context, gameDetails) {
                            return FeaturedGameCard(gameDetails: gameDetails);
                          },
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Les meilleures ventes',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                        ),
                      ),
                      // Best sellers list: each item updates independently.
                      ...bestSellerGames.map(
                        (game) => SizedBox(
                          height: 146,
                          child: GameDetailsLoader(
                            appId: game.appId,
                            builder: (context, gameDetails) {
                              return GameCard(gameDetails: gameDetails);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
