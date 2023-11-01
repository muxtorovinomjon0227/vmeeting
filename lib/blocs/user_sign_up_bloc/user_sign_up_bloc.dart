
import 'package:bloc/bloc.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../service/user_repositores/user_repo.dart';
import '../../src/controllers/enter_number_cont.dart';
part 'user_sign_up_event.dart';
part 'user_sign_up_state.dart';

class UserSignUpBloc extends Bloc<UserSignUpEvent, UserSignUpState> {
  UserSignUpBloc() : super(UserSignUpInitialState()) {
    on<UserSignUpFetchEvent>((event, emit) {
     emit(UserSignUpLoadedState());
    });

    on<UserSignUpChakingEvent>((event, emit) {
      UserRepository.getInstance().userSigUp(context: event.context, user: event.user, controller: event.controller);
     emit(UserSignUpLoadedState());
    });
  }
}
