import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/font_and_size_const.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final FontWeight? fontWidget;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? textOverflow;

  const SmallText(
      {Key? key,
        required this.text,
        this.size = SizeConst.kSmallFont14,
        this.color,
        this.fontWidget,
        this.textAlign,
        this.maxLines = 1,
        this.softWrap = false,
        this.textOverflow = TextOverflow.fade,
      })
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
        color: color,),
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: textOverflow,
    );
  }
}
