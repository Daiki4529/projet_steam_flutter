part of 'game_details_bloc.dart';

abstract class GameDetailsEvent extends Equatable {
  const GameDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchGameDetails extends GameDetailsEvent {
  final String appId;

  const FetchGameDetails({required this.appId});

  @override
  List<Object> get props => [appId];
}

class FetchAllGameDetails extends GameDetailsEvent {
  final List<String> appIds;

  const FetchAllGameDetails({required this.appIds});

  @override
  List<Object> get props => [appIds];
}