part of 'lists_bloc.dart';

abstract class ListsEvent extends Equatable {
  const ListsEvent();
  @override
  List<Object> get props => [];
}

class LoadLists extends ListsEvent {}

class UpdateLists extends ListsEvent {
  final List<String> likeList;
  final List<String> wishList;

  const UpdateLists({required this.likeList, required this.wishList});

  @override
  List<Object> get props => [likeList, wishList];
}
