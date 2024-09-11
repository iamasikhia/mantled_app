
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInSuccess.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignUpScreen.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart' as otp;
import 'package:otp_text_field/otp_field_style.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:otp_text_field/style.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/main.dart';

import 'package:mantled_app/networking/rest_data.dart';

import 'package:slide_countdown/slide_countdown.dart';
import '../../utils/NBColors.dart';
import '../../utils/NBImages.dart';


class MAVerificationScreen extends StatefulWidget {
  static String tag = '/MAVerificationScreen';
  final String email;
  const MAVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  MAVerificationScreenState createState() => MAVerificationScreenState();
}

class MAVerificationScreenState extends State<MAVerificationScreen> {
 String? otpPin;

  @override
  void initState() {
     super.initState();

    init();
  }

  Future<void> init() async {
    //
  }
   bool timeIsUp=false;

  setCountDown(){
  setState(() {
    timeIsUp=true;
  });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double customHeight= MediaQuery.of(context).size.height*0.1;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height:  customHeight*0.5,
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

            Text('Verify your Account,',

              style: primaryTextStyle(color:Colors.black, size: 25,weight: FontWeight.w500 ),),
            SizedBox(
              height:  customHeight*0.1,
            ),
            Text(
              'A 4-digit OTP has been sent to your '
                  '\n email ${widget.email}',
              style: primaryTextStyle(color: Colors.black54,size: 15),

              textAlign: TextAlign.center,
            ),


            SizedBox(

              height:  customHeight*0.5,
            ),

            Center(
              child: Wrap(
                children: [
                  SizedBox(
                    height: 80,
                    child: otp.OTPTextField(
                      length: 4,
                      width: context.width(),

                      fieldWidth: 70,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                      style: boldTextStyle(size: 24, color: NBPrimaryColor),
                      textFieldAlignment: MainAxisAlignment.spaceBetween,
                      fieldStyle: FieldStyle.box,
                      otpFieldStyle: OtpFieldStyle(
                        focusBorderColor:  NBPrimaryColor,
                        borderColor: Colors.grey.withOpacity(0.8),
                        backgroundColor: Colors.white.withOpacity(0.1),
                        enabledBorderColor: Colors.grey.withOpacity(0.8),
                      ),
                      onChanged: (value) {},
                      onCompleted: (value) {
                        setState((){
                          otpPin= value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height:  customHeight*0.6,
            ),

            GestureDetector(
              onTap: () {
                const HLSignInSuccess().launch(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: context.width(),
                height: 60,
                decoration:  BoxDecoration(
                  borderRadius:  BorderRadius.circular(20.0),
                  color: NBPrimaryColor
                ),
                child: const Text('Verify Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xffffffff),
                    letterSpacing: -0.3858822937011719,
                  ),),
              ),
            ),

            SizedBox(
              height:  customHeight*0.4,
            ),
            Column(
              //    mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('I didn\'t get an OTP?.', style: primaryTextStyle(color: Colors.black, weight: FontWeight.w600)),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !timeIsUp? Text('Resend in ',
                        style: primaryTextStyle(color: Colors.black, weight: FontWeight.w600),
                        textAlign: TextAlign.center): Container(),
                     SlideCountdown(
                      decoration: const BoxDecoration(
                        color: Colors.transparent
                      ),

                      replacement:    GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          width: context.width()/5,
                          height: 50,
                          decoration:  BoxDecoration(

                              borderRadius:  BorderRadius.circular(20.0),
                              color: Colors.transparent
                          ),
                          child: const Text('Resend',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: NBPrimaryColor,
                              letterSpacing: -0.3858822937011719,
                            ),),
                        ),
                      ),
                      textStyle: const TextStyle(color: NBPrimaryColor, fontSize: 18,
                          fontWeight: FontWeight.bold),
                      duration: Duration(minutes: 3),
                      separatorStyle:TextStyle(color: NBPrimaryColor),
                      separatorType: SeparatorType.title,
                      slideDirection: SlideDirection.up,
                      onDone: setCountDown()
                    )
                  ],
                ),
                20.height,

              ],
            ),
            16.height,
          ],
        ).paddingAll(30),
      ),
    );
  }
  confirmCode(String code) async {
    print(code);
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    int convertedCode = code.toInt();
    final prefs = await SharedPreferences.getInstance();
    int? numberVerification = prefs.getInt('numberVerification');
    print(numberVerification);
    var apiCall = RestDataSource();
    if (convertedCode == numberVerification) {
      print(convertedCode);
      print(numberVerification);

    apiCall.verifyUser(convertedCode)
        .then((value) {
      loader.Loader.hide();
      bottomsheet.showCupertinoModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => const HLSignInSuccess(),
      );
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
}
