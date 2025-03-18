import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/repositories/steam_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:projet_steam/models/game.dart';

part 'search_games_event.dart';
part 'search_games_state.dart';

class SearchGamesBloc extends Bloc<SearchGamesEvent, SearchGamesState> {
  final SteamRepository repository;

  SearchGamesBloc({required this.repository}) : super(SearchGamesInitial()) {
    on<FetchSearchGames>((event, emit) async {
      emit(SearchGamesLoading());
      try {
        final games = await repository.searchGames(event.query);
        emit(SearchGamesLoaded(games: games));
      } catch (e) {
        emit(SearchGamesError(message: e.toString()));
      }
    });
  }
}
