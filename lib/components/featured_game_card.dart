import 'package:flutter/material.dart';
import 'package:projet_steam/assets/app_colors.dart';
import 'package:projet_steam/models/game_details.dart';

class FeaturedGameCard extends StatelessWidget {
  final GameDetails gameDetails;

  const FeaturedGameCard({super.key, required this.gameDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          // Image as background
          Positioned.fill(
            child: Image.network(
              gameDetails.background,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  (loadingProgress == null)
                      ? child
                      : Center(
                          child: CircularProgressIndicator(
                            color: AppColors.purpleBlue,
                          ),
                        ),
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),
          // Second widget overlaid on top
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 12.0,
                start: 16.0,
                end: 16.0,
                top: 70.0,
              ),
              // Place any widget here that you want on top of the image
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gameDetails.gameName,
                          style: Theme.of(context).textTheme.headlineLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          gameDetails.shortDescription,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(height: 0),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(AppColors.purpleBlue),
                            fixedSize:
                                WidgetStateProperty.all(const Size(250, 50)),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    5), // Adjust the radius as needed
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            "En savoir plus",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 16.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(
                        height: 156,
                        width: 104,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          child: Image.network(
                            gameDetails.coverImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
