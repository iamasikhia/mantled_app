
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateFinancialAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateOthersAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreatePersonalAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateRealEstateAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateTangibleAssetScreen.dart';
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

import '../../utils/NBColors.dart';
import '../../utils/NBImages.dart';
import '../MACreateAssetScreens/MACreateDebtsAssetsScreen.dart';


class MAInitializeAssetScreen extends StatefulWidget {
  static String tag = '/MAInitializeAssetScreen';

  const MAInitializeAssetScreen({Key? key, }) : super(key: key);

  @override
  MAInitializeAssetScreenState createState() => MAInitializeAssetScreenState();
}

class MAInitializeAssetScreenState extends State<MAInitializeAssetScreen> {
  String? otpPin;

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
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height:  customHeight*0.8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Image.asset("assets/png/material-arrow-back.png").onTap(() {
                  finish(context);
                }),

              ],
            ),
            SizedBox(
              height:  customHeight*0.4,
            ),

            Text('Choose Asset',

              style: boldTextStyle(color:Colors.black, size: 28, ),),
            SizedBox(
              height:  customHeight*0.1,
            ),
            Text(
              'What type of asset do you want to add',
              style: primaryTextStyle(color: Colors.black54,size: 15),

              textAlign: TextAlign.center,
            ),


            SizedBox(
              height:  customHeight*0.5,
            ),

            SingleChildScrollView(
              child: ListView(
                padding: const EdgeInsets.only(top: 20),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(

                            title: const Text("Real Estate"),
                            trailing:
                            Image.asset("assets/png/arrow_foward.png").onTap(() {
                              const MACreateRealEstateAssetScreen(assetType: "real_estate",).launch(context);
                            }),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(

                            title: const Text("Tangible Assets"),

                            trailing:
                            Image.asset("assets/png/arrow_foward.png").onTap(() {
                              const MACreateTangibleAssetScreen(assetType: "tangible_assets").launch(context);
                            }),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(

                            title: const Text("Personal Effects"),
                            trailing:
                            Image.asset("assets/png/arrow_foward.png").onTap(() {
                              const MACreatePersonalAssetScreen(assetType: "personal_assets").launch(context);
                            }),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(

                            title: const Text("Financial Assets"),

                            trailing:
                            Image.asset("assets/png/arrow_foward.png").onTap(() {
                              const MACreateFinancialAssetScreen(assetType: "financial_assets").launch(context);
                            }),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(

                            title: const Text("Debts & Liabilities"),

                            trailing:
                            Image.asset("assets/png/arrow_foward.png").onTap(() {
                              const MACreateDebtsAssetsScreen(assetType: "debts_and_liabilities").launch(context);
                            }),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ListTile(

                          title: const Text("Others"),

                          trailing:
                          Image.asset("assets/png/arrow_foward.png").onTap(() {
                            const MACreateOthersAssetScreen(assetType: "others").launch(context);
                          }),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            16.height,
          ],
        ).paddingAll(20),
      ),
    );
  }

}
