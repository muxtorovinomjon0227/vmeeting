part of 'user_sign_up_bloc.dart';

@immutable
abstract class UserSignUpState extends Equatable{}

class UserSignUpInitialState extends UserSignUpState {
  @override
  List<Object?> get props => [];
}

class UserSignUpFetchState extends UserSignUpState{
  @override
  List<Object?> get props => [];
}
class UserSignUpLoadedState extends UserSignUpState{
  @override
  List<Object?> get props => [];
}
class UserSignUpExceptionState extends UserSignUpState{
  final String message;
  UserSignUpExceptionState({required this.message});
  @override
  List<Object?> get props => [message];
}