import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:flutter/cupertino.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import '../../app_models/app_users_model/app_users_model.dart';
import '../../app_models/user_model/user_model.dart';
import '../../src/utils/app_utils.dart';
import '../../src/utils/pref_util.dart';
import '../../src/utils/show_dialogs.dart';
import '../routes/routes_name.dart';

class UserRepository {
  static final UserRepository _singleton = UserRepository._internal();
  UserRepository._internal();
  static UserRepository getInstance() {
    return _singleton;
  }

  Future<bool> userSigIn({required BuildContext context, required CubeUser user, required NumberController controller}) async {
    bool isChaking = true;
   await signIn(user).then((cubeUser) async {
      AppUtils.userModel =  UserModel(
          id: cubeUser.id,
          login: cubeUser.login,
          email: cubeUser.email,
          fullName: cubeUser.fullName
      );
      controller.inputElevatedButton.add(false);
      SharedPrefs.saveNewUser(user);
      Navigator.pushReplacementNamed(context, MainRoutes.main_page);
      isChaking = true;
    })
        .catchError((error){
      controller.inputElevatedButton.add(false);
      errorMessage(context);
      print(error);
      isChaking = false;
    });
    return isChaking;
  }

  Future<void> userSigUp({required BuildContext context, required CubeUser user, required NumberController controller}) async {
    signUp(user).then((cubeUser) {
      AppUtils.userModel =  UserModel(
          id: cubeUser.id,
          login: cubeUser.login,
          email: cubeUser.email,
          fullName: cubeUser.fullName
      );
      SharedPrefs.saveNewUser(user);
      controller.inputElevatedButton.add(false);
      Navigator.pushReplacementNamed(context, MainRoutes.main_page);

    })
        .catchError((error){
      controller.inputElevatedButton.add(false);
      errorMessage(context);
      print(error);
    });
  }

  Future<List<AppUsersModel>> getAppAllUsers() async {
    List<AppUsersModel> appUsersModelList = [];
   await getAllUsers().then((response) {
      print("Shu yerda $response");
      for(var item in response!.items){
        appUsersModelList.add(AppUsersModel(
          user: User(
            fullName: item.fullName,
            email: item.email,
            login: item.login,
            id: item.id,
            avatar: item.avatar,
            createdAt: item.createdAt?.timeZoneName,
            customData: item.customData,
            externalId: item.externalId.toString(),
            externalUserId: item.externalUserId.toString(),
            facebookId: item.facebookId,
            isGuest: item.isGuest.toString(),
            lastRequestAt: item.lastRequestAt?.toIso8601String(),
            phone: item.phone,
          )
        ));
      }
    }).catchError((onError){

    });
  return appUsersModelList;
  }

}