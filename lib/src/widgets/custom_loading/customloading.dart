import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class CustomLoading extends StatelessWidget{
  Color? color;
  CustomLoading({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      alignment: AlignmentDirectional.center,
      child: Lottie.asset('assets/loading.json'),
    );
  }
}