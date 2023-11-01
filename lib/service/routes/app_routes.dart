// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vmeeting/blocs/user_sign_up_bloc/user_sign_up_bloc.dart';
import 'package:vmeeting/service/routes/routes_name.dart';
import 'package:vmeeting/views/main_view/main_page.dart';
import '../../blocs/user_login_bloc/user_log_in_bloc.dart';
import '../../src/controllers/enter_number_cont.dart';
import '../../views/signin_view/signin_page.dart';
import '../../views/signup_view/signup_page.dart';
import '../../views/splash_view/splash_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MainNavigator extends StatelessWidget {
  final NumberController controller;
  const MainNavigator({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var canPop = navigatorKey.currentState?.canPop() ?? false;
        if (canPop) {
          navigatorKey.currentState?.pop();
        }
        return !canPop;
      },
      child: Navigator(
        key: navigatorKey,
        initialRoute: MainRoutes.splash_screen,
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder? builder;
          switch (settings.name) {
            case MainRoutes.splash_screen:
              builder = (BuildContext _) => SplashScreen(controller: controller);
              break;
              case MainRoutes.main_page:
              builder = (BuildContext _) => MainPage(controller: controller);
              break;
            case MainRoutes.user_signup_page:
              builder = (BuildContext _) => MultiBlocProvider(
                providers: [
                  BlocProvider<UserSignUpBloc>(
                    create: (context) => UserSignUpBloc(),
                  ),
                ],
                child: UserSignUpPage(controller: controller),
              );
              break;
              case MainRoutes.sign_in_page:
              builder = (BuildContext _) => MultiBlocProvider(
                providers: [
                  BlocProvider<UserLogInBloc>(
                    create: (context) => UserLogInBloc(),
                  ),
                ],
                child: UserSignInPage(controller: controller),
              );
              break;
          }
          if (builder != null) {
            return MaterialPageRoute(builder: builder, settings: settings);
          }
        },
        onPopPage: (Route<dynamic> route, dynamic result) {
          return route.didPop(result);
        },
      ),
    );
  }
}