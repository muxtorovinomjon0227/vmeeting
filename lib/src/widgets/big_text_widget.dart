import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/font_and_size_const.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight? fontWidget;
  const BigText(
      {Key? key,
      required this.text,
      this.size = SizeConst.kLargeFont20,
      this.color,
      this.fontWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.lato(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        fontSize: size,
        fontWeight: fontWidget,
        fontStyle: FontStyle.normal,
        color: color,
      ),
    );
  }
}
