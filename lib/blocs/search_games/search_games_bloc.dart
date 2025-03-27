import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projet_steam/models/game.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

part 'search_games_event.dart';
part 'search_games_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SteamRepository steamRepository;

  SearchBloc({required this.steamRepository}) : super(SearchInitial()) {
    on<SearchGames>((event, emit) async {
      if (event.query.isEmpty) {
        emit(SearchInitial());
        return;
      }

      emit(SearchLoading());
      try {
        final games = await steamRepository.searchGames(event.query);
        emit(SearchLoaded(games: games));
      } catch (e) {
        emit(SearchError(message: e.toString()));
      }
    });

    on<ClearSearch>((event, emit) {
      emit(SearchInitial());
    });
  }
}