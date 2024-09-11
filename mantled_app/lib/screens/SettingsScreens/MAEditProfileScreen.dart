import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/constants/constants.dart';
import 'package:mantled_app/model/profileDetails.dart';
import 'package:mantled_app/networking/rest_data.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/utils/NBColors.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/utils/NBImages.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:provider/provider.dart';

class MAEditProfileScreen extends StatefulWidget {
  static String tag = '/MAEditProfileScreen';

  const MAEditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  MAEditProfileScreenState createState() => MAEditProfileScreenState();
}

class MAEditProfileScreenState extends State<MAEditProfileScreen> {
  TextEditingController userNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  late File imageFile;
  bool loadFromFile = false;

  late Future profileDetails;
  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).fetchProfileDetails(context);
    profileDetails = getData();
  }

  Future getData() async {
    await Provider.of<Data>(context, listen: false)
        .fetchProfileDetails(context);
    var c = Provider.of<Data>(context, listen: false).profileDetails;
    return c;
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
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/succ1.png',
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                  30.height,
                  Text(
                    'Email Updated',
                    style: boldTextStyle(color: black, size: 23),
                    textAlign: TextAlign.center,
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      'For athletes, high altitude produces two contradictory.',
                      style: boldTextStyle(
                        color: const Color(
                          0xFF979DAC,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  16.height,
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: AppButton(
                      onTap: () {
                        //  const HLDashboardScreen().launch(context);
                      },
                      color: NBPrimaryColor,
                      elevation: 0,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              width: 1, color: NBPrimaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("GO TO DASHBOARD",
                                style: boldTextStyle(size: 15, color: white)),
                            8.width,
                            const Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: white,
                              size: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  16.height,
                ],
              ),
            ));
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker().getImage(source: source);
    setState(() {
      if (image != null) {
        imageFile = File(image.path);
        loadFromFile = true;
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double customHeight= MediaQuery.of(context).size.height*0.1;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading:  Image.asset("assets/png/material-arrow-back.png").onTap(() {
            finish(context);
          }),
          title: Text(
            "Profile Management",
            style: primaryTextStyle(size: 16),
          ),
          backgroundColor: white,
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: profileDetails,
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
              ProfileDetails myProfile = snapshot.data;
              print(myProfile.profilePic);
              print("This is profile");
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      16.height,
                      Align(
                        alignment: Alignment.center,
                        child: myProfile.profilePic != null
                            ?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              myProfile.profilePic.toString(),
                              width: 100,
                            ),
                          )
                              : ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "assets/jpg/727399.png",
                      width: 100,
                    ),
                  ),
                      ),
                      SizedBox(
                        height: customHeight*0.2,
                      ),
                      GestureDetector(
                        onTap: (){
                          getImage(ImageSource.gallery);
                        },
                          child: Text("Tap to edit", style: primaryTextStyle(),)),
                      SizedBox(
                        height: customHeight*0.6,
                      ),
                      AppTextField(
                          enabled: true,
                          controller: userNameCont,
                          textFieldType: TextFieldType.OTHER,
                          textStyle: primaryTextStyle(size: 14),
                          focus: userNameFocus,
                          nextFocus: emailFocus,

                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                            filled: true,
                            isDense: true,
                            labelText: "Full Name",
                            fillColor: Colors.white.withOpacity(0.1),
                            hintText: myProfile.fullName,

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
                      20.height,
                      AppTextField(
                          enabled: false,
                          controller: emailCont,
                          textFieldType: TextFieldType.OTHER,
                          textStyle: primaryTextStyle(size: 14),


                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            hintText: myProfile.email,

                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2) , width: 2),//border Color
                            ),
                            hintStyle: secondaryTextStyle(),
                            enabledBorder:  OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(30.0),
                              borderSide:  BorderSide(color: Colors.grey.withOpacity(0.2) ,width:2),

                            ),
                            disabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.2), width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:  BorderRadius.circular(30.0),
                              borderSide:  const BorderSide(color:  NBPrimaryColor ,width: 2 ),

                            ),
                          )

                      ),
                      20.height,
                      IntlPhoneField(
                        controller: phoneController,
                        focusNode: phoneFocus,
                        enabled: false,
                          flagsButtonMargin:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                        decoration: InputDecoration(
                          contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          hintText: myProfile.phoneNumber,

                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2) , width: 2),//border Color
                          ),
                          hintStyle: secondaryTextStyle(),
                          enabledBorder:  OutlineInputBorder(
                            borderRadius:  BorderRadius.circular(30.0),
                            borderSide:  BorderSide(color: Colors.grey.withOpacity(0.2) ,width:2),

                          ),
                          disabledBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.2), width: 2),
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
                          _show(context);
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
                          child: const Text('Update Account',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xffffffff),
                              letterSpacing: -0.3858822937011719,
                            ),),
                        ),
                      )
                    ],
                  ).paddingAll(16),
                ),
              );
            }));
  }

  initializeAddAsset() {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    String email;
    email=emailCont.text;
    apiCall.updateEmail(email).then((value) {
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
