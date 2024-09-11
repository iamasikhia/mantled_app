
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/BeneficiaryScreens/MACreateBeneficiaryScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAInitializeAssetScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MAChangePasswordScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MAChangePinScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MAEditProfileScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MALawyerInfoScreen.dart';
import 'package:mantled_app/screens/SettingsScreens/MASettingsBeneficiaryScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MASupportScreen extends StatefulWidget {
  static String tag = '/MASupportScreen';


  const MASupportScreen({
    Key? key,
  }) : super(key: key);

  @override
  MASupportScreenState createState() => MASupportScreenState();
}

class MASupportScreenState extends State<MASupportScreen>
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

  var beneficiaryNames=["Gideon Runsewe", "Pelumi Jegede", "Dele Martins", "Asikhia Iseoluwa" ];
  var colors=[0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D,
    0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41];

  var settingsObject=[
    {
      "name":"Send us an email",
      "image":"assets/jpg/envelope.png",
      "subName": "bemantled.mantled@gmail.com"
    },

    {
      "name":"Chat Us On Whatsapp",
      "image":"assets/jpg/comment.png",
      "subName": "+234 802 303 4723"
    },



  ];

  TabController? tabController;
  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,

        leading:  Image.asset("assets/png/material-arrow-back.png").onTap(() {
          finish(context);
        }),
        title: Text(
          "Support & Help Desk",
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
                      padding: const EdgeInsets.only(left: 10.0, right: 18, top: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(30.0),
                                    color:  const Color(0xFFF4EDFF)
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Image.asset(settingsObject[index]["image"].toString())
                                ),
                              ),
                              10.width,
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
                          //
                          // GestureDetector(
                          //   onTap: (){
                          //     // index==0? const MAChangePinScreen().launch(context):
                          //     // const MAChangePasswordScreen().launch(context);
                          //
                          //   },
                          //   child: Container(
                          //       alignment: Alignment.center,
                          //       decoration:  BoxDecoration(
                          //           borderRadius:  BorderRadius.circular(10.0),
                          //           color:  Colors.grey.withOpacity(0.2)
                          //       ),
                          //       child: const Padding(
                          //         padding: EdgeInsets.all(8.0),
                          //         child: Icon(Icons.arrow_forward_ios_outlined, size: 13,),
                          //       )),
                          // )
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
