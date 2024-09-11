import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mantled_app/model/linkedInvitesList.dart';
import 'package:mantled_app/model/pendingInvitesModel.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/AssetScreens/MAFinancialAssetHomeScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabProfileScreen.dart';
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

class MAVaultScreen extends StatefulWidget {
  static String tag = '/MAVaultScreen';


  const MAVaultScreen({
    Key? key,
  }) : super(key: key);

  @override
  MAVaultScreenState createState() => MAVaultScreenState();
}

class MAVaultScreenState extends State<MAVaultScreen>
    with SingleTickerProviderStateMixin {
  String? otpPin;


  late Future pendingInvitesList;
  late Future linkedInvitesList;
  @override
  void initState() {
    super.initState();
    init();
    Provider.of<Data>(context, listen: false).fetchPendingInvites(context);
    pendingInvitesList = getPendingData();

    Provider.of<Data>(context, listen: false).fetchLinkedInvites(context);
    linkedInvitesList = getLinkedData();
  }

  Future getPendingData() async {
    await Provider.of<Data>(context, listen: false)
        .fetchPendingInvites(context);
    var c = Provider
        .of<Data>(context, listen: false)
        .pendingInvitesList;
    return c;
  }

  Future getLinkedData() async {
    await Provider.of<Data>(context, listen: false)
        .fetchLinkedInvites(context);
    var c = Provider
        .of<Data>(context, listen: false)
        .linkedInvitesList;
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              10.height,

              GestureDetector(
                onTap: () {
                  const MAInitializeAssetScreen().launch(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        "ADD NEW ASSET",
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
                  bottomsheet.showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) =>
                      const MACreateCollaboratorScreen());
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "ADD NEW COLLABORATOR",
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
  void _showAccept(BuildContext ctx, PendingInvites invites) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    DateTime dt = DateTime.parse(invites.inviteTime!);
    print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(25),
        ),
        isScrollControlled: true,
        elevation: 5,
        context: ctx,
        builder: (ctx) =>
            Padding(
              padding: EdgeInsets.only(
                  top: 25,
                  left: 25,
                  right: 25,
                  bottom: MediaQuery
                      .of(ctx)
                      .viewInsets
                      .bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Image.asset("assets/png/collabUser.png"),
                        ),
                        title: Text(invites.inviteName!),
                        subtitle: Text(
                            DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt)),


                      ),
                    ),
                  ),
                  30.height,
                  Text(
                    'ASSETS TO BE ASSIGNED',
                    style: secondaryTextStyle(),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'Real Estate, Tangible Assets, Financial Assets + 3 others',
                    style: primaryTextStyle(color: black, size: 16),

                    textAlign: TextAlign.start,
                  ),
                  50.height,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: GestureDetector(
                          onTap: () {
                            initiateDeclineInvite(invites.inviteID!);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: context.width() / 3,
                            height: 60,
                            decoration: BoxDecoration(
                              border: Border.all(width: 2, color: const Color(
                                  0xFFA7A7A7)),
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.transparent,
                            ),
                            child: const Text('Decline',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.black,
                                letterSpacing: -0.3858822937011719,
                              ),),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: GestureDetector(
                          onTap: () {
                            initiateAcceptInvite(invites.inviteID!);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: context.width() / 3,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xFF00BF3D),
                            ),
                            child: const Text('Continue',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xffffffff),
                                letterSpacing: -0.3858822937011719,
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                  16.height,
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Vault',
                  style: boldTextStyle(color: Colors.black, size: 25),
                ),
                GestureDetector(
                  onTap: () {
                    _show(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7800F0),
                          Color(0xFF00A088),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          color: Color(0xffffffff),
                          letterSpacing: -0.3858822937011719,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            controller: tabController,
            labelColor: const Color(0xFF7800F0),
            unselectedLabelColor: Colors.black45,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.normal),
            indicatorColor: const Color(0xFF7800F0),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.all(-2),
            tabs: const [
              Tab(
                text: "ASSETS",
              ),
              Tab(text: "COLLABORATORS")
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
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
                          leading: CircleAvatar(
                            child: Image.asset("assets/png/house.png"),
                          ),
                          title: const Text("Real Estate"),
                          subtitle: const Text(
                              "Details of all your Real assets- Land, houses, terraces, apartments etc"),
                          trailing:
                              Image.asset("assets/png/arrow_foward.png")
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ).onTap(() {
                  const MAAssetHomeScreen(assetType:"real_estate", color:Color(0xFF00BF3D)).launch(context);
                }),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.asset("assets/png/tangible.png"),
                          ),
                          title: const Text("Tangible Assets"),
                          subtitle: const Text(
                              "Cars, Jewelry, Artworks and collectible"),
                          trailing:
                          Image.asset("assets/png/arrow_foward.png")
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ).onTap(() {
                  const MAAssetHomeScreen(assetType:"tangible_assets", color: Color(0xFF7800F0)).launch(context);
                }),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.asset('assets/png/car.png'),
                          ),
                          title: const Text("Personal Effects"),
                          subtitle: const Text(
                              "Birth Certificates, School leaving certificates, passport data page..."),
                          trailing:
                          Image.asset("assets/png/arrow_foward.png")
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ).onTap(() {
                  const MAAssetHomeScreen(assetType:"personal_assets", color: Color(0xFF0496FF)).launch(context);
                }),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.asset("assets/png/wallet.png"),
                          ),
                          title: const Text("Financial Assets"),
                          subtitle: const Text(
                              "Cash, Shares, Cryptocurrency,Pension schemes"),
                          trailing:
                          Image.asset("assets/png/arrow_foward.png")
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ).onTap(() {
                  const MAFinancialAssetHomeScreen(assetType:"financial_assets", color: Color(0xFFFD8B34)).launch(context);
                }),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.asset("assets/png/debts.png"),
                          ),
                          title: const Text("Debts & Liabilities"),
                          subtitle: const Text(
                              "Real,  tangible or intangible debts"),
                          trailing:
                          Image.asset("assets/png/arrow_foward.png")
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ).onTap(() {
                  const MAAssetHomeScreen(assetType:"debts_and_liabilities", color:Color(0xFFDA2C7C) ).launch(context);
                }),
                Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Image.asset("assets/png/others.png"),
                        ),
                        title: const Text("Others"),
                        subtitle: const Text(
                            "items not included in categories above"),
                        trailing:
                        Image.asset("assets/png/arrow_foward.png").onTap(() {
                           MAAssetHomeScreen(assetType: "others",color:Colors.black.withOpacity(0.8)).launch(context);
                        }),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                ).onTap(() {
                  MAAssetHomeScreen(assetType: "others",color:Colors.black.withOpacity(0.8)).launch(context);
    }),
              ],
            ),
          ),
          SingleChildScrollView(
            child: ListView(
              padding: const EdgeInsets.only(top: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 10),
                  child: Text("PENDING INVITES", style: secondaryTextStyle(),),
                ),
                FutureBuilder(
                    future: pendingInvitesList,
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
                      List<PendingInvites> pendingInvites = snapshot.data;

                      return ListView.separated(
                          padding: const EdgeInsets.only(top: 0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pendingInvites.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            PendingInvites mData = pendingInvites[index];
                            DateTime dt = DateTime.parse(mData.inviteTime!);
                            print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
                            return SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Image.asset(
                                        "assets/png/collabUser.png"),
                                  ),
                                  title: Text(mData.inviteName!),
                                  subtitle: Text(
                                      mData.inviteTime!),
                                  trailing: GestureDetector(
                                    onTap: () {
                                      _showAccept(context,mData );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                          color: const Color(0xFFDBF0DE)
                                      ),
                                      child: Text('View Invite',
                                        style: TextStyle(fontSize: 13 * textScale,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF177937)),),
                                    ),
                                  ),

                                ),
                              ),
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          }
                      );
                    }
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 10),
                  child: Text("ADDED COLLABORATORS", style: secondaryTextStyle(),),
                ),
                FutureBuilder(
                    future: linkedInvitesList,
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
                      List<LinkedInvitesList> linkedInvites = snapshot.data;
                      return ListView.separated(
                          padding: const EdgeInsets.only(top: 0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: linkedInvites.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            LinkedInvitesList mData = linkedInvites[index];
                            return GestureDetector(
                              onTap: (){
                                MACollabProfileScreen(
                                    userID:mData.assetOwnerID!,
                                    ownerName:mData.assetOwnerName!,
                                    linkedCount:mData.assetCount!
                                ).launch(context);
                              },
                              child: SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Image.asset(
                                          "assets/png/collabUser.png"),
                                    ),
                                    title: Text(mData.assetOwnerName!),
                                    subtitle: Text(
                                        "${mData.assetCount!} assets linked"),
                                    // trailing: GestureDetector(
                                    //   onTap: () {
                                    //
                                    //   },
                                    //   child: Container(
                                    //     alignment: Alignment.center,
                                    //     width: 100,
                                    //     height: 40,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(
                                    //             10.0),
                                    //         color: const Color(0xFFDBF0DE)
                                    //     ),
                                    //     child: Text('View Invite',
                                    //       style: TextStyle(fontSize: 13 * textScale,
                                    //           fontWeight: FontWeight.w500,
                                    //           color: const Color(0xFF177937)),),
                                    //   ),
                                    // ),

                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          }
                      );
                    }
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  initiateDeclineInvite(String inviteID) {
    loader.Loader.show(
        context, progressIndicator: const CupertinoActivityIndicator());
    var apiCall = RestDataSource();

    apiCall.declineInvite(inviteID).then((value) {
      loader.Loader.hide();
      setState(() {
        Provider.of<Data>(context, listen: false).fetchPendingInvites(context);
        pendingInvitesList = getPendingData();
      });

      finish(context);
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

  initiateAcceptInvite(String inviteID) {
    loader.Loader.show(
        context, progressIndicator: const CupertinoActivityIndicator());
    var apiCall = RestDataSource();

    apiCall.acceptInvite(inviteID).then((value) {
      loader.Loader.hide();
      setState(() {
        Provider.of<Data>(context, listen: false).fetchPendingInvites(context);
        pendingInvitesList = getPendingData();
      });

      finish(context);
      Fluttertoast.showToast(
        msg: "Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
