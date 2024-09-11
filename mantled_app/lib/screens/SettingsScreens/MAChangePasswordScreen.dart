import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInScreen.dart';
import 'package:mantled_app/utils/NBColors.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;

import '../../utils/MATextStyles.dart';


class MAChangePasswordScreen extends StatefulWidget {
  const MAChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _MAChangePasswordScreenState createState() => _MAChangePasswordScreenState();
}

class _MAChangePasswordScreenState extends State<MAChangePasswordScreen> {
  TextEditingController oldPassCont = TextEditingController();
  TextEditingController newPassCont = TextEditingController();
  TextEditingController confirmPassCont = TextEditingController();

  FocusNode oldPassFocus = FocusNode();
  FocusNode newPassFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();

  bool isBiometric= false;

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
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/succ1.png',fit: BoxFit.cover, width: 100,),
              30.height,
              Text(
                'Password Changed',
                style: boldTextStyle(color: black,size: 23),

                textAlign: TextAlign.center,
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: Text('For athletes, high altitude produces two contradictory.',
                  style: boldTextStyle(color:const Color(0xFF979DAC,), ),
                  textAlign: TextAlign.center,
                ),
              ),
              16.height,

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: AppButton(
                  onTap: () {
                    if(newPassCont!=confirmPassCont){
                    }
                    const MASignInScreen().launch(context);
                  },
                  color: NBPrimaryColor,
                  elevation: 0,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                          width: 1, color: NBPrimaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GO TO DASHBOARD",
                            style: boldTextStyle(size: 15, color: white)),
                        8.width,
                        const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: white,
                          size: 16,
                        )
                      ],
                    ),
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
      appBar:  AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,

        leading:  Image.asset("assets/png/material-arrow-back.png").onTap(() {
          finish(context);
        }),
        title: Text(
          "Security & Privacy",
          style: primaryTextStyle(size: 16, weight: FontWeight.w600),
        ),

        backgroundColor: white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: customHeight*0.3,
                ),
                Text('Change Password',

                  style:  CustomTextStyle.semiBoldCustomTextStyle(context, 21, Colors.black ),),


                SizedBox(
                  height: customHeight*0.5,
                ),
                nbAppTextFieldWidget(oldPassCont, 'Old Password', TextFieldType.PASSWORD, focus: oldPassFocus, nextFocus: newPassFocus),
                20.height,
                nbAppTextFieldWidget(newPassCont, 'New Password', TextFieldType.PASSWORD, focus: newPassFocus, nextFocus: confirmPassFocus),
                20.height,
                nbAppTextFieldWidget(confirmPassCont, 'Re-enter New Password', TextFieldType.PASSWORD, focus: confirmPassFocus),


                SizedBox(
                  height: customHeight*0.8,
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
                    child: const Text('Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),),
                  ),
                )
            // toasty(context, 'Password Changed Successfully');

              ],
            ).paddingAll(20),
          ),
        ],
      ),
    );
  }

  initializeChangePassword() {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    String oldPassword;String confirmPassword;
    oldPassword=oldPassCont.text;
    confirmPassword=confirmPassCont.text;
    apiCall.updatePassword(oldPassword,confirmPassword).then((value) {
      loader.Loader.hide();
      _show(context);
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
