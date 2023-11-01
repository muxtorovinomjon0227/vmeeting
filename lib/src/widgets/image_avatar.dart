import 'package:flutter/material.dart';

import '../constants/colors_const.dart';

class AvatarImage extends StatelessWidget {
  final double radius;
  final String imagePath;
  const AvatarImage({Key? key, this.radius = 60, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: radius*1.8,
      height: radius*1.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: ColorConst.appWhiteColor
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset(
            imagePath,
            width: radius*1.8,
            height: radius*1.8,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );

  }
}