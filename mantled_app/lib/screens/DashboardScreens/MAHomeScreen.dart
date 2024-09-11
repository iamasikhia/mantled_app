import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mantled_app/model/NBModel.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/SettingsScreens/MAEditProfileScreen.dart';
import 'package:mantled_app/utils/NBDataProviders.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/main.dart';

import 'package:provider/provider.dart';

import '../../model/assetOverviewModel.dart';
import '../../utils/MATextStyles.dart';
import '../../utils/NBImages.dart';
import '../OnboardingScreens/MACompleteProfileSuccess.dart';
// import 'MACompleteProfileSuccess.dart';

class MAHomeScreen extends StatefulWidget {
  static String tag = '/MAHomeScreen';
  final String? fullName;
  final String? photo;
  const MAHomeScreen({Key? key, this.fullName, this.photo}) : super(key: key);

  @override
  MAHomeScreenState createState() => MAHomeScreenState();
}

class MAHomeScreenState extends State<MAHomeScreen> {


  late Future fetchAssetOverview;
  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).fetchAssetOverview(context);
    fetchAssetOverview = getData();
  }

  Future getData() async {
    await Provider.of<Data>(context, listen: false)
        .fetchAssetOverview(context);
    var c = Provider.of<Data>(context, listen: false).assetOverview;
    return c;
  }


  List<AssetTypes> assets = allAssetTypes();
  int selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  double getHeight(double sysVar,double size){
    double calc=size/1000;
    return sysVar *calc;
  }

  double getTextSize(double sysVar,double size){
    double calc=size/10;
    return sysVar *calc;
  }

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    final textScale=MediaQuery.of(context).size.height * 0.01;
    final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: DraggableHome(
        appBarColor: const Color(0xFF121936),
        headerExpandedHeight: customHeight * 0.0050,
        alwaysShowLeadingAndAction: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome, ${widget.fullName!.split(' ')[0]} 👋',
              style:  TextStyle(
                  color: Colors.white, fontFamily: 'Poppins', fontSize: getTextSize(textScale,
                  20), fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: (){
                const MAEditProfileScreen().launch(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 0.0),
                child: Icon(
                  Icons.account_circle,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        headerWidget: headerWidget(context),
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child: SizedBox(
                child: SizedBox(
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    width: 40,
                    height: 5,
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.3,
                ),
                Text(
                  "My Assets",
                  style: boldTextStyle(color: Colors.black, size: 18),
                ),
                SizedBox(
                  height: customHeight * 0.3,
                ),
                listView(),
              ],
            ))),
          ),
        ],
        fullyStretchable: false,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    final textScale=MediaQuery.of(context).size.height * 0.01;
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    return Container(
        color: const Color(0xFF121936),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.photo != "Nothing"
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.network(

                          widget.photo!,
                          width: 100,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                         "assets/jpg/727399.png",
                          width: 100,
                        ),
                      ),
                GestureDetector(
                  onTap: (){
                    const MAEditProfileScreen().launch(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 0.0),
                    child: Icon(
                      Icons.account_circle,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            RichText(
              text: TextSpan(
                  text: 'Welcome, 👋 \n\n',
                  style: TextStyle(
                      color: Colors.white,fontSize: getTextSize(textScale,
                      35) , fontFamily: 'Poppins', fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "Your digital vault is securely encrypted.",
                        style: TextStyle(color: Colors.white, fontWeight:FontWeight.normal,fontFamily: 'Poppins',  fontSize:  getTextSize(textScale,
                            17)))
                  ]),
            ),
            SizedBox(
              height: customHeight * 0.01,
            ),
          ],
        ).paddingOnly(top: 20, bottom: 0, left: 20, right: 20));
  }

  Widget listView() {
    return FutureBuilder(
        future: fetchAssetOverview,
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.data==null) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          else  if (!snapshot.hasData) {
            return const Column(
              children: [
                Text(
                  "No data",
                  style: TextStyle(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            );
          }
          AssetOverviewModel overview = snapshot.data;
          return
          ListView.separated(
            padding: const EdgeInsets.only(top: 0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      child: Image.asset(assets[index].image),
                    ),
                    title: Text(assets[index].timePeriod,
                      style: CustomTextStyle.primaryCustomTextStyle1(context),),
                    subtitle: Text(assets[index].text,
                        style: CustomTextStyle.secondaryCustomTextStyle1(
                            context)),
                    trailing: RichText(
                      text: TextSpan(
                          text:
                          assets[index].timePeriod=="Real Estate"? "${overview.realEstate!}%\n":
                          assets[index].timePeriod=="Tangible Assets"? "${overview.tangibleAssets}%\n":
                          assets[index].timePeriod=="Debts and Liabilities"? "${overview.debtsAndLiabilities}%\n":
                          assets[index].timePeriod=="Personal Assets"? "${overview.personalAssets}%\n":
                          assets[index].timePeriod=="Financial Assets"? "${overview.financialAssets}%\n":
                          assets[index].timePeriod=="Others"? "${overview.others}%\n":
                          "${overview.realEstate}\n",
                          style: CustomTextStyle.boldCustomTextStyle1(context),
                          children: [
                            TextSpan(
                                text: "ASSETS", style: secondaryTextStyle())
                          ]),
                    ),
                  ),
                ),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 2,
              );
            },
          );
        });
      }
  }

