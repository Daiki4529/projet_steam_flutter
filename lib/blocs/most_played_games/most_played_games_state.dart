part of 'most_played_games_bloc.dart';

abstract class MostPlayedGamesState extends Equatable {
  const MostPlayedGamesState();

  @override
  List<Object> get props => [];
}

class MostPlayedGamesInitial extends MostPlayedGamesState {}

class MostPlayedGamesLoading extends MostPlayedGamesState {}

class MostPlayedGamesLoaded extends MostPlayedGamesState {
  final List<Game> games;

  const MostPlayedGamesLoaded({required this.games});

  @override
  List<Object> get props => [games];
}

class MostPlayedGamesError extends MostPlayedGamesState {
  final String message;

  const MostPlayedGamesError({required this.message});

  @override
  List<Object> get props => [message];
}
