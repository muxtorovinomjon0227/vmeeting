import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:flutter/material.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';

import '../../app_models/user_model/user_model.dart';
import '../../service/routes/routes_name.dart';
import '../../src/constants/colors_const.dart';
import '../../src/utils/app_utils.dart';
import '../../src/utils/show_dialogs.dart';
import '../../src/widgets/big_text_widget.dart';
import '../../src/widgets/custom_loading/customloading.dart';
import '../../src/widgets/textfiled_widgets/auth_text_fild.dart';

class UserSignInPage extends StatefulWidget {
  final NumberController controller;
  const UserSignInPage({super.key, required this.controller});

  @override
  State<UserSignInPage> createState() => _UserSignInPageState();
}

class _UserSignInPageState extends State<UserSignInPage> {
  late bool isDarkMode = false;
  final _loginControlle = TextEditingController(text: "");
  final _loginFocusNode = FocusNode();
  final _passwordControlle = TextEditingController(text: "");
  final _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  buildUI(),
    );
  }
  Widget buildUI(){
    return Container(
        margin: EdgeInsets.symmetric(horizontal: context.w * 0.06),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: context.h * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Switch.adaptive(
                    value:  isDarkMode,
                    activeColor: ColorConst.appGreenColor,
                    onChanged: (value) {
                      isDarkMode = value;
                      widget.controller.inputTheme.add(value);
                    },
                  ),
                ],),
              SizedBox(height: context.h * 0.12),
              BigText(
                text: "Sign In",
                size: context.h * 0.04,
                fontWidget: FontWeight.bold,
              ),
              SizedBox(height: context.h * 0.1),
              AuthTextFild(
                lableName: "Login",
                borderRadius: 10,
                elevation: 1,
                color: Colors.grey.withOpacity(0.2),
                focusNode: _loginFocusNode,
                textEditingController: _loginControlle,
              ),
              SizedBox(height: context.h * 0.03),
              AuthTextFild(
                lableName: "Password",
                borderRadius: 10,
                elevation: 1,
                color: Colors.grey.withOpacity(0.2),
                focusNode: _passwordFocusNode,
                textEditingController: _passwordControlle,
              ),
              SizedBox(height: context.h * 0.16),
              buildButtons(),
            ],
          ),
        )
    );
  }
  Widget buildButtons() {
    return StreamBuilder(stream: widget.controller.outputElevatedButton,
        builder: (BuildContext context, snapshot){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorConst.appGreenColor,
                  disabledForegroundColor: Colors.grey.withOpacity(0.38),
                  disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                ),
                onPressed: () async {
                  if(_loginControlle.text.isNotEmpty && _passwordControlle.text.isNotEmpty){
                    widget.controller.inputElevatedButton.add(true);
                    userSigIn();
                  }else{
                    AppUtils.showSnackBar(context, "PLEASE ENTER THE SAME VALUE AGAIN");
                  }

                },
                child: SizedBox(
                  width: context.w * 0.8,
                  height: context.h * 0.06,
                  child:  Center(
                    child: snapshot.data ?? false
                        ? AppUtils.buttonLoader
                        : const BigText(
                      text: "Sin Up",
                      fontWidget: FontWeight.bold,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
  Future<void> userSigIn() async {
    CubeUser user = CubeUser(
      login: _loginControlle.text,
      password: _passwordControlle.text,);
    signIn(user).then((cubeUser) {
      UserModel(
          id: cubeUser.id,
          login: cubeUser.login,
          email: cubeUser.email,
          fullName: cubeUser.fullName
      );
      print("Shu yerda $cubeUser");
      widget.controller.inputElevatedButton.add(false);
      Navigator.pushReplacementNamed(context, MainRoutes.main_page);

    })
        .catchError((error){
      widget.controller.inputElevatedButton.add(false);
      errorMessage(context);
      print(error);
    });
  }

  Widget buildLoading() {
    return Center(child: CustomLoading());
  }
}
