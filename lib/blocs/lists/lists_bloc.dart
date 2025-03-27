import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_steam/repositories/firebase_repository.dart';

part 'lists_event.dart';
part 'lists_state.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  final FirebaseRepository repository;

  ListsBloc({required this.repository}) : super(ListsInitial()) {
    on<LoadLists>(_onLoadLists);
    on<UpdateLists>(_onUpdateLists);
  }

  Future<void> _onLoadLists(LoadLists event, Emitter<ListsState> emit) async {
    emit(ListsLoading());
    try {
      final data = await repository.fetchLists();
      final likeList = List<String>.from(data['likelist'] ?? []);
      final wishList = List<String>.from(data['wishlist'] ?? []);
      emit(ListsLoaded(likeList: likeList, wishList: wishList));
    } catch (e) {
      emit(ListsError(e.toString()));
    }
  }

  Future<void> _onUpdateLists(UpdateLists event, Emitter<ListsState> emit) async {
    emit(ListsLoading());
    try {
      await repository.updateLists(
          likeList: event.likeList, wishList: event.wishList);
      // After updating, re-fetch the updated lists
      final data = await repository.fetchLists();
      final likeList = List<String>.from(data['likelist'] ?? []);
      final wishList = List<String>.from(data['wishlist'] ?? []);
      emit(ListsLoaded(likeList: likeList, wishList: wishList));
    } catch (e) {
      emit(ListsError(e.toString()));
    }
  }
}
