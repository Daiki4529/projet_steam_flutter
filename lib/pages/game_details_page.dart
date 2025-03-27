import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projet_steam/assets/app_colors.dart';
import 'package:projet_steam/assets/app_icons.dart';
import 'package:projet_steam/assets/app_values.dart';
import 'package:projet_steam/blocs/lists/lists_bloc.dart';
import 'package:projet_steam/blocs/reviews/reviews_bloc.dart';
import 'package:projet_steam/models/game_details.dart';
import 'package:projet_steam/models/review.dart';
import 'package:projet_steam/repositories/firebase_repository.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

class GameDetailsPage extends StatelessWidget {
  final GameDetails gameDetails;

  const GameDetailsPage({super.key, required this.gameDetails});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            ListsBloc(repository: FirebaseRepository())..add(LoadLists()),
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: AppIcons.back.icon,
              onPressed: () => context.pop(),
            ),
            title: Text(
              gameDetails.gameName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
                if (state is ListsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListsLoaded) {
                  return IconButton(
                    icon: state.likeList.contains(gameDetails.appId)
                        ? AppIcons.likeFull.icon
                        : AppIcons.like.icon,
                    onPressed: () {
                      if (state.likeList.contains(gameDetails.appId)) {
                        context.read<ListsBloc>().add(UpdateLists(
                              likeList: state.likeList
                                ..remove(gameDetails.appId),
                              wishList: state.wishList,
                            ));
                      } else {
                        context.read<ListsBloc>().add(UpdateLists(
                              likeList: state.likeList..add(gameDetails.appId),
                              wishList: state.wishList,
                            ));
                      }
                    },
                  );
                } else if (state is ListsError) {
                  return const Center(child: Text('Error'));
                } else {
                  return const SizedBox.shrink();
                }
              }),
              BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
                if (state is ListsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListsLoaded) {
                  return IconButton(
                    icon: state.wishList.contains(gameDetails.appId)
                        ? AppIcons.wishlistFull.icon
                        : AppIcons.wishlist.icon,
                    onPressed: () {
                      if (state.wishList.contains(gameDetails.appId)) {
                        context.read<ListsBloc>().add(UpdateLists(
                              wishList: state.wishList
                                ..remove(gameDetails.appId),
                              likeList: state.likeList,
                            ));
                      } else {
                        context.read<ListsBloc>().add(UpdateLists(
                              wishList: state.wishList..add(gameDetails.appId),
                              likeList: state.likeList,
                            ));
                      }
                    },
                  );
                } else if (state is ListsError) {
                  return const Center(child: Text('Error'));
                } else {
                  return const SizedBox.shrink();
                }
              }),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      gameDetails.background,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _GameDetailsMenuState(
                      gameDetails: gameDetails,
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  height: 120,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF2b343c),
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
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
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            // Game image
                            ClipRRect(
                              child: Image.network(
                                gameDetails.coverImage,
                                width: 70,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    gameDetails.gameName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 6.0),
                                  Text(
                                    gameDetails.editors.join(", "),
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _GameDetailsMenuState extends StatefulWidget {
  final GameDetails gameDetails;

  const _GameDetailsMenuState({required this.gameDetails});

  @override
  State<_GameDetailsMenuState> createState() => __GameDetailsMenuStateState();
}

class __GameDetailsMenuStateState extends State<_GameDetailsMenuState> {
  AppValues selectedIndex = AppValues.gameDetailsDescriptionIndex;

  Widget _buildTab(AppValues index, String title) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.indigo.shade400 : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontFamily: GoogleFonts.openSans().fontFamily,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedIndex) {
      case AppValues.gameDetailsDescriptionIndex:
        return _buildDescription();
      case AppValues.gameDetailsReviewsIndex:
        return _buildReviews();
    }
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 20.0, vertical: 15.0),
      child: Column(
        children: [
          Html(
            data: widget.gameDetails.longDescription,
            style: {
              "body": Style(fontSize: FontSize(15), color: Colors.white),
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildReviews() {
    return Padding(
      padding:
          EdgeInsetsDirectional.symmetric(horizontal: 20.0, vertical: 30.0),
      child: _reviewsContent(),
    );
  }

  Widget _reviewsContent() {
    return BlocProvider(
      create: (_) => ReviewsBloc(
        steamRepository: SteamRepository(),
      )..add(FetchReviews(appId: widget.gameDetails.appId)),
      child: BlocBuilder<ReviewsBloc, ReviewsState>(builder: (context, state) {
        if (state is ReviewsLoading || state is ReviewsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ReviewsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children:
                state.reviews.map((review) => _buildReview(review)).toList(),
          );
        } else if (state is ReviewsError) {
          return SizedBox.shrink();
        }
        return SizedBox.shrink();
      }),
    );
  }

  Widget _buildReview(Review review) {
    return Container(
      padding: const EdgeInsetsDirectional.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.slateGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<String>(
                  future: SteamRepository().getUsername(review.authorId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white));
                    } else if (snapshot.hasError) {
                      return const Text("Error",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white));
                    } else {
                      return Text(snapshot.data ?? "",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.underline));
                    }
                  },
                ),
                Row(
                  children: List.generate(5, (index) {
                    if (review.score >= index + 1) {
                      // Full star if the rating is greater than or equal to the star position.
                      return Icon(Icons.star, color: Colors.amber, size: 16);
                    } else if (review.score > index) {
                      // Half star if the rating is between the star position and the next full star.
                      return Icon(Icons.star_half,
                          color: Colors.amber, size: 16);
                    } else {
                      // Empty star otherwise.
                      return Icon(Icons.star_border,
                          color: Colors.grey.shade700, size: 16);
                    }
                  }),
                ),
              ],
            ),
          ),
          Html(
            data: review.reviewText.replaceAll("[", "<").replaceAll("]", ">"),
            style: {
              "body": Style(color: Colors.white),
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(
              top: 80.0, start: 20.0, end: 20.0, bottom: 20.0),
          child: Container(
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.purpleBlue, width: 2),
            ),
            child: Row(
              children: [
                _buildTab(AppValues.gameDetailsDescriptionIndex, 'DESCRIPTION'),
                _buildTab(AppValues.gameDetailsReviewsIndex, 'AVIS'),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: _buildContent(),
          ),
        ),
      ],
    );
  }
}
