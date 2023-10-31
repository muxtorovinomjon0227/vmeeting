import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vmeeting/src/constants/colors_const.dart';

  ThemeData getAppTheme(BuildContext context, bool idDark) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: idDark ? Brightness.light : Brightness.dark,
    ));
  return  ThemeData(
    scaffoldBackgroundColor: idDark ? ColorConst.appMainBackgroundColor : ColorConst.appSecondWhiteColor,
    textTheme: GoogleFonts.latoTextTheme(idDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
          idDark ? Colors.orange : Colors.purple),
    ),
    listTileTheme: ListTileThemeData(
        iconColor: idDark ? Colors.orange : Colors.purple),
    appBarTheme: AppBarTheme(
        backgroundColor: idDark ? ColorConst.appMainBackgroundColor : ColorConst.appSecondWhiteColor,
        iconTheme: IconThemeData(color: idDark ? ColorConst.appMainBackgroundColor : ColorConst.appSecondWhiteColor,)),
  );
}