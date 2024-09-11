import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mantled_app/model/housing_property_model.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/screens/OnboardingScreens/MAMembershipScreen.dart';
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
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import '../BeneficiaryScreens/MABeneficiaryScreen.dart';


class MACreateFinancialAssetScreen extends StatefulWidget {
  static String tag = '/MACreateFinancialAssetScreen';

  final String assetType;
  const MACreateFinancialAssetScreen({Key? key, required this.assetType}) : super(key: key);

  @override
  MACreateFinancialAssetScreenState createState() => MACreateFinancialAssetScreenState();
}

class MACreateFinancialAssetScreenState extends State<MACreateFinancialAssetScreen> {
  List<String> mPages = <String>[
    brainstorming1,
    financialdata1,
    onlinetransactions1
  ];

  String stateValue = NigerianStatesAndLGA.allStates[0];
  String lgaValue = 'Select a Local Government Area';
  String selectedLGAFromAllLGAs = NigerianStatesAndLGA.getAllNigerianLGAs()[0];
  List<String> statesLga = [];


  List<String?> maritalStatus = [];
  List<String> headings = <String>[heading1, heading2, heading3];
  List<String> subHeadings = <String>[subheading1, subheading2, subheading3];
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _dateController = TextEditingController();
  List<String?> stateList = [
    "States",
    "Lagos",
    "Ogun",
    "Ekiti",
    "Ebonyi",
  ];
  // List<String?> nationalityList = [
  //   "Document Type",
  //   "Nigeria",
  //   "South Africa",
  //   "Israel",
  //   "Egypt",
  // ];
  void _show(BuildContext ctx, String assetID) {
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
                'Asset has been added to Real Estate Successfully ',
                style: primaryTextStyle(color: black,size: 19),

                textAlign: TextAlign.center,
              ),
              50.height,

              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: GestureDetector(
                  onTap: () async {

                    assetTypeValue=="Cash"?
                    MABeneficiaryScreen(assetID: assetID,  assetType: "Debts").launch(context):
                    assetTypeValue=="Crypto-Currency"?
                    MABeneficiaryScreen(assetID: assetID,  assetType: "CryptoAssets").launch(context):
                    assetTypeValue=="Pension Scheme"?
                    MABeneficiaryScreen(assetID: assetID,  assetType: "PensionAssets").launch(context):
                    assetTypeValue=="Insurance Policy"?
                    MABeneficiaryScreen(assetID: assetID,  assetType: "InsuranceAssets").launch(context):
                        Container();
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

  List<String?> governmentIDList = [
    "LGA",
    "Kosofe",
    "Ikeja",
    "Mainland",
  ];
  String? _fileName2;
  String? _saveAsFileName2;
  List<PlatformFile>? _paths2;
  String? _directoryPath2;
  String? _extension2;
  bool _isLoading2 = false;
  bool _userAborted2 = false;
  final bool _multiPick2 = true;

  var allSteps= ["Naming", "Financial Details", "Uploads"];

  void _resetState2() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading2 = true;
      _directoryPath2 = null;
      _fileName2 = null;
      _paths2 = null;
      _saveAsFileName2 = null;
      _userAborted2 = false;
    });
  }



  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _pickFiles2() async {
    _resetState2();
    try {
      _directoryPath2 = null;
      _paths2 = (await FilePicker.platform.pickFiles(
        allowMultiple: _multiPick2,
        onFileLoading: (FilePickerStatus status) => print(status),
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      _logException('Unsupported operation$e');
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading2 = false;
      _fileName2 =
      _paths2 != null ? _paths2!.map((e) => e.name).toString() : '...';
      _userAborted2 = _paths2 == null;
    });
  }

  late String _setDate;
  File? coverImage;
  ImagePicker imagePicker = ImagePicker();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101)))!;

    setState(() {
      selectedDate = picked;
      _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    });
  }

  static const _locale = 'en';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;


  Future<void> pickPhoto() async {
    var photo = await imagePicker.pickImage(source: ImageSource.gallery);
    print(photo!.path);
    coverImage = File(photo.path);
    final CroppedFile? cropImage = await ImageCropper().cropImage(
      sourcePath: coverImage!.path,
      maxHeight: 1080,
      maxWidth: 1080,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      //cropStyle: CropStyle.circle,
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          statusBarColor: NBPrimaryColor,
          toolbarTitle: 'Crop Image',
          toolbarColor: NBPrimaryColor,
          cropGridStrokeWidth: 2,
        ),
        IOSUiSettings(rectX: 1, rectY: 1)
      ],
    );
    setState(() {
      coverImage = File(cropImage!.path);
    });
    print(await coverImage!.length() / 1024 / 1024);
    print(await coverImage!.path);
  }


  String docValue="Select Asset Type";
  String propValue="Select Asset Type";

  String assetTypeValue="Select Asset Type";
  String pensionPlanTypeValue="Select Pension Plan Type";
  String insurancePlanTypeValue="Select Insurance Plan Type";
  String cryptoCurrencyType="Select Cryotocurrency Type";
  List<String> documentTypeList = [
    "Select Asset Type",
    "Deed of assignment",
    "Deed of Conveyance",
    "Survey Plan",
    "The Sale and Purchase Agreement",
    "C of O Document"];

  List<String> propertyTypeList = [
    "Select Asset Type",
    "Cash",
    "Crypto-Currency",
    "Pension Scheme",
    "Insurance Policy",
  ];

  List<String> cryptoCurrencyList = [
    "Select Cryotocurrency Type",
    "Bitcoin (BTC)",
    "Ethereum (ETH)",
    "Tether (USDT)",
    "Binance Coin (BNB)",
    "USD Coin (USDC)",
    "Solana (SOL)",
    "Dogecoin (DOGE)"
    "Tron (TRX)"
    "Toncoin (TON)"
  ];

  List<String> assetTypeList = [
    "Select Asset Type",
    "Cash",
    "Crypto-Currency",
    "Pension Scheme",
    "Insurance Policy",

  ];

  List<String> pensionPlanType = [
    "Select Pension Plan Type",
    "Deferred Annuity",
    "Immediate Annuity",
    "Life Cover",
    "Guaranteed Period Annuity",
    "Annuity Certain",
    "Life Annuity",
    "Pension Funds",
    "National Pension Scheme"
    "Employee Provident Fund"

  ];

  List<String> insuranceSchemeType= [
    "Select Insurance Plan Type",
    "Home or property insurance",
    "life insurance",
    "Disability insurance",
    "Automobile insurance",

  ];


  TextEditingController assetNameController = TextEditingController();
  TextEditingController cashController = TextEditingController();
  TextEditingController cashAccountManagerController = TextEditingController();
  TextEditingController cashAmountController = TextEditingController();
  TextEditingController financialInstitutionController = TextEditingController();
  TextEditingController accountManagerController = TextEditingController();
  TextEditingController cryptoAmountController = TextEditingController();
  TextEditingController platformController = TextEditingController();
  TextEditingController pensionProviderController = TextEditingController();
  TextEditingController pensionAmountController = TextEditingController();
  TextEditingController insuranceCompanyController = TextEditingController();
  TextEditingController insuranceAmountController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();



  String? stateName;
  String? nationalityValue;
  String? localGovmentName;

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
                height:  customHeight*0.8,
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
                      Text("Financial", style: primaryTextStyle(weight: FontWeight.w500),),
                      const SizedBox(width: 10,),
                      Image.asset("assets/png/financial.png"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height:  customHeight*0.3,
              ),
              Row(
                children: [
                  Text('Add Asset Info',
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
                  Text('STEP ',
                      style: primaryTextStyle(color: Colors.black, size: 15)),
                  Text('${position + 1} OF 3 ',
                      style: primaryTextStyle(color: Colors.black, size: 15)),
                  Text('- ${allSteps[position]}',
                      style: boldTextStyle(color: NBPrimaryColor, size: 15)),
                ],
              ),
              position==2? Column(
                children: [
                  SizedBox(
                    height:  customHeight*0.1,
                  ),
                  const Row(
                    children: [
                      Text("(Format: pdf, png, jpeg only) 50mb Max", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,),
                    ],
                  ),
                ],
              ):Container(),

              SizedBox(
                height:  customHeight*0.5,
              ),
              SizedBox(
                height: context.height() * 0.53,
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
                              assetNameController,
                              'Asset Name',
                              TextFieldType.NAME,
                            ),
                            SizedBox(
                              height:  customHeight*0.3,
                            ),
                            SizedBox(
                              child: DropdownButtonFormField<String>(

                                  value: assetTypeValue,
                                  isExpanded: true,
                                  hint: const Text('Select Asset Type'),
                                  decoration: nbInputDecoration(
                                      bgColor: Colors.white,
                                      padding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 25)),
                                  items: assetTypeList
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      assetTypeValue = val!;

                                    });
                                    print(assetTypeValue);
                                  }),
                            ),
                            SizedBox(
                              height:  customHeight*0.3,
                            ),
                            nbAppTextFieldWidget(
                              countryNameController,
                              'Country',
                              TextFieldType.NAME,
                            ),
                          ],
                        ),
                      ),


                      assetTypeValue=="Cash"? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height:  customHeight*0.1,
                              ),
                              TextField(
                                controller: cashAmountController,

                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                                  filled: true,
                                  isDense: true,
                                  labelText: "Value Amount",
                                  prefixIcon: const Icon(CupertinoIcons.creditcard),
                                  fillColor: Colors.white.withOpacity(0.1),
                                  hintText: "Value Amount",

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
                                onChanged: (string) {
                                  string = _formatNumber(string.replaceAll(',', ''));
                                  cashAmountController.value = TextEditingValue(
                                    text: string,
                                    selection: TextSelection.collapsed(offset: string.length),
                                  );
                                },
                              ),
                              25.height,
                              nbAppTextFieldWidget(
                                financialInstitutionController,
                                'Financial Institution',
                                TextFieldType.NAME,
                              ),
                              25.height,
                              nbAppTextFieldWidget(
                                cashAccountManagerController,
                                'Account Manager',
                                TextFieldType.NAME,
                              ),

                              SizedBox(
                                height: customHeight*0.3,
                              ),

                            ],
                          ),
                        ),
                      ):

                      assetTypeValue=="Insurance Policy"? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height:  customHeight*0.1,
                              ),
                          SizedBox(
                                      child: DropdownButtonFormField<String>(

                                          value: insurancePlanTypeValue,
                                          isExpanded: true,
                                          hint: const Text('Select Insurance Plan Type'),
                                          decoration: nbInputDecoration(
                                              bgColor: Colors.white,
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 25,
                                                  vertical: 25)),
                                          items: insuranceSchemeType
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  child: Text(value),
                                                  value: value,
                                                );
                                              }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              insurancePlanTypeValue = val!;
                                            });
                                          }),
                                    ),
                              15.height,
                              nbAppTextFieldWidget(
                                insuranceCompanyController,
                                'Insurance Company',
                                TextFieldType.NAME,
                              ),
                              25.height,
                              AppTextField(
                              textFieldType: TextFieldType.NUMBER,
                              controller: insuranceAmountController,

                              textStyle:  primaryTextStyle(size: 15),
                              textInputAction: TextInputAction.next,

                              decoration: InputDecoration(
                                contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                                filled: true,
                                isDense: true,
                                labelText: "Amount",
                                prefixIcon: const Icon(Icons.account_balance_wallet_sharp),
                                fillColor: Colors.white.withOpacity(0.1),
                                hintText: "Amount",

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
                              )
                              ),


                              SizedBox(
                                height: customHeight*0.3,
                              ),

                            ],
                          ),
                        ),
                      ):

                      assetTypeValue=="Pension Scheme"?  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height:  customHeight*0.1,
                              ),
                              SizedBox(
                                child: DropdownButtonFormField<String>(

                                    value: pensionPlanTypeValue,
                                    isExpanded: true,
                                    hint: const Text('Select Pension Plan Type'),
                                    decoration: nbInputDecoration(
                                        bgColor: Colors.white,
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 25)),
                                    items: pensionPlanType
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        pensionPlanTypeValue = val!;
                                      });
                                    }),
                              ),
                              15.height,
                              nbAppTextFieldWidget(
                                pensionProviderController,
                                'Pension Provider',
                                TextFieldType.EMAIL,
                              ),
                              25.height,
                              AppTextField(
                                  textFieldType: TextFieldType.NUMBER,
                                  controller: pensionAmountController,
                                  textStyle:  primaryTextStyle(size: 15),
                                  textInputAction: TextInputAction.next,

                                  decoration: InputDecoration(
                                    contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                                    filled: true,
                                    isDense: true,
                                    labelText: "Amount",
                                    prefixIcon: const Icon(Icons.account_balance_wallet_sharp),
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: "Amount",

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
                                  )
                              ),


                              SizedBox(
                                height: customHeight*0.3,
                              ),

                            ],
                          ),
                        ),
                      ):
                      assetTypeValue=="Crypto-Currency"? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height:  customHeight*0.1,
                              ),
                              SizedBox(
                                child: DropdownButtonFormField<String>(

                                    value: cryptoCurrencyType,
                                    isExpanded: true,
                                    hint: const Text('Select Cryotocurrency Type'),
                                    decoration: nbInputDecoration(
                                        bgColor: Colors.white,
                                        padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 25)),
                                    items: cryptoCurrencyList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        cryptoCurrencyType = val!;
                                      });
                                    }),
                              ),
                              15.height,

                              TextField(
                                controller: cryptoAmountController,

                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                                  filled: true,
                                  isDense: true,
                                  labelText: "Value Amount",
                                  prefixIcon: const Icon(CupertinoIcons.creditcard),
                                  fillColor: Colors.white.withOpacity(0.1),
                                  hintText: "Value Amount",

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
                                onChanged: (string) {
                                  string = _formatNumber(string.replaceAll(',', ''));
                                  cashAmountController.value = TextEditingValue(
                                    text: string,
                                    selection: TextSelection.collapsed(offset: string.length),
                                  );
                                },
                              ),
                              25.height,
                              nbAppTextFieldWidget(
                                platformController,
                                'Platform',
                                TextFieldType.NAME,
                              ),


                              SizedBox(
                                height: customHeight*0.3,
                              ),

                            ],
                          ),
                        ),
                      ):Container(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height:  customHeight*0.1,
                            ),

                            20.height,

                            // SizedBox(
                            //   child: DropdownButtonFormField(
                            //     icon: const Icon(
                            //       Icons.arrow_drop_down_rounded,
                            //       color: NBPrimaryColor,
                            //     ),
                            //     value: nationalityList[0],
                            //     isExpanded: true,
                            //     decoration: nbInputDecoration(
                            //         bgColor: Colors.white,
                            //         padding: const EdgeInsets.symmetric(
                            //             horizontal: 20, vertical: 25)),
                            //     items: nationalityList.map((String? value) {
                            //       return DropdownMenuItem<String>(
                            //         value: value,
                            //         child:
                            //         Text(value!, style: primaryTextStyle()),
                            //       );
                            //     }).toList(),
                            //     onChanged: (value) {
                            //       setState(() {
                            //         localGovmentName = value.toString();
                            //       });
                            //     },
                            //   ),
                            // ),
                            // 16.height,
                            Container(
                              padding: const EdgeInsets.only(left: 16, top:5 , bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 2),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _paths2 != null
                                      ? _resetState2()
                                      : _pickFiles2();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _paths2 != null
                                          ? 'Delete Documents'
                                          : "Add Documents",
                                      style: primaryTextStyle(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(

                                        decoration: boxDecorationWithRoundedCorners(
                                          backgroundColor: const Color(0xFFF5F0FF),
                                          borderRadius: BorderRadius.circular(25),
                                          border: Border.all(
                                              color: Colors.grey.withOpacity(0.2)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 15),
                                          child: Icon(
                                            _paths2 != null
                                                ? Icons.delete
                                                :Icons.photo,
                                            size: 20,
                                            color: const Color(0xFF700BE9),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: _paths2 != null ? 120 : 0,
                              child: Builder(
                                builder: (BuildContext context) => _isLoading2
                                    ? const Padding(
                                  padding: EdgeInsets.only(bottom: 0.0),
                                  child: CircularProgressIndicator(),
                                )
                                    : _userAborted2
                                    ?  Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Text(
                                    'User has aborted the dialog',
                                    style: boldTextStyle(),
                                  ),
                                )
                                    : _directoryPath2 != null
                                    ? ListTile(
                                  title:  Text('Directory path', style: boldTextStyle(),),
                                  subtitle: Text(_directoryPath2!),
                                )
                                    : _paths2 != null
                                    ? Container(
                                  padding:
                                  const EdgeInsets.only(bottom: 0.0),
                                  height: 20,
                                  child: Scrollbar(
                                      child: ListView.separated(
                                        itemCount:
                                        _paths2 != null && _paths2!.isNotEmpty
                                            ? _paths2!.length
                                            : 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {

                                          final bool isMultiPath =
                                              _paths2 != null &&
                                                  _paths2!.isNotEmpty;
                                          final String name = 'File $index: ${isMultiPath
                                              ? _paths2!
                                              .map((e) => e.name)
                                              .toList()[index]
                                              : _fileName2 ?? '...'}';
                                          final path = kIsWeb
                                              ? null
                                              : _paths2!
                                              .map((e) => e.path)
                                              .toList()[index]
                                              .toString();

                                          return ListTile(
                                            visualDensity: const VisualDensity(horizontal: 0, vertical: -4),

                                            title: Text(
                                              name,
                                            ),
                                            leading: Container(

                                              decoration:
                                              boxDecorationWithRoundedCorners(
                                                backgroundColor:
                                                Colors.green.withOpacity(0.2),

                                                borderRadius:
                                                BorderRadius.circular(60),
                                                border: Border.all(
                                                    color:
                                                    const Color(0xFFF5F0FF)),
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(CupertinoIcons.photo,size: 18,
                                                  color:   Color(0xFF006C67),),
                                              ),
                                            ),
                                            subtitle: const Text("Housing Document"),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                        const Divider(),
                                      )),
                                )
                                    : _saveAsFileName2 != null
                                    ? ListTile(
                                  title: const Text('Save file'),
                                  subtitle: Text(_saveAsFileName2!),
                                )
                                    : const SizedBox(),
                              ),
                            ),


                            SizedBox(
                              height: customHeight*0.6,
                            ),
                            position==2?  GestureDetector(
                              onTap: () {
                             //   initializeCreateAsset();
                                if(assetTypeValue=="Cash"){
                                  initializeCreateCashAsset();
                                }
                                else if(assetTypeValue=="Crypto-Currency"){
                                  initializeCreateCryptoAsset();
                                }
                                else if(assetTypeValue=="Pension Scheme"){
                                  initializeCreatePensionAsset();
                                }
                                else if(assetTypeValue=="Insurance Policy"){
                                  initializeCreateInsuranceAsset();
                                }

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
                                child: const Text('Continue',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color(0xffffffff),
                                    letterSpacing: -0.3858822937011719,
                                  ),),
                              ),
                            ):Container(),
                          ],
                        ),
                      ),
                    ]),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  position>0?GestureDetector(
                    onTap: () {
                      print(position);
                      setState(() {
                        if (position >0 ) {
                          position--;
                          pageController!.previousPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.linear);
                        } else {
                          //   initializeCompleteProfile();
                        }
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(25),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NBPrimaryColor
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Icon(
                              Icons.arrow_back,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ):Container(),
                  position >=0 && position<2?GestureDetector(
                    onTap: () {
                      print(position);
                      setState(() {
                        if (position < 2) {
                          position++;
                          pageController!.nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.linear);
                        }
                        else {


                          //initializeCompleteProfile();
                        }
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(25),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: NBPrimaryColor
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ):Container(),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }


  initializeCreateCashAsset() async {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    final prefs = await SharedPreferences.getInstance();

    var assetData = AssetModel();
    assetData.propTitle = assetNameController.text;
    assetData.accountManager = cashAccountManagerController.text;
    assetData.assetType = assetTypeValue;
    assetData.amount = cashAmountController.text;
    assetData.financialInstitution = financialInstitutionController.text;
    assetData.countryName=countryNameController.text;


    String amount = cashAmountController.text.replaceAll(",","");
    print(amount);
    assetData.valueAmount = int.parse(amount) ;
    if (_paths2!=null){
      await apiCall.createCashAsset(assetData)
          .then((value) {

        Fluttertoast.showToast(
          msg: "Asset Details registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print(value);
        print("This is the id");
        var assetID= value;

        apiCall.uploadAssetDocuments(_paths2!, assetID,  "${widget.assetType}_cash")
            .then((value) {
          print("This is the value returned");
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
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            loader.Loader.hide();
            _show(context,assetID);

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
    else{
      loader.Loader.hide();
      Fluttertoast.showToast(
        msg: "Please add Documents",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  initializeCreateCryptoAsset() async {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    final prefs = await SharedPreferences.getInstance();

    var assetData = AssetModel();

    assetData.propTitle = assetNameController.text;
    assetData.cryptoType = cryptoCurrencyType;
    assetData.assetType = assetTypeValue;
    assetData.amount = cryptoAmountController.text;
    assetData.platformName = platformController.text;
    assetData.countryName=countryNameController.text;
    if (_paths2!=null){
      await apiCall.createCryptoAsset(assetData)
          .then((value) {
        String? fullName=prefs.getString('fullName');
        String? photo=prefs.getString('photo');
        Fluttertoast.showToast(
          msg: "Asset Details registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print(value);
        print("This is the id");
        var assetID= value;

        apiCall.uploadAssetDocuments(_paths2!, assetID, "${widget.assetType}_crypto" )
            .then((value) {
          print("This is the value returned");
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
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            loader.Loader.hide();
            _show(context,assetID);

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
    else{
      loader.Loader.hide();
      Fluttertoast.showToast(
        msg: "Please add Documents",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  initializeCreatePensionAsset() async {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    final prefs = await SharedPreferences.getInstance();

    var assetData = AssetModel();
    assetData.propTitle = assetNameController.text;
    assetData.countryName = countryNameController.text;
    assetData.assetType = assetTypeValue;
    assetData.amount = pensionAmountController.text;
    assetData.pensionType = pensionPlanTypeValue;
    assetData.pensionProvider=pensionProviderController.text;
    if (_paths2!=null){
      await apiCall.pensionAsset(assetData)
          .then((value) {
        String? fullName=prefs.getString('fullName');
        String? photo=prefs.getString('photo');
        Fluttertoast.showToast(
          msg: "Asset Details registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print(value);
        print("This is the id");
        var assetID= value;

        apiCall.uploadAssetDocuments(_paths2!, assetID, "${widget.assetType}_pension" )
            .then((value) {
          print("This is the value returned");
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
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            loader.Loader.hide();
            _show(context,assetID);

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
    else{
      loader.Loader.hide();
      Fluttertoast.showToast(
        msg: "Please add Documents",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  initializeCreateInsuranceAsset() async {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    final prefs = await SharedPreferences.getInstance();

    var assetData = AssetModel();
    assetData.propTitle = assetNameController.text;
    assetData.countryName = countryNameController.text;
    assetData.assetType = assetTypeValue;
    assetData.amount = insuranceAmountController.text;
    assetData.insuranceType = insurancePlanTypeValue;
    assetData.insuranceCompany=insuranceCompanyController.text;
    if (_paths2!=null){
      await apiCall.insuranceAsset(assetData)
          .then((value) {
        String? fullName=prefs.getString('fullName');
        String? photo=prefs.getString('photo');
        Fluttertoast.showToast(
          msg: "Asset Details registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print(value);
        print("This is the id");
        var assetID= value;

        apiCall.uploadAssetDocuments(_paths2!, assetID, "${widget.assetType}_insurance" )
            .then((value) {
          print("This is the value returned");
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
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            loader.Loader.hide();
            _show(context,assetID);

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
    else{
      loader.Loader.hide();
      Fluttertoast.showToast(
        msg: "Please add Documents",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

//
// TextEditingController accountManagerController = TextEditingController();
// TextEditingController cryptoAmountController = TextEditingController();
// TextEditingController platformController = TextEditingController();
// TextEditingController pensionProviderController = TextEditingController();
// TextEditingController pensionAmountController = TextEditingController();
// TextEditingController insuranceCompanyController = TextEditingController();
// TextEditingController insuranceAmountController = TextEditingController();