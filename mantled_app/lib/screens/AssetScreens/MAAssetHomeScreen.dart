import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mantled_app/model/CollaboratorListModel.dart';
import 'package:mantled_app/model/IndividualAssetListModel.dart';
import 'package:mantled_app/model/NBModel.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:mantled_app/model/assetDetailModel.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/screens/AssetScreens/MAEditAssetsScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/CreateCollabScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateDebtsAssetsScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateFinancialAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateOthersAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreatePersonalAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateRealEstateAssetScreen.dart';
import 'package:mantled_app/screens/MACreateAssetScreens/MACreateTangibleAssetScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:badges/badges.dart' as badges;
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetDetailsScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetDocuments.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabBeneficiaries.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/utils/NBDataProviders.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class MAAssetHomeScreen extends StatefulWidget {
  static String tag = '/MAAssetHomeScreen';

  final String assetType;

  final Color color;

  const MAAssetHomeScreen({Key? key, required this.assetType, required this.color, }) : super(key: key);

  @override
  MAAssetHomeScreenState createState() => MAAssetHomeScreenState();
}

class MAAssetHomeScreenState extends State<MAAssetHomeScreen> {
  late Future personalAssets;
  late Future collaborators;

  @override
  void initState() {
    super.initState();
    init();
   Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, widget.assetType);
    personalAssets = getPersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetCollabList(context,widget.assetType);
    collaborators = getCollaboratorsList();

  }

  Future getPersonalAssetList() async {
    await Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, widget.assetType);
    var c = Provider.of<Data>(context, listen: false).personalAssetList;
    return c;
  }

  Future getCollaboratorsList() async {
    await Provider.of<Data>(context, listen: false).fetchPersonalAssetCollabList(context,widget.assetType);
    var c = Provider.of<Data>(context, listen: false).personalAssetCollabList;
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


  Future<void> init() async {
    //
  }
  List<AssetTypes> assets = assetsItems();
  int selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _show(BuildContext ctx, AssetDetailModel mData) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              10.height,

              GestureDetector(
                onTap: () {
                   MAAssetDetailsScreen(assetData: mData,
                     assetColor: widget.color,
                     assetType: widget.assetType,
                   assetID: mData.assetID!,).launch(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        "VIEW ASSETS",
                        style: primaryTextStyle(weight: FontWeight.w500),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "Feature not available at the moment",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  // MAEditAssetScreen(
                  //   assetData: mData,
                  //   assetID: mData.assetID!,
                  //   assetType: widget.assetType,).launch(context);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "EDIT ASSETS",
                        style: primaryTextStyle(weight: FontWeight.w500),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  initializeDeleteAsset(mData.assetID);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "DELETE ASSETS",
                        style: primaryTextStyle(weight: FontWeight.w500),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // bottomsheet.showCupertinoModalBottomSheet(
                  //     expand: false,
                  //     context: context,
                  //     backgroundColor: Colors.transparent,
                  //     builder: (context) => const HLAddDebtScreen());
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, right: 28, left: 28, bottom: 50),
                      child: Text(
                        "CANCEL",
                        style: primaryTextStyle(color: Colors.red, weight: FontWeight.w500),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ));
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
      floatingActionButton:   DottedBorder(
        dashPattern: const [8, 4],
        strokeWidth: 1,
        borderType: BorderType.RRect,
        color: const Color(0xFF121936),
        radius: const Radius.circular(50),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60.0,
            width: 60.0,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor:   widget.color,
                onPressed: (){
                  widget.assetType == 'real_estate'? MACreateRealEstateAssetScreen(assetType: widget.assetType,).launch(context):
                  widget.assetType == 'tangible_assets'? MACreateTangibleAssetScreen(assetType: widget.assetType,).launch(context):
                  widget.assetType == 'personal_assets'? MACreatePersonalAssetScreen(assetType: widget.assetType,).launch(context):
                  widget.assetType == 'financial_assets'? MACreateFinancialAssetScreen(assetType: widget.assetType,).launch(context):
                  widget.assetType == 'debts_and_liabilities'? MACreateDebtsAssetsScreen(assetType: widget.assetType,).launch(context):
                  MACreateOthersAssetScreen(assetType: widget.assetType,).launch(context);


                },
                tooltip: 'Increment',
                child: const Icon(Icons.add, color: Colors.white,),
              ),
            ),
          ),
        ),
      ),
      body: DraggableHome(
        appBarColor:

        widget.color.withOpacity(0.1),
        headerExpandedHeight: customHeight*0.0036,
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
    return Container(
        color:       widget.color.withOpacity(0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: customHeight * 0.02,
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
                    const Text("Memoirs") ,
                    const SizedBox(width: 10,),
                    widget.assetType == 'real_estate'?Image.asset("assets/png/homeIcon.png"):
                    widget.assetType == 'tangible_assets'?Image.asset("assets/png/tangible_new.png"):
                    widget.assetType == 'personal_assets'?Image.asset("assets/png/personal.png"):
                    widget.assetType == 'financial_assets'?Image.asset("assets/jpg/card.png"):
                    widget.assetType == 'debts_and_liabilities'? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset("assets/jpg/chart.png", width: 30, fit: BoxFit.fitWidth, )):
    Image.asset("assets/png/others.png")
                  ],
                ),
              ],
            ),
            SizedBox(
              height: customHeight * 0.03,
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
                    Text("Memoirs",
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
               const Text("Last updated 5 days ago"),
              ],
            ),

            SizedBox(
              height:  customHeight*0.1,
            ),
            // Text("Collaborators linked to this asset group",style: boldTextStyle(color: Colors.black), ),
            //
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       FutureBuilder(
            //           future: collaborators,
            //           builder: (context, AsyncSnapshot snapshot) {
            //             if (snapshot.data == null) {
            //               return const Center(
            //                 child: CupertinoActivityIndicator(),
            //               );
            //             }
            //             if (snapshot.connectionState == ConnectionState.waiting) {
            //               return const Center(
            //                 child: CupertinoActivityIndicator(),
            //               );
            //             }
            //             else if (!snapshot.hasData) {
            //               return const Column(
            //                 children: [
            //                   Text(
            //                     "No Beneficiaries",
            //                     style: TextStyle(
            //                       backgroundColor: Colors.white,
            //                     ),
            //                   ),
            //                 ],
            //               );
            //             }
            //             List<CollaboratorListModel> collabList = snapshot.data;
            //             return SizedBox(
            //               height: 150,
            //               child: ListView.separated(
            //                   padding: const EdgeInsets.only(top: 0),
            //                   physics: const NeverScrollableScrollPhysics(),
            //                   itemCount: collabList.length,
            //                   shrinkWrap: true,
            //                   scrollDirection:Axis.horizontal,
            //                   itemBuilder: (context, index) {
            //                     CollaboratorListModel mData = collabList[index];
            //                     return Padding(
            //                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
            //                       child: GestureDetector(
            //                         onTap: (){
            //                      //     _showBeneDetails(context, mData);
            //                         },
            //                         child: Column(
            //                           crossAxisAlignment: CrossAxisAlignment.center,
            //
            //                           children: [
            //                             ClipRRect(
            //                               borderRadius: BorderRadius.circular(50.0),
            //                               child: Image.network(
            //                                 mData.collabPicture!,
            //                                 width: 70,
            //                               ),
            //                             ),
            //                             5.height,
            //                             Text(
            //                                 "${mData.collabName!.split(' ')[0]}\n${mData.collabName!.split(' ')[1]}",
            //                             textAlign: TextAlign.center,),
            //                           ],
            //                         ),
            //                       ),
            //                     );
            //                   }, separatorBuilder:
            //                   (BuildContext context, int index) {
            //                 return  Container(
            //
            //                 );
            //               }
            //               ),
            //             );
            //           }
            //       ),
            //       10.width,
            //       Padding(
            //         padding: const EdgeInsets.only(bottom: 69.0),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 bottomsheet.showCupertinoModalBottomSheet(
            //                     expand: false,
            //                     context: context,
            //                     backgroundColor: Colors.transparent,
            //                     builder: (context) =>
            //                      CreateCollabScreen(assetType: widget.assetType));
            //               },
            //               child: Container(
            //                 alignment: Alignment.center,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(50),
            //                   gradient: const LinearGradient(
            //                     colors: [
            //                       Colors.black,
            //                       Colors.black,
            //                     ],
            //                     begin: Alignment.centerLeft,
            //                     end: Alignment.centerRight,
            //                   ),
            //                 ),
            //                 child: const Padding(
            //                   padding:
            //                   EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            //                   child: Text(
            //                     '+',
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.normal,
            //                       fontSize: 25,
            //                       color: Color(0xffffffff),
            //                       letterSpacing: -0.3858822937011719,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),


          ],
        ).paddingOnly(top: 20, bottom: 0, left: 20, right: 20));
  }

  Widget listView() {
    return  FutureBuilder(
        future: personalAssets,
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
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "No Assets",
                    style: TextStyle(
                     color: Colors.black,
                    ),
                  ),
                ],
              ),
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
                    "No Assets Added",
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
                     MAAssetDetailsScreen(assetData: mData,
                         assetColor: widget.color,
                         assetType: widget.assetType,
                       assetID: mData.assetID!
                     ).launch(context);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Image.asset("assets/png/file.png"),
                    ),
                    title: Text(mData.assetName!),
                    subtitle: Text(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt)),
                      trailing:  GestureDetector(
                          onTap: (){
                            print("Iseoluwa");
                            _show(context, mData);
                          },
                          child: const Icon(Icons.more_horiz_outlined, color: Colors.black,))
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


  initializeDeleteAsset(assetID, ){
    loader.Loader.show(
        context, progressIndicator: const CupertinoActivityIndicator());
    var apiCall = RestDataSource();

    apiCall.deleteAsset(assetID,  widget.assetType).then((value) {
      print(value);
      if(value.toString().contains("Error")){
        Fluttertoast.showToast(
          msg: "There was an error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        loader.Loader.hide();
      }
      else{
        Fluttertoast.showToast(
          msg: "Document has been deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        loader.Loader.hide();
        finish(context);
      }

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
