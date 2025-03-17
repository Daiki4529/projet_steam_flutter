import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/repositories/steam_repository.dart';
import 'package:equatable/equatable.dart';

import 'package:projet_steam/models/game_details.dart';

part 'game_details_event.dart';
part 'game_details_state.dart';

class GameDetailsBloc extends Bloc<GameDetailsEvent, GameDetailsState> {
  final SteamRepository steamRepository;

  GameDetailsBloc({required this.steamRepository}) : super(GameDetailsInitial()) {
    on<FetchGameDetails>((event, emit) async {
      emit(GameDetailsLoading());
      try {
        final gameDetails = await steamRepository.fetchGameDetails(event.appId);
        emit(GameDetailsLoaded(gameDetails: gameDetails));
      } catch (e) {
        emit(GameDetailsError(message: e.toString()));
      }
    });
  }
}

