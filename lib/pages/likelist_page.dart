import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projet_steam/blocs/lists/lists_bloc.dart';
import 'package:projet_steam/components/game_card.dart';
import 'package:projet_steam/repositories/firebase_repository.dart';

import '../components/game_details_loader.dart';

class LikeList extends StatelessWidget {
  const LikeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ListsBloc(repository: FirebaseRepository())..add(LoadLists()),
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          'Mes likes',
          style: Theme.of(context).textTheme.titleLarge,
        )),
        body: BlocBuilder<ListsBloc, ListsState>(
          builder: (context, state) {
            if (state is ListsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ListsLoaded) {
              return _buildLikeList(context, state.likeList);
            } else if (state is ListsError) {
              return Center(child: Text('Erreur de chargement des listes'));
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLikeList(BuildContext context, List<String> appIds) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 10),
      decoration: BoxDecoration(),
      width: double.infinity,
      child: appIds.isEmpty
          ? _emptyLikeList(context)
          : SingleChildScrollView(
              child: Column(
                children: [
                  ...appIds.map(
                    (appId) => SizedBox(
                      height: 146,
                      child: GameDetailsLoader(
                        appId: appId,
                        builder: (context, gameDetails) {
                          return GameCard(gameDetails: gameDetails);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _emptyLikeList(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('res/svg/empty_likes.svg', width: 125, height: 125),
          SizedBox(height: 50),
          Text(
            "Vous n'avez encore pas liké de contenu.\nCliquez sur le coeur pour en rajouter.",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          )
        ]);
  }
}
