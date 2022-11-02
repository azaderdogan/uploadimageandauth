part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> images;

  HomeLoaded(this.images);

  @override
  List<Object> get props => [images];
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
  @override
  List<Object> get props => [message];
}
