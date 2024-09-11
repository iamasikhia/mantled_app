import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/screens/ForgotPasswordScreens/MAOtpVerificationForgotScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignUpScreen.dart';
// import 'package:mantled_app/screens/OnboardingScreens/MADashboardScreen.dart';
// import 'package:mantled_app/screen/MAOtpVerificationScreen.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:mantled_app/screens/OnboardingScreens/MAResetPasswordScreens.dart';
// import 'package:mantled_app/screens/OnboardingScreens/MASingUpScreen.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/utils/NBImages.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;

import '../DashboardScreens/MADashboardScreen.dart';

class MAResetPasswordScreens extends StatefulWidget {
  static String tag = '/MAResetPasswordScreens';

  const MAResetPasswordScreens({Key? key}) : super(key: key);

  @override
  MAResetPasswordScreensState createState() => MAResetPasswordScreensState();
}

class MAResetPasswordScreensState extends State<MAResetPasswordScreens> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  bool isFocused= false;
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _show(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) => Padding(
          padding: EdgeInsets.only(
              top: 25,
              left: 25,
              right: 25,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/png/confetti-cone.png',fit: BoxFit.cover, width: 120,),
              30.height,
              Text(
                'Password has been changed successfully ',
                style: primaryTextStyle(color: black,size: 19),
                textAlign: TextAlign.center,
              ),
              50.height,

              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: GestureDetector(
                  onTap: () {
                    const MADashboardScreen().launch(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: context.width()/1.52,
                    height: 60,
                    decoration:  BoxDecoration(
                      borderRadius:  BorderRadius.circular(20.0),
                      color: const Color(0xFF121936),
                    ),
                    child: const Text('Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),),
                  ),
                ),
              ),
              16.height,
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {

    double customHeight= MediaQuery.of(context).size.height*0.1;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:  customHeight*0.9,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Image.asset("assets/png/material-arrow-back.png").onTap(() {
                    finish(context);
                  }),
                  const Text("Login" ,
                      style:  TextStyle(fontSize: 16,color: Color(0xFF700BE9), fontWeight: FontWeight.bold))
                ]),

              SizedBox(
                height:  customHeight*0.4,
              ),

              Text('Setup New Password',

                style: primaryTextStyle(color:Colors.black, size: 25,weight: FontWeight.w500 ),),

              SizedBox(
                height:  customHeight*0.5,
              ),
              nbAppTextFieldWidget(passwordController, 'Password', TextFieldType.PASSWORD, focus: passwordFocus),
              SizedBox(
                height:  customHeight*0.3,
              ),
              nbAppTextFieldWidget(passwordController, 'Confirm Password', TextFieldType.PASSWORD, focus: passwordFocus),

              SizedBox(
                height:  customHeight*1,
              ),


              GestureDetector(
                onTap: () {
                  _show(context);

                },
                child: Container(
                  alignment: Alignment.center,
                  width: context.width(),
                  height: 70,
                  decoration:  BoxDecoration(
                    borderRadius:  BorderRadius.circular(25.0),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7800F0),Color(0xFF00A088) ,  ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: const Text('Reset Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xffffffff),
                      letterSpacing: -0.3858822937011719,
                    ),),
                ),
              ),

              SizedBox(
                height:  customHeight*0.1,
              ),


            ],
          ).paddingOnly(left: 16, right: 16, bottom: 50),

        ),
      ),
    );
  }

  initializeLogin() async {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    final prefs = await SharedPreferences.getInstance();


    apiCall.loginUser(emailController.text.toString().trim(), passwordController.text.toString().trim(),)
        .then((value) {
      String? fullName=prefs.getString('fullName');
      String? photo=prefs.getString('photo');
      Fluttertoast.showToast(
        msg: "User successfully logged in",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      loader.Loader.hide();
      if(fullName != null && photo!=null){
        MADashboardScreen(fullName:fullName, photo:photo).launch(context);
      }


    }).catchError((err) {
      loader.Loader.hide();
      Fluttertoast.showToast(
        msg: err,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('Request not Sent');
    });
  }

  storeAccessDetails(String token) async {
    ///Stores the access token
    final prefs = await SharedPreferences.getInstance();
    // write
    prefs.setString('accessToken', token);
    // read
    final myString = prefs.getString('accessToken') ?? '';
  }

}
