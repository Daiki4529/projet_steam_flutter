import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projet_steam/models/game.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

part 'most_played_games_event.dart';
part 'most_played_games_state.dart';

class MostPlayedGamesBloc
    extends Bloc<MostPlayedGamesEvent, MostPlayedGamesState> {
  final SteamRepository steamRepository;

  MostPlayedGamesBloc({required this.steamRepository})
      : super(MostPlayedGamesInitial()) {
    on<FetchMostPlayedGames>((event, emit) async {
      emit(MostPlayedGamesLoading());
      try {
        final games = await steamRepository.fetchMostPlayedGames();
        emit(MostPlayedGamesLoaded(games: games));
      } catch (e) {
        emit(MostPlayedGamesError(message: e.toString()));
      }
    });
  }
}
