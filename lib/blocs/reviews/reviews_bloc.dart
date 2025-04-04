import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projet_steam/models/review.dart';
import 'package:projet_steam/repositories/steam_repository.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class ReviewsBloc extends Bloc<ReviewsEvent, ReviewsState> {
  final SteamRepository steamRepository;

  ReviewsBloc({required this.steamRepository}) : super(ReviewsInitial()) {
    on<FetchReviews>((event, emit) async {
      emit(ReviewsLoading());
      try {
        final reviews = await steamRepository.fetchGameReviews(event.appId);
        emit(ReviewsLoaded(reviews: reviews));
      } catch (e) {
        emit(ReviewsError(message: e.toString()));
      }
    });
  }
}
