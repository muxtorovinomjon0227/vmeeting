part of 'user_log_in_bloc.dart';

@immutable
abstract class UserLogInState extends Equatable{}

class UserLogInInitialState extends UserLogInState {
  @override
  List<Object?> get props => [];
}

class UserLogInLoadedState extends UserLogInState {
  @override
  List<Object?> get props => [];
}

class UserLogInInChackingState extends UserLogInState {
  @override
  List<Object?> get props => [];
}

class UserLogInExceptionState extends UserLogInState {
  final String? message;
  UserLogInExceptionState({required this.message});
  @override
  List<Object?> get props => [message];
}