
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/BeneficiaryScreens/MACreateBeneficiaryScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAInitializeAssetScreen.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MAChangePasswordScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MAChangePinScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MAEditProfileScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MALawyerInfoScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MASettingsBeneficiaryScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

import '../../networking/rest_data.dart';
import '../../utils/NBColors.dart';

class MASecurityChoice extends StatefulWidget {
  static String tag = '/MASecurityChoice';


  const MASecurityChoice({
    Key? key,
  }) : super(key: key);

  @override
  MASecurityChoiceState createState() => MASecurityChoiceState();
}

class MASecurityChoiceState extends State<MASecurityChoice>
    with SingleTickerProviderStateMixin {
  String? otpPin;

  String? fullName;
  String? email;

  TextEditingController oldPassCont = TextEditingController();
  TextEditingController newPassCont = TextEditingController();
  TextEditingController confirmPassCont = TextEditingController();

  FocusNode oldPassFocus = FocusNode();
  FocusNode newPassFocus = FocusNode();
  FocusNode confirmPassFocus = FocusNode();

  String getInitials(bank_account_name) {
    List<String> names = bank_account_name.split(" ");
    String initials = "";
    int numWords = 2;

    if(numWords < names.length) {
      numWords = names.length;
    }
    for(var i = 0; i < numWords; i++){
      initials += '${names[i][0]}';
    }
    return initials;
  }
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

  var images=["assets/png/profileMan.png", "assets/png/lawyer.png",
    "assets/png/beneficiary.png",  "assets/png/security.png",
    "assets/png/share.png",  "assets/png/support.png",  "assets/png/about.png",];

  Future<void> init() async {
    tabController = TabController(length: 2, vsync: this);
  }

  var beneficiaryNames=["Gideon Runsewe", "Pelumi Jegede", "Dele Martins", "Asikhia Iseoluwa" ];
  var colors=[0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D,
    0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41];

  var settingsObject=[
    {
      "name":"Change PIN",
      "image":"assets/png/profileMan.png",
      "subName": "Manage your app PIN"
    },
    {
      "name":"Change Password",
      "image":"assets/png/lawyer.png",
      "subName": "Manage your password"
    },


  ];

  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
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
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[



              SizedBox(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  itemCount: settingsObject.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 8, top: 8, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child:  Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(settingsObject[index]["image"].toString())
                                ),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(' ${settingsObject[index]["name"].toString()}',
                                    style: boldTextStyle(size: 15),),
                                  Text(settingsObject[index]["subName"].toString(),
                                    style: secondaryTextStyle(size: 12),)

                                ],
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap: (){
                              index==0? const MAChangePinScreen().launch(context):
                              const MAChangePasswordScreen().launch(context);

                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(10.0),
                                    color:  Colors.grey.withOpacity(0.2)
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.arrow_forward_ios_outlined, size: 13,),
                                )),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }


}
