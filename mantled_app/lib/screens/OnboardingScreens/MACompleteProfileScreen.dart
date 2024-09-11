import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
//import 'package:mantled_app/component/StepComponent.dart';
import 'package:mantled_app/constants/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mantled_app/networking/rest_data.dart';
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

class MACompleteProfileScreen extends StatefulWidget {
  static String tag = '/MACompleteProfileScreen';

  const MACompleteProfileScreen({Key? key}) : super(key: key);

  @override
  MACompleteProfileScreenState createState() => MACompleteProfileScreenState();
}

class MACompleteProfileScreenState extends State<MACompleteProfileScreen> {
  List<String> mPages = <String>[
    brainstorming1,
    financialdata1,
    onlinetransactions1
  ];
  List<String> headings = <String>[heading1, heading2, heading3];
  List<String> subHeadings = <String>[subheading1, subheading2, subheading3];
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _dateController = TextEditingController();
  List<String?> maritalStatus = [
    "Marital Status",
    "Married",
    "Single",
    "Divorced",
    "Widow",
  ];
  List<String?> nationalityList = [
    "Nationality",
    "Nigeria",
    "South Africa",
    "Israel",
    "Egypt",
  ];
  List<String?> governmentIDList = [
    "Government ID",
    "Driver's License",
    "National ID",
    "International Passport",
  ];
  String? _fileName2;
  String? _saveAsFileName2;
  List<PlatformFile>? _paths2;
  String? _directoryPath2;
  String? _extension2;
  bool _isLoading2 = false;
  bool _userAborted2 = false;
  final bool _multiPick2 = false;

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
        firstDate: DateTime(1901),
        lastDate: DateTime(2101)))!;

    setState(() {
      selectedDate = picked;
      _dateController.text = DateFormat('dd MM yyyy').format(selectedDate);
    });
  }

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

  TextEditingController childrenNumController = TextEditingController();
  TextEditingController kinNameController = TextEditingController();
  TextEditingController kinEmailController = TextEditingController();
  TextEditingController kinPhoneController = TextEditingController();
  String? maritalStatusValue;
  String? nationalityValue;
  String? governmentIDName;

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
                height:  customHeight*0.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Image.asset("assets/png/material-arrow-back.png").onTap(() {
                    finish(context);
                  }),
                  Image.asset(logoImage),
                ],
              ),
              SizedBox(
                height:  customHeight*0.3,
              ),
              Row(
                children: [
                  Text('Complete your info',
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
                  Text('${position + 1} OF 3',
                      style: primaryTextStyle(color: Colors.black, size: 15)),
                ],
              ),
              SizedBox(
                height:  customHeight*0.1,
              ),
              SizedBox(
                height: context.height() * 0.63,
                child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                child: Column(
                                  children: [
                                    coverImage
                                        == null
                                        ? Container(
                                      decoration:
                                      boxDecorationWithRoundedCorners(
                                        backgroundColor:
                                        const Color(0xFFF5F0FF),

                                        borderRadius:
                                        BorderRadius.circular(60),
                                        border: Border.all(
                                            color:
                                            const Color(0xFFF5F0FF)),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(40.0),
                                        child:
                                        Icon(Icons.image, weight: 1, color:Colors.purple, size: 40,),
                                      ),
                                    )
                                        : Container(
                                        width: 120,
                                        height: 120,
                                        decoration:boxDecorationWithRoundedCorners(
                                          backgroundColor:
                                          const Color(0xFFD2D7DF)
                                              .withOpacity(0.5),
                                          borderRadius:
                                          BorderRadius.circular(60),
                                          border: Border.all(
                                              color:
                                              Colors.grey.withOpacity(0.2)),
                                        ),
                                        child: Image.file(coverImage!,
                                          fit: BoxFit.fill,


                                        ).cornerRadiusWithClipRRect(60)),
                                    16.height,
                                    coverImage!=null?
                                    GestureDetector(
                                      onTap: () {
                                        pickPhoto();
                                      },
                                      child:  Container(
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                        margin: const EdgeInsets.only(top: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                              color: NBPrimaryColor.withOpacity(0.2),
                                              width: 2),
                                        ),
                                        child: Text(
                                          'Tap to change profile image',
                                          style: primaryTextStyle(
                                              weight: FontWeight.bold,
                                              size: 15, color: black),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ):
                                    GestureDetector(
                                      onTap: () {
                                        pickPhoto();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                        margin: const EdgeInsets.only(top: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                              color: NBPrimaryColor.withOpacity(0.2),
                                              width: 2),
                                        ),
                                        child: Text(
                                          'Add profile image',
                                          style: primaryTextStyle(
                                              size: 15, color: NBPrimaryColor),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    20.height,
                                    InkWell(
                                      onTap: () {
                                        _selectDate(context);
                                      },
                                      child: TextFormField(
                                          style: const TextStyle(fontSize: 17, color: Colors.black),
                                          textAlign: TextAlign.start,
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          controller: _dateController,
                                          onSaved: (val) {
                                            _setDate = val!;
                                          },
                                          decoration: InputDecoration(
                                            contentPadding: const EdgeInsets.only(
                                                left: 20,
                                                right: 10,
                                                top: 25,
                                                bottom: 20),
                                            filled: true,
                                            fillColor:
                                            Colors.white.withOpacity(0.1),
                                            hintText: "Date of Birth",
                                            hintStyle: primaryTextStyle(),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  width: 2),
                                            ),
                                            suffixIcon:
                                            const Icon(Icons.date_range, color: NBPrimaryColor,),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  width: 2),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(30.0),
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  width: 2),
                                            ),
                                          )),
                                    ),
                                    16.height,
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: DropdownButtonFormField(
                                  icon: const Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: NBPrimaryColor,
                                  ),
                                  dropdownColor: Colors.white,
                                  value: maritalStatus[0],

                                  decoration: nbInputDecoration(
                                      bgColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 25)),
                                  items: maritalStatus.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child:
                                      Text(value!, style: primaryTextStyle()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      maritalStatusValue = value.toString();
                                    });
                                  },
                                ),
                              ),
                              8.height,
                              nbAppTextFieldWidget(
                                childrenNumController,
                                'Number of Children',
                                TextFieldType.PHONE,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height:  customHeight*0.5,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              margin: const EdgeInsets.only(top: 10),
                              alignment: Alignment.topLeft,

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: grey.withOpacity(0.2),
                                    width: 2),
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Expanded(
                                    child: CountryCodePicker(
                                        onChanged: print,
                                        alignLeft:true,
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: 'NG',
                                        favorite: ['+234','NG'],
                                        // optional. Shows only country name and flag
                                        showCountryOnly: true,
                                        showFlag: true,

                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: true,

                                        // optional. aligns the flag and the Text left
                                        onInit: (code) {
                                          nationalityValue=code!.name;


                                        }

                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down_sharp)
                                ],
                              ),
                            ),

                            20.height,
                            SizedBox(
                              child: DropdownButtonFormField(
                                icon: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: NBPrimaryColor,
                                ),
                                value: governmentIDList[0],
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
                                  setState(() {
                                    governmentIDName = value.toString();
                                  });
                                },
                              ),
                            ),
                            16.height,
                            GestureDetector(
                              onTap: (){
                                _paths2 != null && _paths2!.isNotEmpty
                                    ? _resetState2()
                                    : _pickFiles2();
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 16, top:5 , bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _paths2 != null
                                          ? 'Delete Document'
                                          : "Add Document",
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
                                                child: Icon(Icons.file_copy_outlined,size: 18,
                                                  color:   Color(0xFF006C67),),
                                              ),
                                            ),
                                            subtitle: const Text("Identification Document"),
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
                              height:  customHeight*0.1,
                            ),
                            const Row(
                              children: [
                                Text("(Format: pdf, png, jpeg only) 50mb Max", style: TextStyle(color: NBPrimaryColor, fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,),
                              ],
                            )

                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height:  customHeight*0.8,
                            ),
                            nbAppTextFieldWidget(
                              kinNameController,
                              'Name of Next of kin',
                              TextFieldType.EMAIL,
                            ),
                            25.height,
                            nbAppTextFieldWidget(
                              kinEmailController,
                              'Email of next of kin',
                              TextFieldType.EMAIL,
                            ),
                            25.height,
                            IntlPhoneField(
                              controller: kinPhoneController,

                              decoration: InputDecoration(
                                labelText:"Phone Number of next of Kin" ,
                                contentPadding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 25, bottom: 25),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.1),
                                hintText: "Phone Number of next of Kin",
                                labelStyle: secondaryTextStyle(),
                                hintStyle: primaryTextStyle(size: 14,color: Colors.black.withOpacity(0.6)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.2),
                                      width: 2),
                                ),
                              ),
                              initialCountryCode: 'NG',
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
                            ),

                            SizedBox(
                              height: customHeight*0.3,
                            ),
                            position==2?  GestureDetector(
                              onTap: () {
                                initializeCompleteProfile();
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
                          initializeCompleteProfile();
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
                        } else {
                          initializeCompleteProfile();
                          //const MAMembershipScreen().launch(context);
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

  initializeCompleteProfile() async {


    final File document = File(_paths2![0].path!);

    if(coverImage!=null){
      const UPDATE_USER = "${BASE_URL}users/updatemyprofile";
      const UPDATE_USER2 = "${BASE_URL}users/updateuserid";
      List<File> myFileList=[];
      print("This is to complete profile");
      loader.Loader.show(context,
          progressIndicator: const CupertinoActivityIndicator());
      var apiCall = RestDataSource();
      var completeProfile = CompleteProfile();
      completeProfile.dob= _dateController.text;
      completeProfile.nationality = nationalityValue;
      completeProfile.maritalStatus = maritalStatusValue;
      completeProfile.governmentID = governmentIDName;
      completeProfile.childrenNum = childrenNumController.text;
      completeProfile.nextOfKinEmail = kinEmailController.text;
      completeProfile.nextOfKinPhone = kinPhoneController.text;
      completeProfile.nextOfKinName = kinNameController.text;
      myFileList.add(coverImage!);
      myFileList.add(document);
      apiCall.updateUser(completeProfile).then((value2){
        Fluttertoast.showToast(
          msg: "Profile Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        apiCall.completeProfileDocUpload(UPDATE_USER,UPDATE_USER2, myFileList).then((value) {
          loader.Loader.hide();
          const MAMembershipScreen().launch(context);
        }).catchError((err) {
          print("second shit didnt work");
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
        print("Its not working");
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
      Fluttertoast.showToast(
        msg: "Please select a cover Image",
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

