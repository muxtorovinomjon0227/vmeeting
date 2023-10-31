import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

  ThemeData getAppTheme(BuildContext context, bool idDark) {
  return  ThemeData(
    scaffoldBackgroundColor: idDark ? Colors.black : Colors.white,
    textTheme: GoogleFonts.latoTextTheme(idDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
          idDark ? Colors.orange : Colors.purple),
    ),
    listTileTheme: ListTileThemeData(
        iconColor: idDark ? Colors.orange : Colors.purple),
    appBarTheme: AppBarTheme(
        backgroundColor: idDark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(color: idDark ? Colors.white : Colors.black54)),
  );
}