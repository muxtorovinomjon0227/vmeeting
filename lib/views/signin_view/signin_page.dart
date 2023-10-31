import 'package:flutter/material.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';

class UserSignInPage extends StatefulWidget {
  final NumberController controller;
  const UserSignInPage({super.key, required this.controller});

  @override
  State<UserSignInPage> createState() => _UserSignInPageState();
}

class _UserSignInPageState extends State<UserSignInPage> {

  late bool theme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Switch(
          value: theme,
          onChanged: (val){
            theme = val;
            widget.controller.inputTheme.add(val);
          },
        ),
      ),
    );
  }
}
