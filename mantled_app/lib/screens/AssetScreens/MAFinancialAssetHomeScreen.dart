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
import 'package:mantled_app/screens/AssetScreens/MAFinancialAssetDetailsScreen.dart';
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
import 'package:mantled_app/screens/AssetScreens/MAFinancialAssetDetailsScreen.dart';
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

class MAFinancialAssetHomeScreen extends StatefulWidget {
  static String tag = '/MAFinancialAssetHomeScreen';

  final String assetType;

  final Color color;

  const MAFinancialAssetHomeScreen({Key? key, required this.assetType, required this.color, }) : super(key: key);

  @override
  MAFinancialAssetHomeScreenState createState() => MAFinancialAssetHomeScreenState();
}

class MAFinancialAssetHomeScreenState extends State<MAFinancialAssetHomeScreen> {

  late Future cashPersonalAssets;
  late Future pensionPersonalAssets;
  late Future insurancePersonalAssets;
  late Future cryptoPersonalAssets;
  late Future collaborators;


  @override
  void initState() {
    super.initState();
    init();
   Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "cash");
    cashPersonalAssets = getCashPersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "pension");
    pensionPersonalAssets = getPensionPersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "insurance");
    insurancePersonalAssets = getInsurancePersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "crypto");
    cryptoPersonalAssets = getCryptoPersonalAssetList();


    Provider.of<Data>(context, listen: false).fetchPersonalAssetCollabList(context,widget.assetType);
    collaborators = getCollaboratorsList();

  }

  Future getCashPersonalAssetList() async {
    await Provider.of<Data>(context, listen: false).fetchCashPersonalAssetList(context, "cash");
    var c = Provider.of<Data>(context, listen: false).cashPersonalAssetList;
    return c;
  }
  Future getCryptoPersonalAssetList() async {
    await Provider.of<Data>(context, listen: false).fetchCryptoPersonalAssetList(context,"crypto");
    var c = Provider.of<Data>(context, listen: false).cryptoPersonalAssetList;
    return c;
  }
  Future getPensionPersonalAssetList() async {
    await Provider.of<Data>(context, listen: false).fetchPensionPersonalAssetList(context, "pension");
    var c = Provider.of<Data>(context, listen: false).pensionPersonalAssetList;
    return c;
  }
  Future getInsurancePersonalAssetList() async {
    await Provider.of<Data>(context, listen: false).fetchInsurancePersonalAssetList(context,"insurance");
    var c = Provider.of<Data>(context, listen: false).insurancePersonalAssetList;
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

  void _show(BuildContext ctx, AssetDetailModel mData, String assetCat) {
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
                   MAFinancialAssetDetailsScreen(assetData: mData,
                     assetColor: widget.color,
                     assetCat: assetCat,
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
                initializeDeleteAsset(mData.assetID, assetCat);
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
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(

                    title: const Text("Cash"),
                    maintainState: true,
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,

                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      cashListView(),
                    ],
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.1,
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: const Text("Insurance"),
                    maintainState: true,
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      insuranceListView(),
                    ],
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.1,
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: const Text("Crypto"),
                    maintainState: true,
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      cryptoListView(),
                    ],
                  ),
                ),
                SizedBox(
                  height: customHeight * 0.1,
                ),
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: const Text("Pension"),
                    maintainState: true,
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,
                    expandedAlignment: Alignment.centerLeft,
                    children: [
                      pensionListView(),
                    ],
                  ),
                )
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
                    const Text("Memoirs") ,
                    const SizedBox(width: 10,),
                    widget.assetType == 'real_estate'?Image.asset("assets/png/homeIcon.png"):
                    widget.assetType == 'tangible_assets'?Image.asset("assets/png/tangible_new.png"):
                    widget.assetType == 'personal_assets'?Image.asset("assets/png/personal.png"):
                    widget.assetType == 'financial_assets'?Image.asset("assets/jpg/card.png"):
                    widget.assetType == 'debts_and_liabilities'? ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset("assets/jpg/chart.png", width: 30, fit: BoxFit.fitWidth, )):
                    const Icon(CupertinoIcons.memories)
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
              height: customHeight * 0.1,
            ),

          ],
        ).paddingOnly(top: 20, bottom: 0, left: 20, right: 20));
  }

  Widget cashListView() {
    return  FutureBuilder(
        future: cashPersonalAssets,
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
                     MAFinancialAssetDetailsScreen(assetData: mData,
                         assetColor: widget.color,
                         assetType: widget.assetType,
                         assetCat: "cash",
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
                            _show(context, mData, "cash");
                          },
                          child: const Icon(Icons.more_horiz_outlined, color: Colors.black,))
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return  Container();
          },
          );
        }
    );
  }
  Widget insuranceListView() {
    return  FutureBuilder(
        future: insurancePersonalAssets,
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
                    MAFinancialAssetDetailsScreen(assetData: mData,
                        assetColor: widget.color,
                        assetType: widget.assetType,
                        assetCat: "insurance",
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
                            _show(context, mData, "insurance");
                          },
                          child: const Icon(Icons.more_horiz_outlined, color: Colors.black,))
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return  Container();
          },
          );
        }
    );
  }
  Widget pensionListView() {
    return  FutureBuilder(
        future: pensionPersonalAssets,
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
                    MAFinancialAssetDetailsScreen(assetData: mData,
                        assetColor: widget.color,
                        assetType: widget.assetType,
                        assetCat: "pension",
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
                            _show(context, mData, "pension");
                          },
                          child: const Icon(Icons.more_horiz_outlined, color: Colors.black,))
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return  Container();
          },
          );
        }
    );
  }
  Widget cryptoListView() {
    return  FutureBuilder(
        future: cryptoPersonalAssets,
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
                    MAFinancialAssetDetailsScreen(assetData: mData,
                        assetColor: widget.color,
                        assetType: widget.assetType,
                        assetCat: "crypto",
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
                            _show(context, mData, "crypto");
                          },
                          child: const Icon(Icons.more_horiz_outlined, color: Colors.black,))
                  ),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
            return  Container();
          },
          );
        }
    );
  }


  initializeDeleteAsset(assetID,assetType ){
    loader.Loader.show(
        context, progressIndicator: const CupertinoActivityIndicator());
    var apiCall = RestDataSource();

    apiCall.deleteAsset(assetID,  assetType).then((value) {
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
