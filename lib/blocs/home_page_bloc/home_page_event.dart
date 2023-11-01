part of 'home_page_bloc.dart';

@immutable
abstract class HomePageEvent extends Equatable{}

class HomePageFetchEvent extends HomePageEvent{
  @override
  List<Object?> get props => [];
}
