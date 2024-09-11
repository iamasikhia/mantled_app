
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/screens/DashboardScreens/MADashboardScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MACompleteProfileScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInScreen.dart';
// import 'package:mantled_app/screens/MADashboardScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignUpScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MAWalkThroughScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart'as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/main.dart';


class MACompleteProfileSuccess extends StatefulWidget {
  static String tag = '/MACompleteProfileSuccess';

  const MACompleteProfileSuccess({Key? key}) : super(key: key);

  @override
  MACompleteProfileSuccessState createState() => MACompleteProfileSuccessState();
}

class MACompleteProfileSuccessState extends State<MACompleteProfileSuccess> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double customHeight= MediaQuery.of(context).size.height*0.1;
    setStatusBarColor(transparentColor, statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.1),
      extendBodyBehindAppBar: true,
      body:  SingleChildScrollView(
        child: Container(
          height: context.height(),
          width: context.width(),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height:  customHeight*0.5,
              ),
              Image.asset('assets/png/confetti-cone.png',fit: BoxFit.cover, width: 200,),
              SizedBox(
                height:  customHeight*0.5,
              ),
              Text(
                'Profile Completed',
                style: primaryTextStyle(color: black,size: 23, weight: FontWeight.w500),

                textAlign: TextAlign.center,
              ),
              SizedBox(
                height:  customHeight*0.1,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: Text('Great! You have completed your profile. Go '
                    'to your Dashboard to access your personal vault',
                  style: primaryTextStyle(color: Colors.black.withOpacity(0.6), ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height:  customHeight*0.6,
              ),

              GestureDetector(
                onTap: (){
                  const MASignInScreen().launch(context);
                },
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:NBPrimaryColor,

                        width: 2,
                      ),
                    ),

                    child: const Padding(
                      padding: EdgeInsets.all(25),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NBPrimaryColor
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white
                          ),
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(
                height:  customHeight*0.6,
              ),

              // GestureDetector(
              //   onTap: (){
              //     const HLDashboardScreen().launch(context);
              //   },
              //   child: Text('GO TO DASHBOARD', style: boldTextStyle(color: Colors.red, size: 15)).onTap(() {
              //     // const HLWalkthroughScreen().launch(context);
              //   }),
              // ),
              16.height,
            ],
          ).paddingAll(30),
        ),
      ),
    );
  }
}
