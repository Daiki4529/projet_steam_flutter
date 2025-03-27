import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_steam/assets/app_colors.dart';
import 'package:projet_steam/assets/app_icons.dart';
import 'package:projet_steam/blocs/most_played_games/most_played_games_bloc.dart';
import 'package:projet_steam/blocs/search_games/search_games_bloc.dart';
import 'package:projet_steam/components/featured_game_card.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/components/game_details_loader.dart';
import 'package:projet_steam/models/game.dart';
import 'package:projet_steam/models/game_details.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(steamRepository: SteamRepository()),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          // Use the text in the search bar to decide if we're searching.
          final bool isSearching = _searchController.text.isNotEmpty;
          return Scaffold(
            appBar: AppBar(
              elevation: 4.0,
              leading: isSearching
                  ? IconButton(
                      icon: AppIcons.close.icon,
                      onPressed: () {
                        _searchController.clear();
                        context.read<SearchBloc>().add(ClearSearch());
                        setState(() {}); // Refresh the UI after clearing text.
                      },
                    )
                  : null,
              title: Text(
                isSearching ? "Recherche" : "Acceuil",
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              actions: isSearching ? null : [
                IconButton(
                  icon: AppIcons.like.icon,
                  onPressed: () => context.go("/likelist"),
                ),
                IconButton(
                  icon: AppIcons.wishlist.icon,
                  onPressed: () => context.go("/wishlist"),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(context),
                    _buildStateContent(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
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
        onChanged: (query) {
          setState(() {}); // Update the UI when text changes.
          if (query.isNotEmpty) {
            context.read<SearchBloc>().add(SearchGames(query: query));
          } else {
            context.read<SearchBloc>().add(ClearSearch());
          }
        },
      ),
    );
  }

  Widget _buildStateContent(BuildContext context, SearchState state) {
    if (state is SearchInitial) {
      return _buildInitialContent();
    } else if (state is SearchLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SearchLoaded) {
      return _buildSearchResults(state.games);
    } else if (state is SearchError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Erreur: ${state.message}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    } else {
      return _buildInitialContent();
    }
  }

  Widget _buildInitialContent() {
    return BlocProvider(
      create: (_) => MostPlayedGamesBloc(steamRepository: SteamRepository())
        ..add(FetchMostPlayedGames()),
      child: BlocBuilder<MostPlayedGamesBloc, MostPlayedGamesState>(
        builder: (context, state) {
          if (state is MostPlayedGamesLoading ||
              state is MostPlayedGamesInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MostPlayedGamesError) {
            return Center(child: Text("Error: ${state.message}"));
          } else if (state is MostPlayedGamesLoaded) {
            final List<Game> games = state.games.take(11).toList();
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
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(decoration: TextDecoration.underline),
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
    );
  }

  Widget _buildSearchResults(List<dynamic> games) {
    if (games.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Aucun résultat trouvé'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            '${games.length} résultats trouvés',
            style: const TextStyle(decoration: TextDecoration.underline),
          ),
        ),
        // Single FutureBuilder for all games
        FutureBuilder<List<GameDetails>>(
          future: Future.wait(games
              .map((game) => SteamRepository().fetchGameDetails(game.appId))
              .toList()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Erreur lors du chargement des résultats'),
                ),
              );
            } else if (snapshot.hasData) {
              return Column(
                children: snapshot.data!
                    .map((GameDetails gameDetails) =>
                        GameCard(gameDetails: gameDetails))
                    .toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
