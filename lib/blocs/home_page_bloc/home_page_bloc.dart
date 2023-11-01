import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vmeeting/service/user_repositores/user_repo.dart';

import '../../app_models/app_users_model/app_users_model.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  late  List<AppUsersModel> appUsersModelList = [];
  HomePageBloc() : super(HomePageInitialState()){
    on<HomePageFetchEvent>((event, emit) async {
      appUsersModelList.addAll(await UserRepository.getInstance().getAppAllUsers());
      emit(HomePageLoadedState(appUsersModelList: appUsersModelList));
    });
  }
}
