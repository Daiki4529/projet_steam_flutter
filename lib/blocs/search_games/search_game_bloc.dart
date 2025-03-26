import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projet_steam/models/game.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

// Define all the parts in this file since they'll be used in a single bloc

// Event definitions
abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchGames extends SearchEvent {
  final String query;

  const SearchGames({required this.query});

  @override
  List<Object> get props => [query];
}

class ClearSearch extends SearchEvent {}

// State definitions
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Game> games;

  const SearchLoaded({required this.games});

  @override
  List<Object> get props => [games];
}

class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}

// Bloc implementation
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