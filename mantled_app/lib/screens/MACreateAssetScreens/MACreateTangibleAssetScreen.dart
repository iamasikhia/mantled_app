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
import 'package:multiple_image_camera/camera_file.dart';
import 'package:multiple_image_camera/multiple_image_camera.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/utils/NBImages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:country_list_pick/country_list_pick.dart';
import 'package:nigerian_states_and_lga/nigerian_states_and_lga.dart';
import '../BeneficiaryScreens/MABeneficiaryScreen.dart';


class MACreateTangibleAssetScreen extends StatefulWidget {
  static String tag = '/MACreateTangibleAssetScreen';

  final String assetType;
  const MACreateTangibleAssetScreen({Key? key, required this.assetType}) : super(key: key);

  @override
  MACreateTangibleAssetScreenState createState() => MACreateTangibleAssetScreenState();
}

class MACreateTangibleAssetScreenState extends State<MACreateTangibleAssetScreen> {
  List<String> mPages = <String>[
    brainstorming1,
    financialdata1,
    onlinetransactions1
  ];

  final picker = ImagePicker();

  int selectedIndex=0;

  List<MediaModel> selectedImages = [];

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
                    MABeneficiaryScreen(assetID: assetID, assetType: "IntangibleAssets",).launch(context);
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

  var allSteps= ["Naming","Uploads"];

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





  TextEditingController propertyNameController = TextEditingController();
  TextEditingController assetTypeController = TextEditingController();
  TextEditingController addressControllerTwo = TextEditingController();


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

    double customWidth= MediaQuery.of(context).size.width;
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
                      Text("Tangible", style: primaryTextStyle(weight: FontWeight.w500),),
                      const SizedBox(width: 10,),
                      Image.asset("assets/png/tangible_new.png"),
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
                  Text('${position + 1} OF 2 ',
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
                      SingleChildScrollView(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [

                              8.height,
                              nbAppTextFieldWidget(
                                propertyNameController,
                                'Property Name',
                                TextFieldType.NAME,
                              ),
                              25.height,
                              nbAppTextFieldWidget(
                                assetTypeController,
                                'Type of Asset',
                                TextFieldType.NAME,
                              ),
                            ],
                          ),
                        ),
                      ),



                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height:  customHeight*0.1,
                              ),

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
                                    setState(() {
                                      selectedImages.clear();
                                    });

                                    MultipleImageCamera.capture(context: context).then((value) {
                                      setState(() {
                                        selectedImages = value;
                                      });
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Take Pictures of your assets",
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
                                                  :Icons.camera,
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
                                height:  customHeight*0.3,
                              ),
                              // selectedImages.isNotEmpty? ClipRRect(
                              //     borderRadius: BorderRadius.circular(40.0),
                              //     child: SizedBox.fromSize(
                              //       child: Image.file(File(selectedImages[selectedIndex].file.path),
                              //         width:customWidth*0.8,height: customHeight*3.5,fit: BoxFit.cover,),
                              //     )):Container(),

                              selectedImages.isNotEmpty?      Container(
                                height: context.height()*0.15,
                                child:Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: 300.0,
                                        child: selectedImages.isEmpty
                                            ? const Center(child: Text(''))
                                            : GridView.builder(
                                          itemCount: selectedImages.length,
                                          gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              crossAxisCount: 3),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Center(
                                                child:
                                                GestureDetector(
                                                  onTap: (){
                                                    print("------------------");
                                                    print(index);
                                                    print(selectedIndex);
                                                    setState(() {
                                                      selectedIndex= index;
                                                    });
                                                    print(selectedIndex);
                                                    print(index);
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey.withOpacity(0.1),
                                                            spreadRadius: 5,
                                                            blurRadius: 8,
                                                            offset: const Offset(0, 1), // changes position of shadow
                                                          ),
                                                        ],
                                                        border: Border.all(width: 1, color: NBPrimaryColor.withOpacity(0.2), ),
                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                      ),
                                                      child: ClipRRect(

                                                          borderRadius: BorderRadius.circular(8.0),
                                                          child: Image.file(File(selectedImages[index].file.path),width: 100, height: 100,fit: BoxFit.cover,))),
                                                ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ):Container(),


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
                                                  :Icons.file_upload_outlined,
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
                              position==1?  GestureDetector(
                                onTap: () {
                                  initializeCreateAsset();

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
                  position >=0 && position<1?GestureDetector(
                    onTap: () {
                      print(position);
                      setState(() {
                        if (position < 1) {
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

  // Future initiateUploadOrderItems() async {
  //   loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
  //   setState(() {
  //
  //   });
  //   var apiCall = RestDataSource();
  //   final prefs = await SharedPreferences.getInstance();
  //   List<File> myFileList=[];
  //   for (var i = 0; i < selectedImages.length; i++) {
  //     final File document = File(selectedImages[i].file.path);
  //     myFileList.add(document);
  //     print(document);
  //   }
  //
  //   if (selectedImages.isNotEmpty){
  //     apiCall.uploadAssetDocuments(myFileList!, )
  //         .then((value) {
  //       print("This is the value returned");
  //       print(value);
  //       if(value.toString().contains("Error")){
  //         Fluttertoast.showToast(
  //           msg: "There was an error",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0,
  //         );
  //         loader.Loader.hide();
  //       }
  //       else{
  //         Fluttertoast.showToast(
  //           msg: "Success",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0,
  //         );
  //         loader.Loader.hide();
  //        // LBEnterPinScreen(orderDetails:widget.orderDetails!).launch(context);
  //
  //       }
  //
  //     }).catchError((err) {
  //       loader.Loader.hide();
  //
  //       Fluttertoast.showToast(
  //         msg: err,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //       print('Request not Sent');
  //     });
  //   }
  //   else{
  //     loader.Loader.hide();
  //     Fluttertoast.showToast(
  //       msg: "Please add Documents",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  // }

  initializeCreateAsset() async {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    final prefs = await SharedPreferences.getInstance();

    var assetData = AssetModel();
    assetData.propTitle = propertyNameController.text;
    assetData.assetType = assetTypeController.text;
    if (_paths2!=null){
      await apiCall.createTangibleAsset(assetData)
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

        apiCall.uploadAssetDocuments(_paths2!, assetID, widget.assetType)
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

          List<File> myFileList=[];
          for (var i = 0; i < selectedImages.length; i++) {
            final File document = File(selectedImages[i].file.path);
            myFileList.add(document);
            print(document);
          }
          if (selectedImages.isNotEmpty){
            apiCall.uploadAssetPictures(myFileList,assetID, widget.assetType)
                .then((value) {
              print("This is the value returned");
              print(value);
              if(value.toString().contains("Error")){
                Fluttertoast.showToast(
                  msg: "There was an error",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
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
                gravity: ToastGravity.BOTTOM,
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
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
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

  // Future initiateUploadOrderItems() async {
  //   loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
  //   setState(() {
  //
  //   });
  //   var apiCall = RestDataSource();
  //   final prefs = await SharedPreferences.getInstance();
  //   List<File> myFileList=[];
  //   for (var i = 0; i < selectedImages.length; i++) {
  //     final File document = File(selectedImages[i].file.path);
  //     myFileList.add(document);
  //     print(document);
  //   }
  //
  //   if (selectedImages.isNotEmpty){
  //     apiCall.uploadAssetDocuments(myFileList, widget.orderDetails!.backendOrderID!)
  //         .then((value) {
  //       print("This is the value returned");
  //       print(value);
  //       if(value.toString().contains("Error")){
  //         Fluttertoast.showToast(
  //           msg: "There was an error",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0,
  //         );
  //         loader.Loader.hide();
  //       }
  //       else{
  //         Fluttertoast.showToast(
  //           msg: "Success",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0,
  //         );
  //         loader.Loader.hide();
  //         LBEnterPinScreen(orderDetails:widget.orderDetails!).launch(context);
  //
  //       }
  //
  //     }).catchError((err) {
  //       loader.Loader.hide();
  //
  //       Fluttertoast.showToast(
  //         msg: err,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //       print('Request not Sent');
  //     });
  //   }
  //   else{
  //     loader.Loader.hide();
  //     Fluttertoast.showToast(
  //       msg: "Please add Documents",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  // }

}
