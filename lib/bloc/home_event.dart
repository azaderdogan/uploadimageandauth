part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitialEvent extends HomeEvent {}

class HomeLoadingEvent extends HomeEvent {}

class HomeUploadPhotoEvent extends HomeEvent {}

class HomeDeletePhotoEvent extends HomeEvent {
  final String url;

  HomeDeletePhotoEvent(this.url);
}
