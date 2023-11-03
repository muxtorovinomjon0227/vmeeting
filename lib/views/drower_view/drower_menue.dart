import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';
import '../../service/routes/routes_name.dart';
import '../../src/constants/colors_const.dart';
import '../../src/controllers/enter_number_cont.dart';
import '../../src/managers/call_manager.dart';
import '../../src/managers/push_notifications_manager.dart';
import '../../src/utils/app_utils.dart';
import '../../src/utils/pref_util.dart';
import '../../src/widgets/big_text_widget.dart';
import '../../src/widgets/image_avatar.dart';
import '../../src/widgets/small_text.dart';

class DrawerMenue extends StatefulWidget {
  final NumberController controller;
   const DrawerMenue({super.key, required this.controller});

  @override
  State<DrawerMenue> createState() => _DrawerMenueState();
}

class _DrawerMenueState extends State<DrawerMenue> {
  late String appVerson = '';


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildImageAvatar(context),
        SizedBox(height: context.h * 0.02),
        buildMenueList(context),

      ],
    );
  }

  Widget buildImageAvatar(BuildContext context) {
    return Container(
      color: ColorConst.appGreenColor,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: context.h * 0.06),
          buildImage(context,AppUtils.userModel.avatar ?? ""),
          SizedBox(height: context.h * 0.02),
          BigText(text: AppUtils.userModel.fullName ?? "",),
          SizedBox(height: context.h * 0.008),
          BigText(text: AppUtils.userModel.email ?? "",size: context.h*0.017,),
          SizedBox(height: context.h * 0.02),
        ],
      ),
    );
  }
  Widget buildImage(BuildContext context, String? imagaAvatar) {
    return Center(
        child: AvatarImage(
          radius: context.h * 0.08,
          imagePath: imagaAvatar,
        ));
  }

  Widget buildMenueList(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.settings, color: ColorConst.appBleckColor),
            title:  const BigText(text: "Settings",),
            trailing: Icon(Icons.navigate_next,
              color: ColorConst.appBleckColor,
              size: 30,
            ),
            onTap: () async {
            },
          ),
          const Spacer(),
          ListTile(
            leading: Icon(Icons.login, color: ColorConst.appRedColor),
            title:   SmallText(text: "Logout",color: ColorConst.appRedColor,),
            onTap: () {
              logoutApp(context);
            },
          ),

        ],
      ),
    );
  }


  void logoutApp(BuildContext context) async {
    bool? result = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              insetPadding: const EdgeInsets.only(left: 20, right: 20),
              backgroundColor: Colors.white,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, top: 8),
                            child: Icon(Icons.cancel,
                                color: ColorConst.appGreenColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                      const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 8),
                      child: SmallText(
                          text: "Are you sure you want logout current user",
                          size: 16,
                          fontWidget: FontWeight.w600,
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorConst.appGreenColor),
                            child: SmallText(
                              text: "Cancel",
                              size: 16,
                              fontWidget: FontWeight.w600,
                              textAlign: TextAlign.center,
                              color: ColorConst.appBleckColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorConst.appRedColor),
                            child: SmallText(
                              text: "OK",
                              size: 16,
                              fontWidget: FontWeight.w600,
                              textAlign: TextAlign.center,
                              color: ColorConst.appWhiteColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    if (result ?? false)  {
     CallManager.instance.destroy();
     CubeChatConnection.instance.destroy();
     await PushNotificationsManager.instance.unsubscribe();
     await SharedPrefs.deleteUserData();
     await signOut();
     // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, MainRoutes.sign_in_page);

    }
  }

}
