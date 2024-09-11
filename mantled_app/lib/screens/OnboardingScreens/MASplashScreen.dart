import 'dart:async';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/screens/OnboardingScreens/MAWalkThroughScreen.dart';
import 'package:mantled_app/utils/NBImages.dart';
import 'package:nb_utils/nb_utils.dart';

class MASplashScreen extends StatefulWidget {
  static String tag = '/MASplashScreen';

  const MASplashScreen({super.key});

  @override
  MASplashScreenState createState() => MASplashScreenState();
}

class MASplashScreenState extends State<MASplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {

    Timer(const Duration(seconds: 4), () {
      finish(context);
      const MAWalkthroughScreen().launch(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:  Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,

          // Below is the code for Linear Gradient.
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00A088) , Color(0xFF7800F0), ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Image.asset("assets/png/logo_white.png",
            width:MediaQuery.of(context).size.width*0.1 ,),
        )
      ),
    );
  }
}
