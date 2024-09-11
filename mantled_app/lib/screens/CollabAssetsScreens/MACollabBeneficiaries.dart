

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/model/addbeneficiaryModel.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAInitializeAssetScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MACollabBeneficiaries extends StatefulWidget {
  static String tag = '/MACollabBeneficiaries';

  final String userID;
  final String assetType;

  const MACollabBeneficiaries({
    Key? key, required this.userID, required this.assetType,
  }) : super(key: key);

  @override
  MACollabBeneficiariesState createState() => MACollabBeneficiariesState();
}

class MACollabBeneficiariesState extends State<MACollabBeneficiaries>
    with SingleTickerProviderStateMixin {
  String? otpPin;

  late Future assetDetailsAssets;
  late Future assetDetailsBeneficiary;

  @override
  void initState() {
    super.initState();
    init();

    Provider.of<Data>(context, listen: false).fetchAssetDetailsBeneficiary(context,widget.userID,widget.assetType!);
    assetDetailsBeneficiary = getAssetDetailsBeneficiary();

  }

  Future getAssetDetailsBeneficiary() async {
    await Provider.of<Data>(context, listen: false).fetchAssetDetailsBeneficiary(context,widget.userID, widget.assetType);
    var c = Provider.of<Data>(context, listen: false).assetDetailsBeneficiaryList;
    return c;
  }


  void _showBeneDetails(BuildContext ctx,  AddBeneficiary mData) {
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
                          mData.createdAt!, textAlign: TextAlign.start,),

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


  TabController? tabController;



  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(

      body:  Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height:  customHeight*0.9,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Image.asset("assets/png/material-arrow-back.png").onTap(() {
                      finish(context);
                    }),
                    SizedBox(
                      height:  customHeight*0.4,
                    ),

                    Text('Added Beneficiaries',
                      style: primaryTextStyle(color:Colors.black, size: 18,weight: FontWeight.w500 ),),
                  ],
                ),
              ),
              SizedBox(
                height:  customHeight*0.3,
              ),
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
                    return ListView.separated(
                        padding: const EdgeInsets.only(top: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: beneficiariesList.length,
                        shrinkWrap: true,
                        scrollDirection:Axis.vertical,
                        itemBuilder: (context, index) {
                          AddBeneficiary mData = beneficiariesList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
                            child: GestureDetector(
                              onTap: (){
                                _showBeneDetails(context, mData);
                              },
                              child: Row(
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
                                  SizedBox(
                                    width:  customHeight*0.2,
                                  ),
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
                    );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
