import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
//import 'package:mantled_app/component/StepComponent.dart';
import 'package:mantled_app/constants/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:mantled_app/model/addbeneficiaryModel.dart';
import 'package:mantled_app/model/assetDetailModel.dart';
import 'package:mantled_app/model/collaboratorModel.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/DashboardScreens/EnterPinScreenWidgets/CustomSnackBar.dart';
import 'package:mantled_app/screens/OnboardingScreens/MAMembershipScreen.dart';
// import 'package:mantled_app/screen/MAMembershipScreen.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/utils/NBImages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:provider/provider.dart';

import 'EnterPinScreenWidgets/myModel.dart';
import 'MADashboardScreen.dart';


class CreateCollabScreen extends StatefulWidget {
  static String tag = '/CreateCollabScreen';

  final String assetType;

  const CreateCollabScreen({Key? key, required this.assetType, }) : super(key: key);

  @override
  CreateCollabScreenState createState() => CreateCollabScreenState();
}

class CreateCollabScreenState extends State<CreateCollabScreen> {
  List<String> mPages = <String>[
    brainstorming1,
    financialdata1,
    onlinetransactions1
  ];
  List<String> headings = <String>[heading1, heading2, heading3];
  List<String> subHeadings = <String>[subheading1, subheading2, subheading3];
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _dateController = TextEditingController();

  bool isOptionAlreadySelected= false;
  String? assetType;
  String? assetCategory;
  late Future personalAssets;
  List<AssetDetailModel> allItems=[];

  late Future cashPersonalAssets;
  late Future pensionPersonalAssets;
  late Future insurancePersonalAssets;
  late Future cryptoPersonalAssets;

  @override
  void initState() {
    super.initState();
    init();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, assetType);
    personalAssets = getPersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, assetType);
    personalAssets = getPersonalAssetList();
    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "cash");
    cashPersonalAssets = getCashPersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "pension");
    pensionPersonalAssets = getPensionPersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "insurance");
    insurancePersonalAssets = getInsurancePersonalAssetList();

    Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context, "crypto");
    cryptoPersonalAssets = getCryptoPersonalAssetList();

  }

  Future getPersonalAssetList() async {
    await Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context,  assetType);
    var c = Provider.of<Data>(context, listen: false).personalAssetList;
    return c;
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

  var allSteps= ["Naming", "Address", "Uploads"];
  Color _colorContainer = Colors.white;


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
                'An invite link has been sent to \n the email address to join in as a \n collaborator to your asset',
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



  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();

  List<String?> governmentIDList = [
    "Select asset to assign",
    "Real Estate",
    "Financial Assets",
    "Personal Assets",
    "Tangible Assets",
    "Debts and Liabilities",
    "Others",
  ];


  List<String?> financialTypeList = [
    "Select Financial asset type",
    "Cash",
    "Crypto",
    "Pension",
    "Insurance",
  ];

  final MultiSelectController<String> _controller = MultiSelectController();
  int position = 0;
  PageController? pageController;
  int newPostion = 0;



  Future<void> init() async {
    pageController =
        PageController(initialPage: position, viewportFraction: 1);
  }



  @override
  Widget build(BuildContext context) {
    final _items = CryptoModel.getCrypto();
    double customHeight= MediaQuery.of(context).size.height*0.1;
    setStatusBarColor(transparentColor,
        statusBarIconBrightness: Brightness.dark);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height:  customHeight*0.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Image.asset("assets/png/material-arrow-back.png").onTap(() {
                    if(position==1){
                      print(position);
                      setState(() {
                        if (position >0 ) {

                          position--;
                          pageController!.previousPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.linear);
                        } else {

                        }
                      });
                    }
                    else{
                      finish(context);
                    }

                  }),

                ],
              ),
              SizedBox(
                height:  customHeight*0.3,
              ),
              position==0?Column(
                children: [
                  Row(
                    children: [
                      Text('Add Collaborators',
                        style: primaryTextStyle(color:Colors.black, size: 25,weight: FontWeight.w500 ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height:  customHeight*0.1,
                  ),
                  Row(
                    children: [
                      Text('to an asset.',
                        style: boldTextStyle(color:Colors.black, size: 25, ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ):Container(),

              position==1?Column(
                children: [
                  Row(
                    children: [
                      Text('Kindly set the permission ',
                        style: primaryTextStyle(color:Colors.black, size: 20,weight: FontWeight.w500 ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height:  customHeight*0.1,
                  ),
                  Row(
                    children: [
                      Text('parameters',
                        style: boldTextStyle(color:Colors.black, size: 20, ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ):Container(),




              SizedBox(
                height:  customHeight*0.3,
              ),
              SizedBox(
                height: context.height() * 0.68,
                child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [

                            8.height,
                            nbAppTextFieldWidget(
                              fullNameController,
                              'Full Name',
                              TextFieldType.NAME,
                            ),
                            25.height,
                            nbAppTextFieldWidget(
                              emailAddressController,
                              'Email Address',
                              TextFieldType.EMAIL,
                            ),
                            25.height,

                            SizedBox(
                              child: DropdownButtonFormField(
                                icon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: NBPrimaryColor,
                                ),
                                value:widget.assetType=="real_estate"?governmentIDList[1]:
                                widget.assetType=="financial_assets"?governmentIDList[2]:
                                widget.assetType=="tangible_assets"?governmentIDList[4]:
                                widget.assetType=="personal_assets"?governmentIDList[3]:
                                widget.assetType=="debts_and_liabilities"?governmentIDList[5]:
                                governmentIDList[6],
                                isExpanded: true,
                                decoration: nbInputDecoration(
                                    bgColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 25)),
                                items: governmentIDList.map((String? value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                    Text(value!, style: primaryTextStyle()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if(value.toString()=="Real Estate"){
                                    setState(() {
                                      assetType="real_estate";
                                    });
                                  }
                                  else if(value.toString()=="Tangible Assets"){
                                    setState(() {
                                      assetType="tangible_assets";
                                    });
                                  }
                                  else if(value.toString()=="Personal Assets"){
                                    setState(() {
                                      assetType="personal_assets";
                                    });
                                  }
                                  else if(value.toString()=="Financial Assets"){
                                    setState(() {
                                      assetType="financial_assets";
                                    });
                                  }
                                  else if(value.toString()=="Debts & Liabilities"){
                                    setState(() {
                                      assetType="debts_and_liabilities";
                                    });
                                  }
                                  else if(value.toString()=="Other"){
                                    setState(() {
                                      assetType="other";
                                    });
                                  }

                                },
                              ),
                            ),
                            25.height,
                            widget.assetType=="financial_assets" ?SizedBox(
                              child: DropdownButtonFormField(
                                icon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: NBPrimaryColor,
                                ),
                                value: financialTypeList[0],
                                isExpanded: true,
                                decoration: nbInputDecoration(
                                    bgColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 25)),
                                items: financialTypeList.map((String? value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                    Text(value!, style: primaryTextStyle()),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if(value.toString()=="Cash"){
                                    setState(() {
                                      assetCategory="cash";
                                    });
                                  }
                                  else if(value.toString()=="Crypto"){
                                    setState(() {
                                      assetCategory="crypto";
                                    });
                                  }
                                  else if(value.toString()=="Pension"){
                                    setState(() {
                                      assetCategory="pension";
                                    });
                                  }
                                  else if(value.toString()=="Insurance"){
                                    setState(() {
                                      assetCategory="insurance";
                                    });
                                  }


                                },
                              ),
                            ):Container(),

                            SizedBox(
                              height: customHeight*0.2,
                            ),

                            SizedBox(
                              height: customHeight*0.6,
                            ),
                            GestureDetector(
                              onTap: () {
                                print(assetType);
                                Provider.of<Data>(context, listen: false).fetchPersonalAssetList(context,assetType);
                                personalAssets = getPersonalAssetList();

                                setState(() {

                                  if (position < 1) {
                                    position++;
                                    pageController!.nextPage(
                                        duration: const Duration(microseconds: 300),
                                        curve: Curves.linear);
                                  } else {
                                    //initializeCompleteProfile();
                                    //const MAMembershipScreen().launch(context);
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: context.width(),
                                height: 70,
                                decoration:  BoxDecoration(
                                  borderRadius:  BorderRadius.circular(25.0),
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF7800F0),Color(0xFF00A088) ,  ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: const Text('Save & Proceed ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                    letterSpacing: -0.3858822937011719,
                                  ),),
                              ),
                            )
                          ],
                        ),
                      ),


                      widget.assetType=="financial_assets" && assetCategory=="cash"? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ink(
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration:  BoxDecoration(
                                            borderRadius:  BorderRadius.circular(30.0),
                                            border: Border.all( width: 2, color:  const Color(0xFF00A088).withOpacity(0.4)),
                                            color: _colorContainer ,
                                          ),
                                          height: 60,
                                          width: context.width(),

                                          child: const Center(child: Text("Allow access to all properties")),
                                        ),
                                        onTap: () {

                                          setState(() {

                                            isOptionAlreadySelected= !isOptionAlreadySelected;
                                            _colorContainer = isOptionAlreadySelected ?
                                            const Color(0xFF00A088).withOpacity(0.4) :
                                            Colors.white ;
                                          });
                                          print(isOptionAlreadySelected);
                                          isOptionAlreadySelected? _controller.deselectAll():null;

                                        },
                                      )),
                                ],
                              ),

                              SizedBox(
                                height: customHeight*0.3,
                              ),


                              Container(
                                height: context.height()*0.4,
                                child: FutureBuilder(
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
                                                "No Assets Added",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return MultiSelectCheckList(

                                        maxSelectableCount: isOptionAlreadySelected? 0:6,
                                        textStyles: const MultiSelectTextStyles(
                                            selectedTextStyle: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold)),
                                        itemsDecoration: MultiSelectDecorations(
                                            selectedDecoration:
                                            BoxDecoration(
                                              borderRadius:  BorderRadius.circular(25.0),
                                              color: const Color(0xFF00A088).withOpacity(0.4),

                                            )),
                                        listViewSettings: ListViewSettings(
                                            separatorBuilder: (context, index) => const Divider(
                                              height: 10,
                                            )),
                                        controller: _controller,
                                        items: List.generate(
                                            assetList.length,
                                                (index) => CheckListCard(
                                                value: assetList[index].assetID!,
                                                contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
                                                title: Text(assetList[index].assetName!),
                                                selectedColor: Colors.white,
                                                checkColor: const Color(0xFF00A088),
                                                checkBoxGap:20,
                                                textStyles:  const MultiSelectItemTextStyles(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,),
                                                  selectedTextStyle: TextStyle(
                                                    fontSize: 16, ),
                                                ),

                                                checkBoxBorderSide:
                                                const BorderSide(color: Color(0xFF00A088), width: 2),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)))),
                                        onChange: (allSelectedItems, String? selectedItem) {

                                          print(selectedItem!);
                                        },
                                        onMaximumSelected: (allSelectedItems, selectedItem) {
                                          CustomSnackBar.showInSnackBar('The limit has been reached', context);
                                        },
                                      );
                                    }
                                ),
                              ),
                              SizedBox(
                                height: customHeight*0.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  initializeCreateCollaborator();
                                  //  _show(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: context.width(),
                                  height: 70,
                                  decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(25.0),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF7800F0),Color(0xFF00A088) ,  ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: const Text('Add Collaborators',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      letterSpacing: -0.3858822937011719,
                                    ),),
                                ),
                              )



                            ],
                          ),
                        ),
                      ):
                      widget.assetType=="financial_assets" && assetCategory=="crypto"? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ink(
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration:  BoxDecoration(
                                            borderRadius:  BorderRadius.circular(30.0),
                                            border: Border.all( width: 2, color:  const Color(0xFF00A088).withOpacity(0.4)),
                                            color: _colorContainer ,
                                          ),
                                          height: 60,
                                          width: context.width(),

                                          child: const Center(child: Text("Allow access to all properties")),
                                        ),
                                        onTap: () {

                                          setState(() {

                                            isOptionAlreadySelected= !isOptionAlreadySelected;
                                            _colorContainer = isOptionAlreadySelected ?
                                            const Color(0xFF00A088).withOpacity(0.4) :
                                            Colors.white ;
                                          });
                                          print(isOptionAlreadySelected);
                                          isOptionAlreadySelected? _controller.deselectAll():null;

                                        },
                                      )),
                                ],
                              ),

                              SizedBox(
                                height: customHeight*0.3,
                              ),


                              Container(
                                height: context.height()*0.4,
                                child: FutureBuilder(
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
                                                "No Assets Added",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return MultiSelectCheckList(

                                        maxSelectableCount: isOptionAlreadySelected? 0:6,
                                        textStyles: const MultiSelectTextStyles(
                                            selectedTextStyle: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold)),
                                        itemsDecoration: MultiSelectDecorations(
                                            selectedDecoration:
                                            BoxDecoration(
                                              borderRadius:  BorderRadius.circular(25.0),
                                              color: const Color(0xFF00A088).withOpacity(0.4),

                                            )),
                                        listViewSettings: ListViewSettings(
                                            separatorBuilder: (context, index) => const Divider(
                                              height: 10,
                                            )),
                                        controller: _controller,
                                        items: List.generate(
                                            assetList.length,
                                                (index) => CheckListCard(
                                                value: assetList[index].assetID!,
                                                contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
                                                title: Text(assetList[index].assetName!),
                                                selectedColor: Colors.white,
                                                checkColor: const Color(0xFF00A088),
                                                checkBoxGap:20,
                                                textStyles:  const MultiSelectItemTextStyles(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,),
                                                  selectedTextStyle: TextStyle(
                                                    fontSize: 16, ),
                                                ),

                                                checkBoxBorderSide:
                                                const BorderSide(color: Color(0xFF00A088), width: 2),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)))),
                                        onChange: (allSelectedItems, String? selectedItem) {

                                          print(selectedItem!);
                                        },
                                        onMaximumSelected: (allSelectedItems, selectedItem) {
                                          CustomSnackBar.showInSnackBar('The limit has been reached', context);
                                        },
                                      );
                                    }
                                ),
                              ),
                              SizedBox(
                                height: customHeight*0.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  initializeCreateCollaborator();
                                  //  _show(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: context.width(),
                                  height: 70,
                                  decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(25.0),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF7800F0),Color(0xFF00A088) ,  ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: const Text('Add Collaborators',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      letterSpacing: -0.3858822937011719,
                                    ),),
                                ),
                              )



                            ],
                          ),
                        ),
                      ):
                      widget.assetType=="financial_assets"  && assetCategory=="pension"? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ink(
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration:  BoxDecoration(
                                            borderRadius:  BorderRadius.circular(30.0),
                                            border: Border.all( width: 2, color:  const Color(0xFF00A088).withOpacity(0.4)),
                                            color: _colorContainer ,
                                          ),
                                          height: 60,
                                          width: context.width(),

                                          child: const Center(child: Text("Allow access to all properties")),
                                        ),
                                        onTap: () {

                                          setState(() {

                                            isOptionAlreadySelected= !isOptionAlreadySelected;
                                            _colorContainer = isOptionAlreadySelected ?
                                            const Color(0xFF00A088).withOpacity(0.4) :
                                            Colors.white ;
                                          });
                                          print(isOptionAlreadySelected);
                                          isOptionAlreadySelected? _controller.deselectAll():null;

                                        },
                                      )),
                                ],
                              ),

                              SizedBox(
                                height: customHeight*0.3,
                              ),


                              Container(
                                height: context.height()*0.4,
                                child: FutureBuilder(
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
                                                "No Assets Added",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return MultiSelectCheckList(

                                        maxSelectableCount: isOptionAlreadySelected? 0:6,
                                        textStyles: const MultiSelectTextStyles(
                                            selectedTextStyle: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold)),
                                        itemsDecoration: MultiSelectDecorations(
                                            selectedDecoration:
                                            BoxDecoration(
                                              borderRadius:  BorderRadius.circular(25.0),
                                              color: const Color(0xFF00A088).withOpacity(0.4),

                                            )),
                                        listViewSettings: ListViewSettings(
                                            separatorBuilder: (context, index) => const Divider(
                                              height: 10,
                                            )),
                                        controller: _controller,
                                        items: List.generate(
                                            assetList.length,
                                                (index) => CheckListCard(
                                                value: assetList[index].assetID!,
                                                contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
                                                title: Text(assetList[index].assetName!),
                                                selectedColor: Colors.white,
                                                checkColor: const Color(0xFF00A088),
                                                checkBoxGap:20,
                                                textStyles:  const MultiSelectItemTextStyles(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,),
                                                  selectedTextStyle: TextStyle(
                                                    fontSize: 16, ),
                                                ),

                                                checkBoxBorderSide:
                                                const BorderSide(color: Color(0xFF00A088), width: 2),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)))),
                                        onChange: (allSelectedItems, String? selectedItem) {

                                          print(selectedItem!);
                                        },
                                        onMaximumSelected: (allSelectedItems, selectedItem) {
                                          CustomSnackBar.showInSnackBar('The limit has been reached', context);
                                        },
                                      );
                                    }
                                ),
                              ),
                              SizedBox(
                                height: customHeight*0.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  initializeCreateCollaborator();
                                  //  _show(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: context.width(),
                                  height: 70,
                                  decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(25.0),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF7800F0),Color(0xFF00A088) ,  ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: const Text('Add Collaborators',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      letterSpacing: -0.3858822937011719,
                                    ),),
                                ),
                              )



                            ],
                          ),
                        ),
                      ):
                      widget.assetType=="financial_assets" && assetCategory=="insurance"? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ink(
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration:  BoxDecoration(
                                            borderRadius:  BorderRadius.circular(30.0),
                                            border: Border.all( width: 2, color:  const Color(0xFF00A088).withOpacity(0.4)),
                                            color: _colorContainer ,
                                          ),
                                          height: 60,
                                          width: context.width(),

                                          child: const Center(child: Text("Allow access to all properties")),
                                        ),
                                        onTap: () {

                                          setState(() {

                                            isOptionAlreadySelected= !isOptionAlreadySelected;
                                            _colorContainer = isOptionAlreadySelected ?
                                            const Color(0xFF00A088).withOpacity(0.4) :
                                            Colors.white ;
                                          });
                                          print(isOptionAlreadySelected);
                                          isOptionAlreadySelected? _controller.deselectAll():null;

                                        },
                                      )),
                                ],
                              ),

                              SizedBox(
                                height: customHeight*0.3,
                              ),


                              Container(
                                height: context.height()*0.4,
                                child: FutureBuilder(
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
                                                "No Assets Added",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return MultiSelectCheckList(

                                        maxSelectableCount: isOptionAlreadySelected? 0:6,
                                        textStyles: const MultiSelectTextStyles(
                                            selectedTextStyle: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold)),
                                        itemsDecoration: MultiSelectDecorations(
                                            selectedDecoration:
                                            BoxDecoration(
                                              borderRadius:  BorderRadius.circular(25.0),
                                              color: const Color(0xFF00A088).withOpacity(0.4),

                                            )),
                                        listViewSettings: ListViewSettings(
                                            separatorBuilder: (context, index) => const Divider(
                                              height: 10,
                                            )),
                                        controller: _controller,
                                        items: List.generate(
                                            assetList.length,
                                                (index) => CheckListCard(
                                                value: assetList[index].assetID!,
                                                contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
                                                title: Text(assetList[index].assetName!),
                                                selectedColor: Colors.white,
                                                checkColor: const Color(0xFF00A088),
                                                checkBoxGap:20,
                                                textStyles:  const MultiSelectItemTextStyles(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,),
                                                  selectedTextStyle: TextStyle(
                                                    fontSize: 16, ),
                                                ),

                                                checkBoxBorderSide:
                                                const BorderSide(color: Color(0xFF00A088), width: 2),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)))),
                                        onChange: (allSelectedItems, String? selectedItem) {

                                          print(selectedItem!);
                                        },
                                        onMaximumSelected: (allSelectedItems, selectedItem) {
                                          CustomSnackBar.showInSnackBar('The limit has been reached', context);
                                        },
                                      );
                                    }
                                ),
                              ),
                              SizedBox(
                                height: customHeight*0.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  initializeCreateCollaborator();
                                  //  _show(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: context.width(),
                                  height: 70,
                                  decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(25.0),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF7800F0),Color(0xFF00A088) ,  ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: const Text('Add Collaborators',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      letterSpacing: -0.3858822937011719,
                                    ),),
                                ),
                              )



                            ],
                          ),
                        ),
                      ):Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Ink(
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration:  BoxDecoration(
                                            borderRadius:  BorderRadius.circular(30.0),
                                            border: Border.all( width: 2, color:  const Color(0xFF00A088).withOpacity(0.4)),
                                            color: _colorContainer ,
                                          ),
                                          height: 60,
                                          width: context.width(),

                                          child: const Center(child: Text("Allow access to all properties")),
                                        ),
                                        onTap: () {

                                          setState(() {

                                            isOptionAlreadySelected= !isOptionAlreadySelected;
                                            _colorContainer = isOptionAlreadySelected ?
                                            const Color(0xFF00A088).withOpacity(0.4) :
                                            Colors.white ;
                                          });
                                          print(isOptionAlreadySelected);
                                          isOptionAlreadySelected? _controller.deselectAll():null;

                                        },
                                      )),
                                ],
                              ),

                              SizedBox(
                                height: customHeight*0.3,
                              ),


                              Container(
                                height: context.height()*0.4,
                                child: FutureBuilder(
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
                                                "No Assets Added",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return MultiSelectCheckList(

                                        maxSelectableCount: isOptionAlreadySelected? 0:6,
                                        textStyles: const MultiSelectTextStyles(
                                            selectedTextStyle: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold)),
                                        itemsDecoration: MultiSelectDecorations(
                                            selectedDecoration:
                                            BoxDecoration(
                                              borderRadius:  BorderRadius.circular(25.0),
                                              color: const Color(0xFF00A088).withOpacity(0.4),

                                            )),
                                        listViewSettings: ListViewSettings(
                                            separatorBuilder: (context, index) => const Divider(
                                              height: 10,
                                            )),
                                        controller: _controller,
                                        items: List.generate(
                                            assetList.length,
                                                (index) => CheckListCard(
                                                value: assetList[index].assetID!,
                                                contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 30),
                                                title: Text(assetList[index].assetName!),
                                                selectedColor: Colors.white,
                                                checkColor: const Color(0xFF00A088),
                                                checkBoxGap:20,
                                                textStyles:  const MultiSelectItemTextStyles(
                                                  textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,),
                                                  selectedTextStyle: TextStyle(
                                                    fontSize: 16, ),
                                                ),

                                                checkBoxBorderSide:
                                                const BorderSide(color: Color(0xFF00A088), width: 2),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)))),
                                        onChange: (allSelectedItems, String? selectedItem) {

                                          print(selectedItem!);
                                        },
                                        onMaximumSelected: (allSelectedItems, selectedItem) {
                                          CustomSnackBar.showInSnackBar('The limit has been reached', context);
                                        },
                                      );
                                    }
                                ),
                              ),
                              SizedBox(
                                height: customHeight*0.2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  initializeCreateCollaborator();
                                  //  _show(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: context.width(),
                                  height: 70,
                                  decoration:  BoxDecoration(
                                    borderRadius:  BorderRadius.circular(25.0),
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF7800F0),Color(0xFF00A088) ,  ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  child: const Text('Add Collaborators',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xffffffff),
                                      letterSpacing: -0.3858822937011719,
                                    ),),
                                ),
                              )



                            ],
                          ),
                        ),
                      ),
                    ]),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //
              //     position>0?GestureDetector(
              //       onTap: () {
              //         print(position);
              //         setState(() {
              //           if (position >0 ) {
              //             position--;
              //             pageController!.previousPage(
              //                 duration: const Duration(microseconds: 300),
              //                 curve: Curves.linear);
              //           } else {
              //             initializeCompleteProfile();
              //           }
              //         });
              //       },
              //       child: const Padding(
              //         padding: EdgeInsets.all(25),
              //         child: DecoratedBox(
              //           decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: NBPrimaryColor
              //           ),
              //           child: Padding(
              //             padding: EdgeInsets.all(25),
              //             child: Icon(
              //                 Icons.arrow_back,
              //                 color: Colors.white
              //             ),
              //           ),
              //         ),
              //       ),
              //     ):Container(),
              //
              //   ],
              // ),



            ],
          ),
        ),
      ),
    );
  }

  initializeCreateCollaborator() {
    print("Its workimg");
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    var collabDetails = CollaboratorModel();
    collabDetails.fullName = fullNameController.text;
    collabDetails.emailAddress = emailAddressController.text;
    List<String> selectedItems=_controller.getSelectedItems();

    apiCall.createCollaborator(
        collabDetails,
        selectedItems,
        assetType!,
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
