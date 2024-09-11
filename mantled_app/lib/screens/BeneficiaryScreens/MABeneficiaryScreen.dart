

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:mantled_app/model/addbeneficiaryModel.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/BeneficiaryScreens/MACreateBeneficiaryScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MADashboardScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAInitializeAssetScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;

class MABeneficiaryScreen extends StatefulWidget {
  static String tag = '/MABeneficiaryScreen';

  final String assetID;
  final String assetType;
  const MABeneficiaryScreen({
    Key? key, required this.assetID, required this.assetType,
  }) : super(key: key);

  @override
  MABeneficiaryScreenState createState() => MABeneficiaryScreenState();
}

class MABeneficiaryScreenState extends State<MABeneficiaryScreen>
    with SingleTickerProviderStateMixin {
  String? otpPin;

  late Future allBeneficiaries;

  @override
  void initState() {

    Provider.of<Data>(context, listen: false).fetchBeneficiaries(context,);
    allBeneficiaries = getAllBeneficiaries();


    super.initState();
    init();
  }


  String getInitials(String bank_account_name) {
    String initials = "";
    if(bank_account_name.contains(" ")){
      List<String> names = bank_account_name.split(" ");

      int numWords = 2;

      if(numWords < names.length) {
        numWords = names.length;
      }
      for(var i = 0; i < numWords; i++){
        initials += '${names[i][0]}';
      }

    }
    else{
      bank_account_name="${bank_account_name} A";
      List<String> names = bank_account_name.split(" ");

      int numWords = 2;

      if(numWords < names.length) {
        numWords = names.length;
      }
      for(var i = 0; i < numWords; i++){
        initials += '${names[i][0]}';
      }
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
  // void _show(BuildContext ctx) {
  //   showModalBottomSheet(
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(color: Colors.white70, width: 1),
  //         borderRadius: BorderRadius.circular(25),
  //       ),
  //       isScrollControlled: true,
  //       elevation: 5,
  //       context: ctx,
  //       builder: (ctx) => Padding(
  //         padding: EdgeInsets.only(
  //             top: 25,
  //             left: 25,
  //             right: 25,
  //             bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //
  //           children: [
  //
  //              Text("Beneficiary Details", style: primaryTextStyle(weight: FontWeight.w500),),
  //             30.height,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //               Container(
  //               alignment: Alignment.topLeft,
  //               decoration:  BoxDecoration(
  //                   borderRadius:  BorderRadius.circular(30.0),
  //                   color:  Color(colors[0]).withOpacity(0.1)
  //               ),
  //               child:  Padding(
  //                 padding: const EdgeInsets.all(18.0),
  //                 child: Text(getInitials(beneficiaryNames[0]),
  //                   style: boldTextStyle(  color:  Color(colors[0])),),
  //               ),
  //             ),
  //                 const Padding(
  //                   padding: EdgeInsets.symmetric(horizontal: 18.0),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text("Olurotimi Ajao", textAlign: TextAlign.start,),
  //                       Text(
  //                           "Sent 10th Jun. 2022", textAlign: TextAlign.start,),
  //
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             30.height,
  //             Text(
  //               'RELATIONSHIP',
  //               style: secondaryTextStyle(),
  //               textAlign: TextAlign.start,
  //             ),
  //             Text(
  //               'Sister',
  //               style: primaryTextStyle(color: black,size: 16),
  //
  //               textAlign: TextAlign.start,
  //             ),
  //             20.height,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'PHONE NUMBER 1',
  //                   style: secondaryTextStyle(),
  //                   textAlign: TextAlign.start,
  //                 ),
  //                 Text("CALL NUMBER", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
  //                 size: 13,  weight: FontWeight.w500), )
  //               ],
  //             ),
  //             Text(
  //               '09023457910',
  //               style: primaryTextStyle(color: black,size: 16),
  //               textAlign: TextAlign.start,
  //             ),
  //             20.height,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'EMAIL ADDRESS',
  //                   style: secondaryTextStyle(),
  //                   textAlign: TextAlign.start,
  //                 ),
  //                 Text("SEND EMAIL", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
  //                     size: 13,  weight: FontWeight.w500), )
  //               ],
  //             ),
  //             Text(
  //               'suzzypasty@realbinxyz.africa',
  //               style: primaryTextStyle(color: black,size: 16),
  //
  //               textAlign: TextAlign.start,
  //             ),
  //             20.height,
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'HOUSE ADDRESS',
  //                   style: secondaryTextStyle(),
  //                   textAlign: TextAlign.start,
  //                 ),
  //                 Text("GET DIRECTIONS", style: primaryTextStyle(color: const Color(0xFF7800F0, ),
  //                     size: 13,  weight: FontWeight.w500), )
  //               ],
  //             ),
  //             Text(
  //               '20a Beckley Avenue',
  //               style: primaryTextStyle(color: black,size: 16),
  //
  //               textAlign: TextAlign.start,
  //             ),
  //             50.height,
  //
  //           ],
  //         ),
  //       ));
  // }


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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/png/confetti-cone.png',fit: BoxFit.cover, width: 120,),
              30.height,
              Text(
                'Beneficiary has been to asset Successfully ',
                style: primaryTextStyle(color: black,size: 19),

                textAlign: TextAlign.center,
              ),
              50.height,

              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: GestureDetector(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String? fullName=prefs.getString('fullName');
                    String? photo=prefs.getString('photo');
                    if(fullName != null && photo!=null){
                      MADashboardScreen(fullName:fullName, photo:photo).launch(context);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: context.width()/1.52,
                    height: 60,
                    decoration:  BoxDecoration(
                      borderRadius:  BorderRadius.circular(20.0),
                      color: const Color(0xFF121936),
                    ),
                    child: const Text('Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Color(0xffffffff),
                        letterSpacing: -0.3858822937011719,
                      ),),
                  ),
                ),
              ),
              16.height,
            ],
          ),
        ));
  }
  var beneficiaryNames=["Gideon Runsewe", "Pelumi Jegede", "Dele Martins", "Asikhia Iseoluwa" ];
  var colors=[0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D,
    0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41];


  TabController? tabController;



  Future getAllBeneficiaries() async {
    await Provider.of<Data>(context, listen: false).fetchBeneficiaries(context);
    var c = Provider.of<Data>(context, listen: false).beneficiariesList;
    return c;
  }


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

                    Text('Add beneficiary to asset',
                      style: boldTextStyle(color:Colors.black, size: 23,weight: FontWeight.w600 ),),
                    SizedBox(
                      height:  customHeight*0.1,
                    ),
                    Text('Select a saved beneficiary or add new',
                      style: secondaryTextStyle(size: 15,),),
                    SizedBox(
                      height:  customHeight*0.3,
                    ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 0),
                      decoration: const BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8)),
                          color: Colors.white),
                      alignment: Alignment.center,

                      child: AppTextField(
                          textFieldType: TextFieldType.NAME,
                          textAlignVertical: TextAlignVertical.center,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 16, right: 16, top: 23, bottom: 23),
                            filled: true,

                            suffixIcon: const Icon(Icons.search),
                            fillColor: Colors.grey.withOpacity(0.1),
                            hintText: "Search beneficiary",
                            hintStyle: secondaryTextStyle(),
                            suffixIconColor: Colors.grey.withOpacity(0.8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                  width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.1),
                                  width: 1),
                            ),
                          )),
                    ),
                  ],
                ),
              ),

              FutureBuilder(
                  future: allBeneficiaries,
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
                    List<AddBeneficiary> beneficiaryList = snapshot.data;

                    if(beneficiaryList.isEmpty){
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Beneficiaries Added",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  return ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: beneficiaryList.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
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
                                      color:  Color(colors[index]).withOpacity(0.1)
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Text(getInitials(beneficiaryList[index].fullName!),
                                      style: boldTextStyle(  color:  Color(colors[index])),),
                                  ),
                                ),
                                10.width,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(' ${beneficiaryList[index].fullName}', style: primaryTextStyle(),),
                                    Text("Added 9th Jun. 2022", style: secondaryTextStyle(),)

                                  ],
                                ),
                              ],
                            ),

                            GestureDetector(
                              onTap: (){
                                initializeCreateBeneficiary(beneficiaryList[index].beneficiaryID!);
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
                    }, separatorBuilder: (BuildContext context, int index) {
                      return Container();
                  },
                  );
                }
              ),

              SizedBox(
                height:  customHeight*0.3,
              ),
              const Center(child: Text("Beneficiary not in these List? ")),

              SizedBox(
                height:  customHeight*0.3,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    bottomsheet.showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>  MACreateBeneficiaryScreen(assetID:widget.assetID, myAssetType:widget.assetType));

                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: context.width()/1.2,
                    height: 70,
                    decoration:  BoxDecoration(
                      borderRadius:  BorderRadius.circular(25.0),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF131934),Color(0xFF131934) ,  ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Continue',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xffffffff),
                            letterSpacing: -0.3858822937011719,
                          ),),
                        10.width,
                        const Icon(Icons.arrow_forward, color: Colors.white,)
                      ],
                    ),
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
  initializeCreateBeneficiary(String beneficiaryID) {
    setState(() { });
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    var addBeneficiary = AddBeneficiary();
    addBeneficiary.beneficiaryID = beneficiaryID;

    apiCall.addBeneficiary(
        addBeneficiary,
        widget.assetID,
        widget.assetType
    ).then((value) {
      loader.Loader.hide();
      _show(context);
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


