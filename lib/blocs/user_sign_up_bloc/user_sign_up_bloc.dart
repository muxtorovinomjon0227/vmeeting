
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'user_sign_up_event.dart';
part 'user_sign_up_state.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  UserSignUpBloc() : super(UserSignUpInitialState()) {
    on<UserSignUpFetchEvent>((event, emit) {
     emit(UserSignUpLoadedState());
    });
  }
}
