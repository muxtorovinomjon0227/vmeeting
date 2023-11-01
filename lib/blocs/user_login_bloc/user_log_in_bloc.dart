
import 'package:bloc/bloc.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';

import '../../service/user_repositores/user_repo.dart';

part 'user_log_in_event.dart';
part 'user_log_in_state.dart';

class UserLogInBloc extends Bloc<UserLogInEvent, UserLogInState> {
  UserLogInBloc() : super(UserLogInInitialState()) {

    on<UserLogInFetchEvent>((event, emit) {
      emit(UserLogInLoadedState());
    });

    on<UserLogInChakingEvent>((event, emit) async {
       UserRepository.getInstance().userSigIn(context: event.context, user: event.user, controller: event.controller);
    });

    on<UserLogInChakedEvent>((event, emit) async {
       emit(UserLogInInitialState());
     bool response = await  UserRepository.getInstance().userSigIn(context: event.context, user: event.user, controller: event.controller);
     if(response == false){
       emit(UserLogInLoadedState());
     }
    });
  }
}
