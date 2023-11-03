import 'package:flutter/material.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';
import '../../service/routes/routes_name.dart';
import '../../src/constants/colors_const.dart';
import '../../src/controllers/enter_number_cont.dart';
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
      color: ColorConst.appBackgroundColor,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: context.h * 0.06),
          SizedBox(
            width: context.w * 0.25,
            child: AvatarImage(imagePath: "assets/AloVoice.png",
              radius: context.h * 0.055,
            ),
          ),
          SizedBox(height: context.h * 0.02),
          SizedBox(height: context.h * 0.002),
          BigText(text: "cld.alovoice.uz", color: ColorConst.appWhiteColor,),
          SizedBox(height: context.h * 0.02),
        ],
      ),
    );
  }

  Widget buildMenueList(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.settings, color: ColorConst.appBackgroundColor),
            title:  BigText(text: "",),
            trailing: Icon(Icons.navigate_next,
              color: ColorConst.appBackgroundColor,
              size: 30,
            ),
            onTap: () async {
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
                                color: ColorConst.appBackgroundColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 8),
                      child: SmallText(
                          text: " ",
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
                                color: ColorConst.appBackgroundColor),
                            child: SmallText(
                              text: "",
                              size: 16,
                              fontWidget: FontWeight.w600,
                              textAlign: TextAlign.center,
                              color: ColorConst.appWhiteColor,
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
                                color: ColorConst.appWhiteColor),
                            child: SmallText(
                              text: "",
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
    if (result ?? false) {
     Navigator.of(context).pushNamedAndRemoveUntil(MainRoutes.sign_in_page,(Route<dynamic> route) => false);
    }
  }

}
