import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
   GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, ModalRoute.withName(routeName));
  }

  Future<dynamic> pushNamed(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
  dynamic pushNamedReplekName(String routeName) {
    return navigatorKey.currentState!.restorablePushReplacementNamed(routeName);
  }
  dynamic goBack() {
    return navigatorKey.currentState?.pop();
  }
}
