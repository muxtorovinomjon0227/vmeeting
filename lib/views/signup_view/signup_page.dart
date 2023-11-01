import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vmeeting/blocs/user_sign_up_bloc/user_sign_up_bloc.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import 'package:vmeeting/src/extension/context_extensions.dart';
import 'package:vmeeting/src/utils/app_utils.dart';
import 'package:vmeeting/src/widgets/small_text.dart';

import '../../app_models/user_model/user_model.dart';
import '../../service/routes/routes_name.dart';
import '../../src/constants/colors_const.dart';
import '../../src/utils/show_dialogs.dart';
import '../../src/widgets/big_text_widget.dart';
import '../../src/widgets/custom_loading/customloading.dart';
import '../../src/widgets/exceptions/app_exeptions.dart';
import '../../src/widgets/textfiled_widgets/auth_text_fild.dart';

class UserSignUpPage extends StatefulWidget {
  final NumberController controller;
  const UserSignUpPage({super.key, required this.controller});

  @override
  State<UserSignUpPage> createState() => _UserSignUpPageState();
}

class _UserSignUpPageState extends State<UserSignUpPage> {
  late UserSignUpBloc userSignUpBloc;
  late bool isDarkMode = false;

  final _loginControlle = TextEditingController(text: "Flutter2000");
  final _loginFocusNode = FocusNode();
  final _passwordControlle = TextEditingController(text: "Flutter2000");
  final _passwordFocusNode = FocusNode();
  final _emailControlle = TextEditingController(text: "muxtorovinomjon0227@gmail.com");
  final _emailFocusNode = FocusNode();
  final _fullNameControlle = TextEditingController(text: "Muxtorov Inomjon");
  final _fullNameFocusNode = FocusNode();


  @override
  void initState() {
    userSignUpBloc = BlocProvider.of<UserSignUpBloc>(context);
    userSignUpBloc.add(UserSignUpFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserSignUpBloc, UserSignUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is UserSignUpInitialState) {
            return buildLoading();
          }
          if (state is UserSignUpLoadedState) {
            return buildUI();
          }
          if (state is UserSignUpFetchState) {
            return const Center(
                child: AppExceptionsWidget(
                    message: "Exception",
                    authName: MainRoutes.user_signup_page));
          }
          if (state is UserSignUpExceptionState) {
            return const Center(
                child: AppExceptionsWidget(
                    message: "Exception",
                    authName: MainRoutes.user_signup_page));
          }
          return const Center(child: Text("AloVoice"));
        },
      ),
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
            SizedBox(height: context.h * 0.1),
            BigText(
              text: "Sign Up",
              size: context.h * 0.04,
              fontWidget: FontWeight.bold,
            ),
            SizedBox(height: context.h * 0.1),
            AuthTextFild(
              lableName: "Email",
              borderRadius: 10,
              elevation: 1,
              color: Colors.grey.withOpacity(0.2),
              type: TextInputType.emailAddress,
              focusNode: _emailFocusNode,
              textEditingController: _emailControlle,
            ),
            SizedBox(height: context.h * 0.03),
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
            SizedBox(height: context.h * 0.03),
            AuthTextFild(
              lableName: "FullName",
              borderRadius: 10,
              elevation: 1,
              color: Colors.grey.withOpacity(0.2),
              focusNode: _fullNameFocusNode,
              textEditingController: _fullNameControlle,
            ),
            SizedBox(height: context.h * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              TextButton(onPressed: (){
                Navigator.pushReplacementNamed(context, MainRoutes.sign_in_page);
              }, child: SmallText(text: "Sign In",color: ColorConst.appMainColor,))
            ],),
            SizedBox(height: context.h * 0.08),
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
              if(_fullNameControlle.text.isNotEmpty && _emailControlle.text.isNotEmpty && _loginControlle.text.isNotEmpty && _passwordControlle.text.isNotEmpty){
                userSigUp();
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
                    :  BigText(
                  text: "Sign Up".toUpperCase(),
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

  Future<void> userSigUp() async {
    widget.controller.inputElevatedButton.add(true);
    CubeUser user = CubeUser(
        login: _loginControlle.text,
        password: _passwordControlle.text,
        email: _emailControlle.text,
        fullName: _fullNameControlle.text,);
    userSignUpBloc.add(UserSignUpChakingEvent(controller: widget.controller, context: context, user: user));

  }

  Widget buildLoading() {
    return Center(child: CustomLoading());
  }
}
