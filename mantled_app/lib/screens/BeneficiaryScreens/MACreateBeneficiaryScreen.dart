import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
//import 'package:mantled_app/component/StepComponent.dart';
import 'package:mantled_app/constants/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:mantled_app/model/addbeneficiaryModel.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mantled_app/networking/rest_data.dart';
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

import '../DashboardScreens/EnterPinScreenWidgets/myModel.dart';
import '../DashboardScreens/MADashboardScreen.dart';


class MACreateBeneficiaryScreen extends StatefulWidget {
  static String tag = '/MACreateBeneficiaryScreen';

  final String assetID;
  final String myAssetType;

  const MACreateBeneficiaryScreen({Key? key, required this.assetID, required this.myAssetType}) : super(key: key);

  @override
  MACreateBeneficiaryScreenState createState() => MACreateBeneficiaryScreenState();
}

class MACreateBeneficiaryScreenState extends State<MACreateBeneficiaryScreen> {
  List<String> mPages = <String>[
    brainstorming1,
    financialdata1,
    onlinetransactions1
  ];


  var allSteps= ["Naming", "Address", "Uploads"];


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



  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String? maritalStatusValue;
  String? nationalityValue;
  String? governmentIDName;
  final MultiSelectController<String> _controller = MultiSelectController();
  int position = 0;
  PageController? pageController;
  int newPostion = 0;
  //
  // final _pages = <Widget>[
  //   const StepOneComponent(),
  //   const StepOneComponent(),
  // ];

  @override
  void initState() {
    super.initState();
    init();
  }

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
                      Text('Create Beneficiary',
                        style: boldTextStyle(color:Colors.black, size: 25,weight: FontWeight.w500 ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  SizedBox(
                    height:  customHeight*0.1,
                  ),
                  Row(
                    children: [
                      Text('Add a new beneficiary.',
                        style: secondaryTextStyle( size: 16, ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ):Container(),

              SizedBox(
                height:  customHeight*0.5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    8.height,
                    nbAppTextFieldWidget(
                      fullNameController,
                      'Full Name',
                      TextFieldType.PHONE,
                    ),
                    25.height,
                    nbAppTextFieldWidget(
                      emailAddressController,
                      'Email Address',
                      TextFieldType.PHONE,
                    ),
                    25.height,
                    IntlPhoneField(
                      controller: phoneController,

                      decoration:   InputDecoration(
                        contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
                        filled: true,
                        labelText: "Phone Number",
                        fillColor: Colors.white.withOpacity(0.1),
                        hintText: "Phone Number",
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey.withOpacity(0.2) , width: 2),//border Color
                        ),
                        hintStyle: secondaryTextStyle(),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius:  BorderRadius.circular(30.0),
                          borderSide:  BorderSide(color: Colors.grey.withOpacity(0.2) ,width:2),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:  BorderRadius.circular(30.0),
                          borderSide:  const BorderSide(color:  NBPrimaryColor ,width: 2 ),

                        ),
                      ),
                      initialCountryCode: 'NG',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),

                    SizedBox(
                      height: customHeight*0.6,
                    ),

                   GestureDetector(
                      onTap: () {
                        initializeCreateBeneficiary();
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
                        child: const Text('Create beneficiary ',
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


            ],
          ),
        ),
      ),
    );
  }


  initializeCreateBeneficiary() {
    print("Its workimg");
    print("This is the beneficiary");
    print(widget.assetID);
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    var addBeneficiary = AddBeneficiary();
    addBeneficiary.fullName = fullNameController.text;
    addBeneficiary.emailAddress = emailAddressController.text;
    addBeneficiary.phoneNumber = phoneController.text;
    apiCall.createBeneficiary(
      addBeneficiary,
      widget.assetID,
      widget.myAssetType
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
