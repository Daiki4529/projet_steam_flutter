import 'package:flutter/material.dart';
import 'package:projet_steam/assets/app_colors.dart';
import 'package:projet_steam/models/game_details.dart';

class GameCard extends StatelessWidget {
  final GameDetails gameDetails;

  const GameCard({super.key, required this.gameDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        elevation: 4,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 130,
          child: Stack(
            children: [
              // Image as background
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    gameDetails.obfuscatedBackground,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) =>
                        (loadingProgress == null)
                            ? child
                            : Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
              ),
              // Second widget overlaid on top
              Positioned.fill(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          child: Image.network(gameDetails.coverImage)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 16.0)
                            .copyWith(end: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gameDetails.gameName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              gameDetails.editors.join(", "),
                              style: Theme.of(context).textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            gameDetails.isFree
                                ? Text(
                                    "Gratuit",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                  )
                                : Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Prix",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                        ),
                                        TextSpan(
                                          text: " : ${gameDetails.price} €",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final squareSize = constraints.maxHeight;
                        return SizedBox(
                          width: squareSize,
                          height: squareSize,
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(AppColors.purpleBlue),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(8.0),
                                    bottomEnd: Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            child: Text(
                              "En savoir plus",
                              style: Theme.of(context).textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
