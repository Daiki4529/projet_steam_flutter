part of 'search_game_bloc.dart';
import 'package:equatable/equatable.dart';

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