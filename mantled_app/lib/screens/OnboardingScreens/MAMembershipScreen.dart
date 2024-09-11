
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/model/NBModel.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInScreen.dart';

import 'package:mantled_app/utils/NBDataProviders.dart';
import 'package:mantled_app/utils/NBWidgets.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/main.dart';

import '../../utils/NBImages.dart';
import '../DashboardScreens/MADashboardScreen.dart';
import 'MACompleteProfileSuccess.dart';


class MAMembershipScreen extends StatefulWidget {
  static String tag = '/MAMembershipScreen';

  const MAMembershipScreen({Key? key}) : super(key: key);

  @override
  MAMembershipScreenState createState() => MAMembershipScreenState();
}

class MAMembershipScreenState extends State<MAMembershipScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }
  List<NBMembershipPlanItemModel> membershipPlanList = nbGetMembershipPlanItems();
  int selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double customHeight= MediaQuery.of(context).size.height*0.1;
    setStatusBarColor(transparentColor, statusBarIconBrightness: Brightness.dark);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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

                Text('Choose your plan',

                  style: primaryTextStyle(color:Colors.black, size: 25,weight: FontWeight.w500 ),),

                Text('Select the right plan that meets your need',
                    style: primaryTextStyle(color: Colors.black54)),

              ],
            ).paddingAll(20),


            SizedBox(
              height: customHeight*0.2,
            ),

            20.height,
            Container(
              height: MediaQuery.of(context).size.height*0.8,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                color: const Color(0xFF121936),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: NBPrimaryColor.withOpacity(0.2),
                    width: 2),
              ),
              child: Column(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: membershipPlanList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 20,

                      childAspectRatio: MediaQuery.of(context).size.height /
                          (MediaQuery.of(context).size.height / 2.6),

                    ),
                    itemBuilder: (context, index) {
                      return Container(
                       // height: MediaQuery.of(context).size.height*0.3,
                        decoration: boxDecorationWithRoundedCorners(
                          backgroundColor: index == selectedIndex ?  Colors.transparent: const Color(0xFF000000).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: index == selectedIndex ? const Color(0xFF00BF3D) : grey.withOpacity(0.2), width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(

                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(membershipPlanList[index].timePeriod, style: boldTextStyle(size: 16, color:const Color(0xFF00BF3D))),
                                  8.height,
                                  Text(membershipPlanList[index].price, style: boldTextStyle(size: 20,color: Colors.white)),
                                  8.height,
                                  Text("Set up your digital vault now to secure", style: secondaryTextStyle(color: Colors.white)),

                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: index == selectedIndex ? const Color(0xFF00BF3D) : grey.withOpacity(0.1), shape: BoxShape.circle),
                                child:Container(),
                              ),
                            ],
                          ),
                        ),
                      ).onTap(() {
                        setState(() {
                          selectedIndex = index;
                        });
                      });
                    },
                  ),
                  SizedBox(
                    height: customHeight*0.4,
                  ),

                  GestureDetector(
                    onTap: () {
                      initializeCompleteProfile();
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Select this plan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xffffffff),
                              letterSpacing: -0.3858822937011719,
                            ),),
                          Icon(Icons.arrow_forward, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),




          ],
        )
      ),
    );
  }

  initializeCompleteProfile() async {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();

    var completeProfile = CompleteProfile();
    completeProfile.paymentPlanText = membershipPlanList[selectedIndex].timePeriod;
    completeProfile.paymentPlanAmount = membershipPlanList[selectedIndex].price;
    final prefs = await SharedPreferences.getInstance();
    String? fullName=prefs.getString('fullName');
    String? photo=prefs.getString('photo');
    apiCall.updateMembership(completeProfile).then((value) {
      Fluttertoast.showToast(
        msg: "Profile Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      loader.Loader.hide();

      const MACompleteProfileSuccess().launch(context);

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
