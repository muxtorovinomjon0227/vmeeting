part of 'home_page_bloc.dart';

@immutable
abstract class HomePageState extends Equatable{}

class HomePageInitialState extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageLoadedState extends HomePageState {
  final List<AppUsersModel> appUsersModelList;
  HomePageLoadedState({required this.appUsersModelList});
  @override
  List<Object?> get props => [appUsersModelList];
}

class HomePageExceptionState extends HomePageState {
  final String message;
  HomePageExceptionState({required this.message});
  @override
  List<Object?> get props => [message];
}
