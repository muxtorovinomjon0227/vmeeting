part of 'user_sign_up_bloc.dart';

@immutable
abstract class UserSignUpEvent extends Equatable{}

class UserSignUpFetchEvent extends UserSignUpEvent{
  @override
  List<Object?> get props => [];
}
class UserSignUpChakingEvent extends UserSignUpEvent {
  final BuildContext context;
  final CubeUser user;
  final NumberController controller;
  UserSignUpChakingEvent({required this.controller, required this.context, required this.user});
  @override
  List<Object?> get props => [context,user, controller];
}
