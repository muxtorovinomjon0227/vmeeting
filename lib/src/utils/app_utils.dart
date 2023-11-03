import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vmeeting/src/constants/colors_const.dart';
import '../../app_models/app_users_model/app_users_model.dart';

class AppUtils {
  static  Widget buttonLoader = SizedBox(
    width: 30,
    height: 30,
    child: CircularProgressIndicator(
      strokeWidth: 3,
      color: ColorConst.appWhiteColor,
    ),
  );

  static void showSnackBar(BuildContext context, String message) {
    final snackdemo = SnackBar(
      content:
      Center(child: Text(message,
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.bodyMedium,
          color: ColorConst.appWhiteColor,
          fontStyle: FontStyle.normal,),
        textAlign: TextAlign.center,
      ),),
      backgroundColor: ColorConst.appGreenColor,
      elevation: 30,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
      duration: const Duration(milliseconds: 600),
      shape: const StadiumBorder(),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }
  static UserModel userModel = UserModel();
}

