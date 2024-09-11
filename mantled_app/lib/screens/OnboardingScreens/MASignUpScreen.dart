import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mantled_app/model/sign_up_user.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInScreen.dart';
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

import '../../utils/MATextStyles.dart';
import 'MAOtpVerificationScreen.dart';

class MASignUpScreen extends StatefulWidget {
  static String tag = '/MASignUpScreen';

  const MASignUpScreen({Key? key}) : super(key: key);

  @override
  MASignUpScreenState createState() => MASignUpScreenState();
}

class MASignUpScreenState extends State<MASignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
    setStatusBarColor(transparentColor, statusBarIconBrightness: Brightness.dark);
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    double customHeight= MediaQuery.of(context).size.height*0.1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height:  customHeight*0.6,
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

              Text('Create Account,',

                style: CustomTextStyle.semiBoldCustomTextStyle(context, 25,Colors.black ),),

              Text('Set up your digital vault now to secure your valuable assets. ',
                  style: primaryTextStyle(color: Colors.black54)),


              SizedBox(
                height:  customHeight*0.5,
              ),
              nbAppTextFieldWidget(nameController, 'Full Name', TextFieldType.NAME,),
              16.height,
              nbAppTextFieldWidget(emailController, 'Email Address', TextFieldType.EMAIL, ),
              16.height,
              IntlPhoneField(
                controller: phoneController,

                decoration:   InputDecoration(
                  contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
                  filled: true,
                  labelText: "Phone Number",
                  fillColor: Colors.white.withOpacity(0.1),
                  hintText: "Phone Number",
                  labelStyle:secondaryTextStyle(size: 15) ,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.2) , width: 2),//border Color
                  ),
                  hintStyle: secondaryTextStyle(),
                  enabledBorder:  OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(30.0),
                    borderSide:  BorderSide(color: Colors.grey.withOpacity(0.2) ,width:2),

                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(30.0),
                    borderSide:  const BorderSide(color:  NBPrimaryColor ,width: 2 ),

                  ),
                ),
                initialCountryCode: 'NG',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              6.height,
              nbAppTextFieldWidget(passwordController, 'Password', TextFieldType.PASSWORD, focus: passwordFocus),
              16.height,


              SizedBox(
                height:  customHeight*0.3,
              ),


              GestureDetector(
                onTap: () {

                  if( emailController.text.isNotEmpty  && passwordController.text.isNotEmpty
                  && nameController.text.isNotEmpty  &&  phoneController.text.isNotEmpty){
                    initializeSignUp();
                  }
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
                  child: const Text('Create Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xffffffff),
                      letterSpacing: -0.3858822937011719,
                    ),),
                ),
              ),

              SizedBox(
                height:  customHeight*0.3,
              ),
              GestureDetector(
                onTap: () {
                  MASignInScreen().launch(context);

                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                        text: "I am already a member,",

                        style: TextStyle(fontSize: 16,color: Colors.black),
                        children: [
                          TextSpan(text: " Sign In" ,
                              style:  TextStyle(fontSize: 16,color: Color(0xFF700BE9), fontWeight: FontWeight.bold))
                        ]),
                  ),
                ),
              ),
            ],
          ).paddingOnly(left: 16, right: 16, bottom: 50),

        ),
      ),
    );
  }

  storeSignUpDetails(String token) async {
    ///Stores the access token
    final prefs = await SharedPreferences.getInstance();
    // write
    prefs.setString('accessToken', token);
    // read
    final myString = prefs.getString('accessToken') ?? '';
  }

  initializeSignUp() {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    var signUpUser = SignUpUser();
    var emailVal= emailController.text;
    signUpUser.email = emailController.text;
    signUpUser.password = passwordController.text;
    signUpUser.fullName = nameController.text;
    signUpUser.phoneNumber = phoneController.text;
    apiCall.createUser(signUpUser).then((value) {
      Fluttertoast.showToast(
        msg: "User successfully signed up",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      loader.Loader.hide();
      MAVerificationScreen(email: emailController.text,).launch(context);

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
}
