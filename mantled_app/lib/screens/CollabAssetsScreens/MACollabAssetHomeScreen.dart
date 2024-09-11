import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mantled_app/model/IndividualAssetListModel.dart';
import 'package:mantled_app/model/NBModel.dart';
import 'package:mantled_app/model/addbeneficiaryModel.dart';
import 'package:mantled_app/model/assetDetailModel.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetDetailsScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetDocuments.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabBeneficiaries.dart';
import 'package:mantled_app/utils/NBDataProviders.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class MACollabAssetHomeScreen extends StatefulWidget {
  static String tag = '/MACollabAssetHomeScreen';
  final String userID;
  final String assetType;
  final String lastModified;

  const MACollabAssetHomeScreen({Key? key, required this.assetType, required this.lastModified, required this.userID, }) : super(key: key);

  @override
  MACollabAssetHomeScreenState createState() => MACollabAssetHomeScreenState();
}

class MACollabAssetHomeScreenState extends State<MACollabAssetHomeScreen> {
  late Future assetDetailsAssets;
  late Future assetDetailsBeneficiary;

  @override
  void initState() {
    super.initState();
    init();
    Provider.of<Data>(context, listen: false).fetchAssetDetailsAssets(context,widget.userID,widget.assetType!);
    assetDetailsAssets = getAssetDetailsAssets();

    Provider.of<Data>(context, listen: false).fetchAssetDetailsBeneficiary(context,widget.userID,widget.assetType!);
    assetDetailsBeneficiary = getAssetDetailsBeneficiary();

  }

  Future getAssetDetailsAssets() async {
    await Provider.of<Data>(context, listen: false).fetchAssetDetailsAssets(context,widget.userID, widget.assetType);
    var c = Provider.of<Data>(context, listen: false).assetDetailsAssetsList;
    return c;
  }

  Future getAssetDetailsBeneficiary() async {
    await Provider.of<Data>(context, listen: false).fetchAssetDetailsBeneficiary(context,widget.userID, widget.assetType);
    var c = Provider.of<Data>(context, listen: false).assetDetailsBeneficiaryList;
    return c;
  }



  var beneficiaryNames=["Gideon Runsewe", "Pelumi Jegede", "Dele Martins", "Asikhia Iseoluwa" ];
  var colors=[0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D,
    0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41];
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
  void _showBeneDetails(BuildContext ctx,  AddBeneficiary mData) {
    DateTime dt = DateTime.parse(mData.createdAt!);
    print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
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
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mData.fullName!, textAlign: TextAlign.start,),
                        Text(
                          DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt), textAlign: TextAlign.start,),

                      ],
                    ),
                  ),
                ],
              ),
              30.height,
              // Text(
              //   'RELATIONSHIP',
              //   style: secondaryTextStyle(),
              //   textAlign: TextAlign.start,
              // ),
              // Text(
              //   'Sister',
              //   style: primaryTextStyle(color: black,size: 16),
              //
              //   textAlign: TextAlign.start,
              // ),
              // 20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PHONE NUMBER ',
                    style: secondaryTextStyle(),
                    textAlign: TextAlign.start,
                  ),
                  Text("CALL NUMBER", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
                      size: 13,  weight: FontWeight.w500), )
                ],
              ),
              Text(
                  mData.phoneNumber! ,
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
                mData.emailAddress! ,
                style: primaryTextStyle(color: black,size: 16),

                textAlign: TextAlign.start,
              ),
              50.height,
              // // Row(
              // //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //   children: [
              // //     Text(
              // //       'HOUSE ADDRESS',
              // //       style: secondaryTextStyle(),
              // //       textAlign: TextAlign.start,
              // //     ),
              // //     Text("GET DIRECTIONS", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
              // //         size: 13,  weight: FontWeight.w500), )
              // //   ],
              // // ),
              // Text(
              //   '20a Beckley Avenue',
              //   style: primaryTextStyle(color: black,size: 16),
              //
              //   textAlign: TextAlign.start,
              // ),


            ],
          ),
        ));
  }

  Future<void> init() async {
    //
  }
  List<AssetTypes> assets = assetsItems();
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


    return Scaffold(

      body: DraggableHome(
        appBarColor:

       Colors.white,
        headerExpandedHeight: customHeight*0.0058,
        alwaysShowLeadingAndAction:false,
        leading:  Image.asset("assets/png/material-arrow-back.png").onTap(() {
          finish(context);
        }),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,

          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const SizedBox(width: 10,),
                widget.assetType == 'real_estate'?Image.asset("assets/png/homeIcon.png"):
                widget.assetType == 'tangible_assets'?Image.asset("assets/png/tangible_new.png"):
                widget.assetType == 'personal_assets'?Image.asset("assets/png/personal.png"):
                widget.assetType == 'financial_assets'?Image.asset("assets/png/financial.png"):
                widget.assetType == 'debts_and_liabilities'?Image.asset("assets/png/homeIcon.png"):
                Image.asset("assets/png/homeIcon.png")
              ],
            ),
          ],
        ),

        headerWidget: headerWidget(context),
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
            child: SizedBox(child: SizedBox(child: Column(
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
                  height: customHeight * 0.2,
                ),
                Text("My Assets", style: boldTextStyle(color: Colors.black, size: 18), ),
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
    DateTime dt = DateTime.parse(widget.lastModified);
    print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
    return Container(
        color:     Colors.grey.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: customHeight * 0.01,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Image.asset("assets/png/material-arrow-back.png").onTap(() {
                  finish(context);
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    widget.assetType=="real_estate"?const Text("Real Estate"):
                    widget.assetType=="tangible_assets"?const Text("Tangible Asset"):
                    widget.assetType=="personal_assets"?const Text("Personal Asset"):
                    widget.assetType=="financial_assets"?const Text("Financial Asset"):
                    widget.assetType=="debts_and_liabilities"?const Text("Debts and Liabilities"):
                    const Text("Other") ,
                    const SizedBox(width: 10,),
                    widget.assetType == 'real_estate'?Image.asset("assets/png/homeIcon.png"):
                    widget.assetType == 'tangible_assets'?Image.asset("assets/png/tangible_new.png"):
                    widget.assetType == 'personal_assets'?Image.asset("assets/png/personal.png"):
                    widget.assetType == 'financial_assets'?Image.asset("assets/png/financial.png"):
                    widget.assetType == 'debts_and_liabilities'?Image.asset("assets/png/homeIcon.png"):
                    Image.asset("assets/png/homeIcon.png")
                  ],
                ),
              ],
            ),

             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.assetType == 'real_estate'? Text("Real \nEstate",
                      style: TextStyle( fontFamily: 'Poppins', fontSize: getTextSize(textScale,
                          35),fontWeight: FontWeight.bold),):
                    widget.assetType == 'tangible_assets'?Text("Tangible \nAssets",
                      style: TextStyle( fontFamily: 'Poppins', fontSize: getTextSize(textScale,
                          35),fontWeight: FontWeight.bold),):
                    widget.assetType == 'personal_assets'? Text("Personal \nAssets",
                      style: TextStyle(fontSize: getTextSize(textScale,
                          35), fontWeight: FontWeight.bold),):
                    widget.assetType == 'financial_assets'? Text("Financial \nAssets",
                      style: TextStyle(fontSize: getTextSize(textScale,
                          35),fontWeight: FontWeight.bold),):
                    widget.assetType == 'debts_and_liabilities'? Text("Debts & \nLiabilities",
                      style: TextStyle(fontSize: getTextSize(textScale,
                          35), fontWeight: FontWeight.bold),):
                     Text("Other\nAssets",
                      style: TextStyle(fontSize: getTextSize(textScale,
                          35),fontWeight: FontWeight.bold),),
                    //
                    // Container(
                    //   alignment: Alignment.center,
                    //   width: 120,
                    //   height: 40,
                    //   decoration:  BoxDecoration(
                    //       borderRadius:  BorderRadius.circular(10.0),
                    //       color: const Color(0xFFF5F0FF)
                    //   ),
                    //   child:  Text('3 New Updates',
                    //     style: primaryTextStyle(size: 13,  weight: FontWeight.w500, color: const Color(0xFF700BE9)),),
                    // ),

                  ],
                ),

                // RichText(
                //   text:  TextSpan(
                //       text: 'Real \n',
                //
                //       style:  boldTextStyle(
                //           color: Colors.black, size: 45, weight: FontWeight.w700),
                //       children: [
                //         TextSpan(text: "Estate" ,
                //             style:   boldTextStyle(color: Colors.black,  weight: FontWeight.w700 ,size: 45))
                //       ]),
                // ),
                5.height,
                 Text("Last updated ${DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt)}"),
              ],
            ),


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("ADDED BENEFICIARIES",style: primaryTextStyle(color: Colors.black, size: 13, weight: FontWeight.w500), ),
            //     GestureDetector(
            //       onTap: (){
            //          MACollabBeneficiaries(userID:widget.userID, assetType:widget.assetType).launch(context);
            //       },
            //         child: Text("VIEW MORE",style: primaryTextStyle(color: const Color(0xFF7800F0, ), size: 13,  weight: FontWeight.w500), )),
            //   ],
            // ),

            FutureBuilder(
                future: assetDetailsBeneficiary,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  else if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text(
                          "No Beneficiaries",
                          style: TextStyle(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }
                  List<AddBeneficiary> beneficiariesList = snapshot.data;
                return Container(
                  height: 150,
                  child: ListView.separated(
                      padding: const EdgeInsets.only(top: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: beneficiariesList.length,
                      shrinkWrap: true,
                      scrollDirection:Axis.horizontal,
                      itemBuilder: (context, index) {
                        AddBeneficiary mData = beneficiariesList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: GestureDetector(
                          onTap: (){
                            _showBeneDetails(context, mData);
                          },
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(30.0),
                                    color: const Color(0xFF0496FF).withOpacity(0.1)
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Text(getInitials(mData.fullName!.toUpperCase()),
                                    style: boldTextStyle(  color: const Color(0xFF0496FF)),),
                                ),
                              ),
                              5.height,
                               Text(mData.fullName!),
                            ],
                          ),
                        ),
                      );
                    }, separatorBuilder:
                      (BuildContext context, int index) {
                    return  Container(

                    );
                  }
                  ),
                );
              }
            ),


          ],
        ).paddingOnly(top: 20, bottom: 0, left: 20, right: 20));
  }

  Widget listView() {

    return  FutureBuilder(
        future: assetDetailsAssets,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          else if (!snapshot.hasData) {
            return const Column(
              children: [
                Text(
                  "No Beneficiaries",
                  style: TextStyle(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            );
          }
          List<AssetDetailModel> assetList = snapshot.data;
          if(assetList.isEmpty){
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No Assets Here",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }
        return ListView.separated(
          padding: const EdgeInsets.only(top: 0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: assetList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            AssetDetailModel mData = assetList[index];
            DateTime dt = DateTime.parse(mData.assetDateAdded!);
            print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
             return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () {
                     MACollabAssetDocuments(assetID:mData.assetID!, assetName:mData.assetName!, assetDateAdded:mData.assetDateAdded!).launch(context);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.asset("assets/png/file.png"),
                    ),
                    title: Text(mData.assetName!),
                    subtitle: Text(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt)),
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
          return const Divider(thickness: 2,);
        },
        );
      }
    );
  }


}
