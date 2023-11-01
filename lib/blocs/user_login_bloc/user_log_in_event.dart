part of 'user_log_in_bloc.dart';

@immutable
abstract class UserLogInEvent extends Equatable{}

class UserLogInFetchEvent extends UserLogInEvent{
  @override
  List<Object?> get props => [];
}

class UserLogInChakingEvent extends UserLogInEvent{
  final BuildContext context;
  final CubeUser user;
  final NumberController controller;
  UserLogInChakingEvent({required this.controller, required this.context, required this.user});
  @override
  List<Object?> get props => [context,user, controller];
}

class UserLogInChakedEvent extends UserLogInEvent{
  final BuildContext context;
  final CubeUser user;
  final NumberController controller;
  UserLogInChakedEvent({required this.controller, required this.context, required this.user});
  @override
  List<Object?> get props => [context,user, controller];
}