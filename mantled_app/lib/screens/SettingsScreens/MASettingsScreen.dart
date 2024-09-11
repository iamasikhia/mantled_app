

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/BeneficiaryScreens/MACreateBeneficiaryScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAInitializeAssetScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MAEditProfileScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MALawyerInfoScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MASecurityChoice.dart';
import 'package:mantled_app/screens/SettingsScreens/MASettingsBeneficiaryScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MASupportScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'MACreateLawyerScreen.dart';

class MASettingsScreen extends StatefulWidget {
  static String tag = '/MASettingsScreen';


  const MASettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  MASettingsScreenState createState() => MASettingsScreenState();
}

class MASettingsScreenState extends State<MASettingsScreen>
    with SingleTickerProviderStateMixin {
  String? otpPin;

  String? fullName;
  String? email;


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


  var images=["assets/png/profileMan.png", "assets/png/lawyer.png",
    "assets/png/beneficiary.png",  "assets/png/security.png",
    "assets/png/share.png",  "assets/png/support.png",  "assets/png/about.png",];

  Future<void> init() async {
    tabController = TabController(length: 2, vsync: this);
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
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

               Text("Beneficiary Details", style: primaryTextStyle(weight: FontWeight.w500),),
              30.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                alignment: Alignment.topLeft,
                decoration:  BoxDecoration(
                    borderRadius:  BorderRadius.circular(30.0),
                    color:  Color(colors[0]).withOpacity(0.1)
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(getInitials(beneficiaryNames[0]),
                    style: boldTextStyle(  color:  Color(colors[0])),),
                ),
              ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Olurotimi Ajao", textAlign: TextAlign.start,),
                        Text(
                            "Sent 10th Jun. 2022", textAlign: TextAlign.start,),

                      ],
                    ),
                  ),
                ],
              ),
              30.height,
              Text(
                'RELATIONSHIP',
                style: secondaryTextStyle(),
                textAlign: TextAlign.start,
              ),
              Text(
                'Sister',
                style: primaryTextStyle(color: black,size: 16),

                textAlign: TextAlign.start,
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PHONE NUMBER 1',
                    style: secondaryTextStyle(),
                    textAlign: TextAlign.start,
                  ),
                  Text("CALL NUMBER", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
                  size: 13,  weight: FontWeight.w500), )
                ],
              ),
              Text(
                '09023457910',
                style: primaryTextStyle(color: black,size: 16),
                textAlign: TextAlign.start,
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EMAIL ADDRESS',
                    style: secondaryTextStyle(),
                    textAlign: TextAlign.start,
                  ),
                  Text("SEND EMAIL", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
                      size: 13,  weight: FontWeight.w500), )
                ],
              ),
              Text(
                'suzzypasty@realbinxyz.africa',
                style: primaryTextStyle(color: black,size: 16),

                textAlign: TextAlign.start,
              ),
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HOUSE ADDRESS',
                    style: secondaryTextStyle(),
                    textAlign: TextAlign.start,
                  ),
                  Text("GET DIRECTIONS", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
                      size: 13,  weight: FontWeight.w500), )
                ],
              ),
              Text(
                '20a Beckley Avenue',
                style: primaryTextStyle(color: black,size: 16),

                textAlign: TextAlign.start,
              ),
              50.height,

            ],
          ),
        ));
  }

  var beneficiaryNames=["Gideon Runsewe", "Pelumi Jegede", "Dele Martins", "Asikhia Iseoluwa" ];
  var colors=[0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D,
    0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41];

  var settingsObject=[
    {
      "name":"Profile Management",
      "image":"assets/png/profileMan.png",
      "subName": "Customise & update your profile"
    },
    {
      "name":"My Lawyer",
      "image":"assets/png/lawyer.png",

      "subName": "Manage lawyer details"
    },
    // {
    //   "name":"Beneficiaries",
    //   "image":"assets/png/beneficiary.png",
    //   "subName": "Manage your saved beneficiaries"
    // },
    {
      "name":"Security & Privacy",
      "image":"assets/png/security.png",
      "subName": "Set your security preferences"
    },
    // {
    //   "name":"Share App",
    //   "image":"assets/png/share.png",
    //   "function": const MACreateBeneficiaryScreen(),
    //   "subName": "Share with family and friends"
    // },
    {
      "name":"Contact us",
      "image":"assets/png/support.png",
      "subName": "24/7 customer support"
    },

  ];

  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(

      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 18),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height:  customHeight*0.6,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Settings',
                      style: boldTextStyle(color:Colors.black, size: 25,weight: FontWeight.bold ),),

                    SizedBox(
                      height:  customHeight*0.4,
                    ),


                  ],
                ),
              ),

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
                              index==0? const MAEditProfileScreen().launch(context):
                              index==1? const MACreateLawyerScreen().launch(context):
                            //  index==2? const MASettingsBeneficiaryScreen().launch(context):
                              index==2? const MASecurityChoice().launch(context):
                            //  index==4? const MAEditProfileScreen().launch(context):
                              index==3? const MASupportScreen().launch(context):
                             null;
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
