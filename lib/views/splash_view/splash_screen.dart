import 'package:flutter/material.dart';
import '../../src/controllers/enter_number_cont.dart';
import '../../src/widgets/big_text_widget.dart';
class SplashScreen extends StatefulWidget {
  final NumberController controller;
  const SplashScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animatedController;
  late CurvedAnimation _curvedAnimation;
  bool visibleButton = false;
  bool isUserRegistered = false;

  @override
  void initState() {
    super.initState();
    init();
  }


  init() {
    _animatedController =
    AnimationController(duration: const Duration(seconds: 2), vsync: this)
      ..forward()
      ..addStatusListener((status) async {
        if (status == AnimationStatus.completed)   {
          // Navigator.of(context).pushReplacementNamed(MainRoutes.sign_in_page);
        }
      });
    _curvedAnimation =
        CurvedAnimation(parent: _animatedController, curve: Curves.decelerate);
  }

  @override
  void dispose() {
    super.dispose();
    _animatedController.dispose();
  }

  void restartAnimation() {
    if (!_animatedController.isAnimating) {
      _animatedController.reset();
      _animatedController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              child: ScaleTransition(
                scale: Tween(begin: 0.8, end: 1.0).animate(_curvedAnimation),
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child:
                  Image.asset('assets/videomeet.png', fit: BoxFit.fill),
                ),
              ),
            ),
            const BigText(text: "MyMeeting",fontWidget: FontWeight.bold),
            visibleButton
                ? Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 48, vertical: 18),
              child: TextButton(
                onPressed: () {},
                child: const Text("Coose Lenguage"),
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}