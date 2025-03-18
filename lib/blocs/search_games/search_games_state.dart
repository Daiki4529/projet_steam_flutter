part of 'search_games_bloc.dart';

abstract class SearchGamesState extends Equatable {
  const SearchGamesState();

  @override
  List<Object> get props => [];
}

class SearchGamesInitial extends SearchGamesState {}

class SearchGamesLoading extends SearchGamesState {}

class SearchGamesLoaded extends SearchGamesState {
  final List<Game> games;

  const SearchGamesLoaded({required this.games});

  @override
  List<Object> get props => [games];
}

class SearchGamesError extends SearchGamesState {
  final String message;

  const SearchGamesError({required this.message});

  @override
  List<Object> get props => [message];
}
