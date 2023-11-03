import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import 'package:vmeeting/src/utils/app_utils.dart';
import '../../app_models/app_users_model/app_users_model.dart';
import '../../src/utils/configs.dart';
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
    if (CubeSessionManager.instance.isActiveSessionValid() && CubeSessionManager.instance.activeSession!.user != null) {
      if (CubeChatConnection.instance.isAuthenticated()) {
        controller.inputElevatedButton.add(false);
        Navigator.pushReplacementNamed(context, MainRoutes.main_page);
      } else {
        _loginToCubeChat(context, user, controller);
      }
    } else {
      createSession(user).then((cubeSession) {
        CubeUser userss = CubeUser(
          id: cubeSession.user?.id,
          login: user.login,
          password: user.password,
        );
        _loginToCubeChat(context, userss,controller);
      }).catchError((exception) {
        controller.inputElevatedButton.add(false);
        errorMessage(context);
      });
    }
    return isChaking;
  }

  void _loginToCubeChat(BuildContext context, CubeUser user,NumberController controller) {
    CubeChatConnection.instance.login(user).then((cubeUser) {
      SharedPrefs.saveNewUser(user);
      controller.inputElevatedButton.add(false);
      Navigator.pushReplacementNamed(context, MainRoutes.main_page);
    }).catchError((exception) {
      controller.inputElevatedButton.add(false);
      errorMessage(context);
    });
  }

  Future<void> userSigUp({required BuildContext context, required CubeUser user, required NumberController controller}) async {
    signUp(user).then((cubeUser) {
      SharedPrefs.saveNewUser(user);
      CubeUser userss = CubeUser(
        id: cubeUser.id,
        login: user.login,
        password: user.password,
      );
      _loginToCubeChat(context, userss,controller);

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
        usersForCall.add(item);
        appUsersModelList.add(AppUsersModel(
          user: UserModel(
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

  Future<void> getUserProfile(BuildContext context) async {
    String login = "Inomjon2000";
    getUserByLogin(login).then((cubeUser) {
       AppUtils.userModel = UserModel(
         login: cubeUser?.login ?? "",
         sId: cubeUser?.id.toString(),
         phone: cubeUser?.phone ?? "",
         lastRequestAt: cubeUser?.lastRequestAt?.toIso8601String() ?? "",
         isGuest: cubeUser?.isGuest.toString(),
         facebookId: cubeUser?.facebookId ?? "",
         externalUserId: cubeUser?.externalUserId ?? "",
         externalId: cubeUser?.externalId.toString(),
         customData: cubeUser?.customData ?? "",
         createdAt: cubeUser?.createdAt?.toIso8601String() ?? "",
         avatar: cubeUser?.avatar ?? "",
         id: cubeUser?.id,
         email: cubeUser?.email ?? "",
         fullName: cubeUser?.fullName ?? "",
         timezone: cubeUser?.timeZone.toString() ?? "",
         twitterId: cubeUser?.twitterId ?? "",
         updatedAt: cubeUser?.updatedAt?.toIso8601String() ?? "",
         website: cubeUser?.website.toString() ?? ""
       );

    })
        .catchError((error) {
      errorMessage(context);
    });

  }

}