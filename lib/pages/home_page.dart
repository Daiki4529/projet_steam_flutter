import 'package:flutter/material.dart';
import 'package:projet_steam/assets/app_colors.dart';
import 'package:projet_steam/assets/app_icons.dart';
import 'package:projet_steam/components/featured_game_card.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/models/game_details.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0, // Added elevation for shadow
        title: Text(
          "Acceuil",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: AppIcons.like.icon,
            onPressed: () {},
          ),
          IconButton(
            icon: AppIcons.wishlist.icon,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              FeaturedGameCard(
                gameDetails: gameDetails,
              ),
              const SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Les meilleures ventes',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
              ...bestSellerGames.map(
                (game) {
                  return GameCard(gameDetails: game);
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
