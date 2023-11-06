import 'dart:io';
import 'package:connectycube_flutter_call_kit/connectycube_flutter_call_kit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upgrader/upgrader.dart';
import 'package:vmeeting/service/routes/app_routes.dart';
import 'package:vmeeting/service/routes/navigator_service.dart';
import 'package:vmeeting/src/constants/app_themes/app_themes.dart';
import 'package:vmeeting/src/controllers/enter_number_cont.dart';
import 'package:vmeeting/src/utils/pref_util.dart';
import 'firebase_options.dart';
import 'src/utils/configs.dart' as config;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatefulWidget {
  static NavigationService navigationService = NavigationService();
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  final NumberController controller = NumberController();

  @override
  Widget build(BuildContext context) {
    return (!kIsWeb )
        ? StreamBuilder(
        stream: controller.outputTheme,
        initialData: false,
        builder: (BuildContext context, snapshot){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: getAppTheme(context, snapshot.data ?? false),
              title: 'MyMeeting',
              navigatorKey: App.navigationService.navigatorKey,
              home: UpgradeAlert(
                upgrader: Upgrader(
                    canDismissDialog: true,
                    shouldPopScope: () => true,
                    cupertinoButtonTextStyle: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal),
                    durationUntilAlertAgain: const Duration(days: 1),
                    dialogStyle: Platform.isIOS ?  UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material
                ),
                child:  MainNavigator(controller: controller),
              )
          );
        })
        : MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        primarySwatch: Colors.green,
      ),
      title: 'MyMeeting',
      navigatorKey: App.navigationService.navigatorKey,
      home: MainNavigator(controller: controller),
    );

  }

  @override
  void initState() {
    super.initState();

    ConnectycubeFlutterCallKit.instance.init();

    initConnectycube();
  }
}

initConnectycube() {
  init(
    config.APP_ID,
    config.AUTH_KEY,
    config.AUTH_SECRET,
    onSessionRestore: () {
      return SharedPrefs.getUser().then((savedUser) {
        return createSession(savedUser);
      });
    },
  );
}

initConnectycubeContextLess() {
  CubeSettings.instance.applicationId = config.APP_ID;
  CubeSettings.instance.authorizationKey = config.AUTH_KEY;
  CubeSettings.instance.authorizationSecret = config.AUTH_SECRET;
  CubeSettings.instance.onSessionRestore = () {
    return SharedPrefs.getUser().then((savedUser) {
      return createSession(savedUser);
    });
  };
}
