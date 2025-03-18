part of 'most_played_games_bloc.dart';

abstract class MostPlayedGamesEvent extends Equatable {
  const MostPlayedGamesEvent();

  @override
  List<Object> get props => [];
}

class FetchMostPlayedGames extends MostPlayedGamesEvent {}
