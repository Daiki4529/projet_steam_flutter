import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/assets/app_colors.dart';
import 'package:projet_steam/assets/app_icons.dart';
import 'package:projet_steam/blocs/search_games/search_game_bloc.dart';
import 'package:projet_steam/components/featured_game_card.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/models/game_details.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class HomePage extends StatelessWidget {
  final GameDetails gameDetails = GameDetails(
    appId: "12345",
    isFree: false,
    gameName: 'Mock Game',
    longDescription:
    'This is a detailed description for the mocked game, used for display purposes.',
    shortDescription: 'Mock Game Short Description',
    coverImage: "https://picsum.photos/200/300",
    background: "https://picsum.photos/600/400",
    editors: ['Mock Editor 1', 'Mock Editor 2'],
    obfuscatedBackground: "https://picsum.photos/600/400",
    price: Price(
      discountPercent: 0,
      finalPrice: 59.99,
      initialPrice: 59.99,
    ),
  );

  List<GameDetails> get bestSellerGames => [
    gameDetails,
    gameDetails,
    gameDetails,
    gameDetails,
    gameDetails,
    gameDetails
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(
        steamRepository: SteamRepository(),
      ),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          final bool isSearching = state is SearchLoaded || state is SearchLoading;

          return Scaffold(
            appBar: AppBar(
              elevation: 4.0,
              leading: isSearching
                  ? IconButton(
                icon: AppIcons.close.icon,
                onPressed: () {
                  context.read<SearchBloc>().add(ClearSearch());
                },
              ) : null,
              title: Text(
                isSearching ? "Recherche" : "Acceuil",
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shadowColor: Colors.black,
              surfaceTintColor: Colors.transparent,
              actions: [
                if (!isSearching) IconButton(
                  icon: AppIcons.like.icon,
                  onPressed: () {},
                ),
                if (!isSearching) IconButton(
                  icon: AppIcons.wishlist.icon,
                  onPressed: () {},
                )
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

  Widget _buildStateContent(BuildContext context, SearchState state) {
    if (state is SearchInitial) {
      return _buildInitialContent();
    } else if (state is SearchLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
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

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
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
        onChanged: (query) {
          if (query.isNotEmpty) {
            context.read<SearchBloc>().add(SearchGames(query: query));
          } else {
            context.read<SearchBloc>().add(ClearSearch());
          }
        },
      ),
    );
  }

  Widget _buildInitialContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeaturedGameCard(
          gameDetails: gameDetails,
        ),
        const SizedBox(height: 24.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Les meilleures ventes',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        ...bestSellerGames.map(
              (game) => GameCard(gameDetails: game),
        ),
      ],
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            '${games.length} résultats trouvés',
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        // Single FutureBuilder for all games
        FutureBuilder<List<GameDetails>>(
          future: Future.wait(
              games.map((game) =>
                  SteamRepository().fetchGameDetails(game.appId)
              ).toList()
          ),
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
                children: snapshot.data!.map((gameDetails) =>
                    GameCard(gameDetails: gameDetails)
                ).toList(),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}