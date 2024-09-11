import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/screens/ForgotPasswordScreens/MAForgotPasswordScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignUpScreen.dart';
import 'package:mantled_app/utils/MATextStyles.dart';
// import 'package:mantled_app/screens/OnboardingScreens/MADashboardScreen.dart';
// import 'package:mantled_app/screen/MAOtpVerificationScreen.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:mantled_app/screens/OnboardingScreens/MAForgotPasswordScreen.dart';
// import 'package:mantled_app/screens/OnboardingScreens/MASingUpScreen.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/utils/NBImages.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;

import '../DashboardScreens/MADashboardScreen.dart';

class MASignInScreen extends StatefulWidget {
  static String tag = '/MASignInScreen';

  const MASignInScreen({Key? key}) : super(key: key);

  @override
  MASignInScreenState createState() => MASignInScreenState();
}

class MASignInScreenState extends State<MASignInScreen> {

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
                height:  customHeight*0.7,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Image.asset("assets/png/material-arrow-back.png").onTap(() {
                    finish(context);
                  }),
                  Image.asset(logoImage),
                ],
              ),
              SizedBox(
                height:  customHeight*0.4,
              ),

              Text('Welcome,',

                style:  CustomTextStyle.semiBoldCustomTextStyle(context, 25, Colors.black ),),

              Text('Sign in to continue',
                  style: CustomTextStyle.secondaryCustomStyle(context,15)),


              SizedBox(
                height:  customHeight*0.9,
              ),
               nbAppTextFieldWidget(emailController, 'Email Address', TextFieldType.EMAIL, focus: emailFocus, nextFocus: passwordFocus),
              SizedBox(
                height:  customHeight*0.3,
              ),
              nbAppTextFieldWidget(passwordController, 'Password', TextFieldType.PASSWORD, focus: passwordFocus),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password?', style: secondaryTextStyle()).onTap(() {
                      const MAForgotPasswordScreen().launch(context);
                    })),
              ),

              SizedBox(
                height:  customHeight*0.3,
              ),


              GestureDetector(
                onTap: () {
                  initializeLogin();

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
                  child: const Text('Log In',
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

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Row(
                  children: [
                    const Divider(thickness: 2).expand(),
                    8.width,
                    Text('Or', style: secondaryTextStyle()),
                    8.width,
                    const Divider(thickness: 2).expand(),
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [

                    SizedBox(
                      height:  customHeight*0.3,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: (){
                          const MASignUpScreen().launch(context);
                        },
                        child: RichText(
                          text: const TextSpan(
                              text: "I am a new user? ",

                              style: TextStyle(fontSize: 16,color: Colors.black),
                              children: [
                                TextSpan(text: "Register" ,
                                    style:  TextStyle(fontSize: 16,color: Color(0xFF700BE9), fontWeight: FontWeight.bold))
                              ]),
                        ),
                      ),
                    ),
                  ],
                ).cornerRadiusWithClipRRect(20),
              ),

            ],
          ).paddingOnly(left: 16, right: 16, bottom: 50),

        ),
      ),
    );
  }

  initializeLogin() async {
    setState(() { });
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
