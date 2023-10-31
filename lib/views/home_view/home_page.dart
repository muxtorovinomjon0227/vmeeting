import 'package:flutter/material.dart';
import 'package:vmeeting/src/constants/colors_const.dart';
import 'package:vmeeting/src/widgets/big_text_widget.dart';

import '../../src/controllers/enter_number_cont.dart';

class HomePage extends StatelessWidget {
  final NumberController controller;
  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  Center(
        child:BigText( text: "Salom",color: ColorConst.appMainBackgroundColor,)
    );
  }
}