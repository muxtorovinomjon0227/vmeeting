part of 'user_sign_up_bloc.dart';

@immutable
abstract class UserSignUpEvent extends Equatable{}

class UserSignUpFetchEvent extends UserSignUpEvent{
  @override
  List<Object?> get props => [];
}
