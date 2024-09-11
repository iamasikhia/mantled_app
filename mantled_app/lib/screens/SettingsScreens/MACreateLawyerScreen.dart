import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mantled_app/model/lawyer_model.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:mantled_app/providers.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:provider/provider.dart';

import '../../utils/MATextStyles.dart';
import '../../utils/NBColors.dart';



class MACreateLawyerScreen extends StatefulWidget {
  const MACreateLawyerScreen({Key? key}) : super(key: key);

  @override
  MACreateLawyerScreenState createState() => MACreateLawyerScreenState();
}

class MACreateLawyerScreenState extends State<MACreateLawyerScreen> {

  late Future lawyerDetails;


  TextEditingController userNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  var lawyerName="Ademade Dennis";
  var lawyerEmail="ademadedennis@gmail.com";
  var lawyerPhone= "8068097620";

  bool isBiometric = false;
  @override
  void initState() {
    super.initState();
    Provider.of<Data>(context, listen: false).fetchLawyerDetails(context);
    lawyerDetails = getData();
  }

  Future getData() async {
    await Provider.of<Data>(context, listen: false).fetchLawyerDetails(context);
    var c = Provider.of<Data>(context, listen: false).lawyerDetails;
    return c;
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

  void createShow(BuildContext ctx, String action) {
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
                'Lawyer has been $action Successfully ',
                style: primaryTextStyle(color: black,size: 19),

                textAlign: TextAlign.center,
              ),
              50.height,

              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      Provider.of<Data>(context, listen: false).fetchLawyerDetails(context);
                    });
                    finish(context);
                    finish(context);
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
  void editShow(BuildContext ctx, String action) {
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
                'Lawyer has been $action Successfully ',
                style: primaryTextStyle(color: black,size: 19),

                textAlign: TextAlign.center,
              ),
              50.height,

              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      Provider.of<Data>(context, listen: false).fetchLawyerDetails(context);
                    });
                    finish(context);
                    finish(context);

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

  void deleteShow(BuildContext ctx, String action) {
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
                'Lawyer has been $action Successfully ',
                style: primaryTextStyle(color: black,size: 19),

                textAlign: TextAlign.center,
              ),
              50.height,

              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      Provider.of<Data>(context, listen: false).fetchLawyerDetails(context);
                    });
                    finish(context);
                    finish(context);
                    finish(context);
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
              30.height,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Delete Lawyer',
                    style: boldTextStyle(size: 16),
                    textAlign: TextAlign.start,
                  ),
                  10.height,
                  Text(
                    'Delete a registered lawyer from your \n'
                        'account, kindly note that once this action \n'
                        'is done it can’t be reversed',
                    style: primaryTextStyle(color: black,size: 15),

                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              50.height,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: GestureDetector(
                      onTap: () {
                       finish(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: context.width()/3,
                        height: 60,
                        decoration:  BoxDecoration(
                          border: Border.all(width: 2, color: const Color(0xFFA7A7A7)),
                          borderRadius:  BorderRadius.circular(20.0),
                          color: Colors.transparent,
                        ),
                        child: const Text('Cancel',
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
                          initializeDeleteLawyer();

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: context.width()/3,
                        height: 60,
                        decoration:  BoxDecoration(
                          borderRadius:  BorderRadius.circular(20.0),
                          color: const Color(0xFFDA2C7C),
                        ),
                        child: const Text('Proceed',
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
    double customHeight= MediaQuery.of(context).size.height*0.1;
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading:  Image.asset("assets/png/material-arrow-back.png").onTap(() {
          finish(context);
        }),
        title: Text(
          "My Lawyer",
          style: primaryTextStyle(size: 16),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              10.width,
              GestureDetector(
                onTap: (){
                  _show(context);
                },
                child: Container(
                  decoration:  BoxDecoration(
                      borderRadius:  BorderRadius.circular(30.0),
                      color:  const Color(0xFFDA2C7C)
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),


          10.width,
        ],
        backgroundColor: white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: lawyerDetails,
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

                LawyerModel lawyerDetail = snapshot.data;
                 if (lawyerDetail.lawyerName!.isEmpty) {
                  return  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          16.height,

                          Text('Add Lawyer,',

                            style:  CustomTextStyle.semiBoldCustomTextStyle(context, 25, Colors.black ),),

                          Text('Enter your lawyer details',
                              style: CustomTextStyle.secondaryCustomStyle(context,15)),




                          SizedBox(
                            height: customHeight*0.6,
                          ),
                          AppTextField(
                              enabled: true,
                              controller: fullNameController,
                              textFieldType: TextFieldType.OTHER,
                              textStyle: primaryTextStyle(size: 14),

                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                                filled: true,
                                isDense: true,
                                labelText: "Full Name",
                                fillColor: Colors.white.withOpacity(0.1),
                                hintText: "Enter Full name",

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
                              controller: emailController,
                              textFieldType: TextFieldType.OTHER,
                              textStyle: primaryTextStyle(size: 14),


                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                                filled: true,
                                isDense: true,
                                fillColor: Colors.white.withOpacity(0.1),
                                hintText: "Enter Email-Address",

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
                            controller: phoneNumberController,
                            flagsButtonMargin:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                            decoration: InputDecoration(
                              contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                              filled: true,
                              isDense: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              hintText: "Enter Phone Number",

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
                            onTap: () async {
                             await initializeCreateLawyer();
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
                              child: const Text('Add Lawyer',
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
                }

                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        16.height,
                        Container(
                          decoration:  BoxDecoration(
                              borderRadius:  BorderRadius.circular(30.0),
                              color:  const Color(0xFF131934)
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(getInitials(lawyerDetail.lawyerName!),
                              style: boldTextStyle(  color:  Colors.white),),
                          ),
                        ),
                        SizedBox(
                          height: customHeight*0.2,
                        ),

                        SizedBox(
                          height: customHeight*0.6,
                        ),
                        AppTextField(
                            enabled: true,
                            controller: userNameCont,
                            textFieldType: TextFieldType.OTHER,
                            textStyle: primaryTextStyle(size: 14),

                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                              filled: true,
                              isDense: true,
                              labelText: "Edit Full Name",
                              fillColor: Colors.white.withOpacity(0.1),
                              hintText: lawyerDetail.lawyerName!,

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
                              hintText:  lawyerDetail.lawyerEmail!,
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
                          enabled: false,
                          flagsButtonMargin:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                          decoration: InputDecoration(
                            contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            hintText:  lawyerDetail.lawyerPhone!,

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
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                           String? lawyerID= prefs.getString('lawyerID');
                            initializeEditLawyer(lawyerID!);
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
                            child: const Text('Update',
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
              }),

        ),
      ),
    );
  }

  Widget emptyScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.height,
        Container(
          child: Text('NO LAWYER ADDED', style: boldTextStyle(color: grey))
              .paddingLeft(15),
        ),
        20.height,
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Image.asset(
                      "assets/box.png",
                      fit: BoxFit.contain,
                      width: 180,
                    )),
              ),
              20.height,
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: AppButton(
                  onTap: () {
                    // bottomsheet.showCupertinoModalBottomSheet(
                    //     expand: false,
                    //     context: context,
                    //     backgroundColor: Colors.transparent,
                    //     builder: (context) =>
                    //     const HLInviteLawyerScreen());
                  },
                  color: NBPrimaryColor,
                  elevation: 0,
                  shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(width: 1, color: NBPrimaryColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ADD A LAWYER",
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
              18.height,
            ],
          ),
        )
      ],
    );
  }

   initializeCreateLawyer() {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    var lawyerDetails = LawyerModel();
    lawyerDetails.lawyerName = fullNameController.text;
    lawyerDetails.lawyerEmail = emailController.text;
    lawyerDetails.lawyerPhone = phoneNumberController.text;
    apiCall.createLawyer(lawyerDetails).then((value) {
      loader.Loader.hide();
      createShow(context, "Created");

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


  initializeDeleteLawyer() async {

    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    final prefs = await SharedPreferences.getInstance();
    String? lawyerID= prefs.getString('lawyerID');
    apiCall.deleteLawyerDetails( lawyerID!).then((value) {
      loader.Loader.hide();
      deleteShow(context, "Deleted");

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

  initializeEditLawyer(String lawyerID) {
    loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    var lawyerDetails = LawyerModel();
    lawyerDetails.lawyerEmail = emailCont.text;
    apiCall.editLawyerDetails(lawyerDetails, lawyerID).then((value) {
      Fluttertoast.showToast(
        msg: "Profile Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      loader.Loader.hide();
      editShow(context, "Edited");

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
