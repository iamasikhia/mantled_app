import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mantled_app/model/IndividualAssetListModel.dart';
import 'package:mantled_app/model/pendingInvitesModel.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAInitializeAssetScreen.dart';
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
import 'package:provider/provider.dart';

import '../../utils/NBColors.dart';
import '../../utils/NBImages.dart';

class MACollabProfileScreen extends StatefulWidget {
  static String tag = '/MACollabProfileScreen';

  final String userID;
  final String ownerName;
  final int linkedCount;

  const MACollabProfileScreen({
    Key? key, required this.userID, required this.linkedCount, required this.ownerName,
  }) : super(key: key);

  @override
  MACollabProfileScreenState createState() => MACollabProfileScreenState();
}

class MACollabProfileScreenState extends State<MACollabProfileScreen>
    with SingleTickerProviderStateMixin {
  String? otpPin;


  late Future collabAssetsList;

  @override
  void initState() {
    super.initState();
    init();
    Provider.of<Data>(context, listen: false).fetchCollabAssets(context,widget.userID);
    collabAssetsList = getCollabAssetList();

  }

  Future getCollabAssetList() async {
    await Provider.of<Data>(context, listen: false).fetchCollabAssets(context,widget.userID);
    var c = Provider.of<Data>(context, listen: false).collabAssetList;
    return c;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> init() async {
    tabController = TabController(length: 2, vsync: this);
  }

  TabController? tabController;



  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(

      body:  SingleChildScrollView(
        child: ListView(
          padding: const EdgeInsets.only(top: 20),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height:  customHeight*0.6,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/png/material-arrow-back.png").onTap(() {
                    finish(context);
                  }),
                  SizedBox(
                    height:  customHeight*0.2,
                  ),

                  Text("${widget.ownerName.split(' ')[0]}'s Assets",
                    style: primaryTextStyle(color:Colors.black, size: 25,weight: FontWeight.w500 ),),
                  Text('${widget.linkedCount} Assets Linked',
                      style: primaryTextStyle(color: Colors.black54)),
                ],
              ),
            ),
            SizedBox(
              height:  customHeight*0.3,
            ),
            const Divider(
              thickness: 1,
            ),

            FutureBuilder(
                future: collabAssetsList,
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

                  List<IndividualAssetListModel> collabAssetList = snapshot.data;
                  if(collabAssetList.isEmpty){
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "No Asset Info",
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
                    itemCount: collabAssetList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      IndividualAssetListModel mData = collabAssetList[index];
                      DateTime dt = DateTime.parse(mData.assetLastModified!);
                      print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
                    return GestureDetector(
                      onTap: (){
                         MACollabAssetHomeScreen(
                           userID:widget.userID,
                             assetType: mData.assetType!, lastModified: mData.assetLastModified! ).launch(context);
                      },
                      child: Column(
                        children: [

                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child:
                                  mData.assetType=="real_estate"?  Image.asset("assets/png/house.png", width: 50,):
                                  mData.assetType=="tangible_assets"? Image.asset("assets/png/tangible.png"):
                                  mData.assetType=="personal_assets"?Image.asset('assets/png/car.png'):
                                  mData.assetType=="financial_assets"?Image.asset("assets/png/wallet.png"):
                                  mData.assetType=="debts_and_liabilities"?Image.asset("assets/png/debts.png"):
                                  Image.asset("assets/png/others.png"),

                                ),
                                title:
                                mData.assetType=="real_estate"?const Text("Real Estate"):
                                mData.assetType=="tangible_assets"?const Text("Tangible Asset"):
                                mData.assetType=="personal_assets"?const Text("Personal Asset"):
                                mData.assetType=="financial_assets"?const Text("Financial Asset"):
                                mData.assetType=="debts_and_liabilities"?const Text("Debts and Liabilities"):
                                const Text("Other") ,
                                subtitle:  Text(
                                    DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt), style: const TextStyle(fontSize: 13),),
                                // trailing:
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
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    );
                  },separatorBuilder:
                    (BuildContext context, int index) {
                  return  Container(

                  );
                }
                );
              }
            ),

      //       Column(
      //         children: [
      //           SizedBox(
      //             width: MediaQuery.of(context).size.width,
      //             child: Padding(
      //               padding: const EdgeInsets.all(5.0),
      //               child: ListTile(
      //                 leading: CircleAvatar(
      //                   child: Image.asset("assets/png/tangible.png"),
      //                 ),
      //                 title: const Text("Tangible Assets"),
      //                 subtitle: const Text(
      //                   "Last modified, yesterday", style: TextStyle(fontSize: 13),),
      //                 // trailing:
      //                 // Container(
      //                 //   alignment: Alignment.center,
      //                 //   width: 120,
      //                 //   height: 40,
      //                 //   decoration:  BoxDecoration(
      //                 //       borderRadius:  BorderRadius.circular(10.0),
      //                 //       color: const Color(0xFFF5F0FF)
      //                 //   ),
      //                 //   child:  Text('3 New Updates',
      //                 //     style: primaryTextStyle(size: 13,  weight: FontWeight.w500, color: const Color(0xFF700BE9)),),
      //                 // ),
      //               ),
      //             ),
      //           ),
      //           const Divider(
      //             thickness: 1,
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           SizedBox(
      //             width: MediaQuery.of(context).size.width,
      //             child: Padding(
      //               padding: const EdgeInsets.all(5.0),
      //               child: ListTile(
      //                 leading: CircleAvatar(
      //                   child: Image.asset('assets/png/debts.png'),
      //                 ),
      //                 title: const Text("Personal Effects"),
      //                 subtitle: const Text(
      //                   "Last modified, yesterday", style: TextStyle(fontSize: 13),),
      //                 // trailing:
      //                 // Container(
      //                 //   alignment: Alignment.center,
      //                 //   width: 120,
      //                 //   height: 40,
      //                 //   decoration:  BoxDecoration(
      //                 //       borderRadius:  BorderRadius.circular(10.0),
      //                 //       color: const Color(0xFFF5F0FF)
      //                 //   ),
      //                 //   child:  Text('3 New Updates',
      //                 //     style: primaryTextStyle(size: 13,  weight: FontWeight.w500, color: const Color(0xFF700BE9)),),
      //                 // ),
      //               ),
      //             ),
      //           ),
      //           const Divider(
      //             thickness: 1,
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           SizedBox(
      //             width: MediaQuery.of(context).size.width,
      //             child: Padding(
      //               padding: const EdgeInsets.all(5.0),
      //               child: ListTile(
      //                 leading: CircleAvatar(
      //                   child: Image.asset("assets/png/car.png"),
      //                 ),
      //                 title: const Text("Financial Assets"),
      //                 subtitle: const Text(
      //                   "Last modified, yesterday", style: TextStyle(fontSize: 13),),
      //                 // trailing:
      //                 // Container(
      //                 //   alignment: Alignment.center,
      //                 //   width: 120,
      //                 //   height: 40,
      //                 //   decoration:  BoxDecoration(
      //                 //       borderRadius:  BorderRadius.circular(10.0),
      //                 //       color: const Color(0xFFF5F0FF)
      //                 //   ),
      //                 //   child:  Text('3 New Updates',
      //                 //     style: primaryTextStyle(size: 13,  weight: FontWeight.w500, color: const Color(0xFF700BE9)),),
      //                 // ),
      //               ),
      //             ),
      //           ),
      //           const Divider(
      //             thickness: 1,
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           SizedBox(
      //             width: MediaQuery.of(context).size.width,
      //             child: Padding(
      //               padding: const EdgeInsets.all(5.0),
      //               child: ListTile(
      //                 leading: CircleAvatar(
      //                   child: Image.asset("assets/png/wallet.png"),
      //                 ),
      //                 title: const Text("Debts & Liabilities"),
      //                 subtitle: const Text(
      //                   "Last modified, yesterday", style: TextStyle(fontSize: 13),),
      //                 // trailing:
      //                 // Container(
      //                 //   alignment: Alignment.center,
      //                 //   width: 120,
      //                 //   height: 40,
      //                 //   decoration:  BoxDecoration(
      //                 //       borderRadius:  BorderRadius.circular(10.0),
      //                 //       color: const Color(0xFFF5F0FF)
      //                 //   ),
      //                 //   child:  Text('3 New Updates',
      //                 //     style: primaryTextStyle(size: 13,  weight: FontWeight.w500, color: const Color(0xFF700BE9)),),
      //                 // ),
      //               ),
      //             ),
      //           ),
      //           const Divider(
      //             thickness: 1,
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           SizedBox(
      //             width: MediaQuery.of(context).size.width,
      //             child: ListTile(
      //               leading: CircleAvatar(
      //                 child: Image.asset("assets/png/others.png"),
      //               ),
      //               title: const Text("Others"),
      //               subtitle: const Text(
      //                 "Last modified, yesterday", style: TextStyle(fontSize: 13),),
      //               // trailing:
      //               // Container(
      //               //   alignment: Alignment.center,
      //               //   width: 120,
      //               //   height: 40,
      //               //   decoration:  BoxDecoration(
      //               //       borderRadius:  BorderRadius.circular(10.0),
      //               //       color: const Color(0xFFF5F0FF)
      //               //   ),
      //               //   child:  Text('3 New Updates',
      //               //     style: primaryTextStyle(size: 13,  weight: FontWeight.w500, color: const Color(0xFF700BE9)),),
      //               // ),
      //             ),
      // ),
      //
      //           const Divider(
      //             thickness: 1,
      //           ),
      //         ],
      //       ),
          ],
        ),
      ),
    );
  }
}
