part of 'lists_bloc.dart';

abstract class ListsState extends Equatable {
  const ListsState();
  @override
  List<Object> get props => [];
}

class ListsInitial extends ListsState {}

class ListsLoading extends ListsState {}

class ListsLoaded extends ListsState {
  final List<String> likeList;
  final List<String> wishList;

  const ListsLoaded({required this.likeList, required this.wishList});

  @override
  List<Object> get props => [likeList, wishList];
}

class ListsError extends ListsState {
  final String message;

  const ListsError(this.message);

  @override
  List<Object> get props => [message];
}
