part of 'search_games_bloc.dart';

abstract class SearchGamesEvent extends Equatable {
  const SearchGamesEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchGames extends SearchGamesEvent {
  final String query;

  const FetchSearchGames({required this.query});

  @override
  List<Object> get props => [query];
}
