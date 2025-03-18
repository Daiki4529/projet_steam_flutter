part of 'reviews_bloc.dart';

abstract class ReviewsEvent extends Equatable {
  const ReviewsEvent();

  @override
  List<Object> get props => [];
}

class FetchReviews extends ReviewsEvent {
  final String appId;

  const FetchReviews({required this.appId});

  @override
  List<Object> get props => [appId];
}
