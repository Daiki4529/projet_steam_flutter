part of 'game_details_bloc.dart';

abstract class GameDetailsState extends Equatable {
  const GameDetailsState();

  @override
  List<Object> get props => [];
}

class GameDetailsInitial extends GameDetailsState {}

class GameDetailsLoading extends GameDetailsState {}

class GameDetailsLoaded extends GameDetailsState {
  final GameDetails gameDetails;

  const GameDetailsLoaded({required this.gameDetails});

  @override
  List<Object> get props => [gameDetails];
}

class GameDetailsError extends GameDetailsState {
  final String message;

  const GameDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
