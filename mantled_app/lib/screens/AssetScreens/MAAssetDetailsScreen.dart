import 'dart:io';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mantled_app/model/AssetDocumentModel.dart';
import 'package:mantled_app/model/CollabModel.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:mantled_app/model/CollaboratorListModel.dart';
import 'package:mantled_app/model/NBModel.dart';
import 'package:mantled_app/model/assetDetailModel.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mantled_app/screens/AssetScreens/MARealEstateDetailsSheet.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAEditAssetsScreen.dart';
import 'package:mantled_app/utils/NBDataProviders.dart';
import 'package:mantled_app/utils/NBWidgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:image_preview/image_preview.dart';

import '../DashboardScreens/CreateCollabScreen.dart';
import '../DashboardScreens/MACreateCollaboratorScreen.dart';

class MAAssetDetailsScreen extends StatefulWidget {
  static String tag = '/MAAssetDetailsScreen';

  final AssetDetailModel assetData;
  final Color assetColor;
  final String assetType;
  final String assetID;
  const MAAssetDetailsScreen({Key? key, required this.assetData, required this.assetColor, required this.assetType, required this.assetID}) : super(key: key);

  @override
  MAAssetDetailsScreenState createState() => MAAssetDetailsScreenState();
}

class MAAssetDetailsScreenState extends State<MAAssetDetailsScreen> {
  late Future assetDocuments;
  late Future collaborators;

  @override
  void initState() {
    super.initState();

    Provider.of<Data>(context, listen: false).fetchAssetDocumentList(context, widget.assetID, widget.assetType);
    assetDocuments = getAssetDocumentList();

    Provider.of<Data>(context, listen: false).fetchAssetCollabList(context, widget.assetID, widget.assetType);
    collaborators = getAssetCollabList();

  }

  Future getAssetDocumentList() async {
    await Provider.of<Data>(context, listen: false).fetchAssetDocumentList(context, widget.assetID,  widget.assetType);
    var c = Provider.of<Data>(context, listen: false).assetDocuments;
    return c;
  }

  Future getAssetCollabList() async {
    await Provider.of<Data>(context, listen: false).fetchAssetCollabList(context, widget.assetID, widget.assetType);
    var c = Provider.of<Data>(context, listen: false).collaborators;
    return c;
  }


  double getHeight(double sysVar,double size){
    double calc=size/1000;
    return sysVar *calc;
  }

  int totalCollabs=0;

  double getTextSize(double sysVar,double size){
    double calc=size/10;
    return sysVar *calc;
  }

  Future<void> _shareImageFromUrl(networkUrl, index) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          networkUrl));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Asset Document ${index}', 'Asset Document ${index}', bytes, 'image/jpg');
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> sharePDF(networkUrl, index) async {
    try {
      var request = await HttpClient().getUrl(Uri.parse(
          networkUrl));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Asset Document ${index}', 'Asset Document ${index}', bytes, '*/*',);
    } catch (e) {
      print('error: $e');
    }
  }



  void _show(BuildContext ctx, String assetDoc, int index) {
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
                  print(assetDoc.toString());
                  if(assetDoc.toString().contains("pdf")){
                    Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) =>   PDFViewerFromUrl(
                            url: assetDoc.toString(),
                            pdfName:"Asset Document $index",
                          ),
                        ));

                  }
                  else if(assetDoc.toString().contains("jpg")||
                      assetDoc.toString().contains("png")){
                    openImagesPage(Navigator.of(context),
                      imgUrls: [assetDoc.toString(),assetDoc.toString()],
                    );
                  }

                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Text(
                        "VIEW DOCUMENT",
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
                 // initiateDeleteDocument(assetDoc.);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "DELETE DOCUMENT",
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
                  // initiateDeleteDocument(assetDoc.);
                  if(assetDoc.contains("jpg")){
                    _shareImageFromUrl(assetDoc.toString(), index);
                  }
                  else if(assetDoc.contains("pdf")){
                    sharePDF(assetDoc.toString(), index);
                  }
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "SHARE DOCUMENT",
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
  List<AssetTypes> assets = uploadedItems();
  int selectedIndex = 0;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;


    return Scaffold(

      body: DraggableHome(
        appBarColor: widget.assetType=="real_estate"?const Color(0xFF3A826D):
        widget.assetType=="tangible_assets"?const Color(0xFF700BE9):
        widget.assetType=="personal_assets"?const Color(0xFF005FA3):
        widget.assetType=="financial_assets"?const Color(0xFFA06A41):
        widget.assetType=="debts_and_liabilities"?const Color(0xFFDA2C7C):
        const Color(0xFF121936),

        headerExpandedHeight: customHeight*0.0058,
        alwaysShowLeadingAndAction:false,

        leading:  Image.asset("assets/png/arrow_back.png").onTap(() {
          finish(context);
        }),
        title:  GestureDetector(
          onTap: () {
            Fluttertoast.showToast(
              msg: "Feature not available at the moment",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
         //    MAEditAssetScreen(assetData: widget.assetData,assetID:widget.assetID, assetType:widget.assetType).launch(context);
          },
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 150,
            decoration:  BoxDecoration(
              borderRadius:  BorderRadius.circular(60.0),
              color:  widget.assetType=="real_estate"?const Color(0xFFDBF0DE):
              widget.assetType=="tangible_assets"?const Color(0xFFFBE8F1):
              widget.assetType=="personal_assets"?const Color(0xFFE5F4FF):
              widget.assetType=="financial_assets"?const Color(0xFFF6EEE3):
              widget.assetType=="debts_and_liabilities"?const Color(0xFFFBE8F1):
              const Color(0xFFE6E7EA),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],

            ),
            child:  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.edit_note, color: Colors.black, size: 28,),
                  10.width,
                  const Text('Edit Asset',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Colors.black,
                      letterSpacing: -0.3858822937011719,
                    ),),

                ],
              ),
            ),
          ),
        ),

        headerWidget: headerWidget(context),
        body: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 0),
            child: SizedBox(child: SizedBox(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(60),
                    ),

                    width: 40,
                    height: 5,
                  ),
                ),

                SizedBox(
                  height: customHeight * 0.2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Uploaded Documents", style: boldTextStyle(color: Colors.black, size: 18), ),
                    GestureDetector(
                      onTap: () {

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
                SizedBox(
                  height: customHeight * 0.2,
                ),
                listView(),
              ],
            ))),
          ),
        ],

        fullyStretchable: false,
        backgroundColor: Colors.white,

      ),
    );
  }


  Widget headerWidget(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    final textScale=MediaQuery.of(context).size.height * 0.01;
    return Container(
        color:  widget.assetType=="real_estate"?const Color(0xFF3A826D):
        widget.assetType=="tangible_assets"?const Color(0xFF700BE9):
        widget.assetType=="personal_assets"?const Color(0xFF005FA3):
        widget.assetType=="financial_assets"?const Color(0xFFA06A41):
        widget.assetType=="debts_and_liabilities"?const Color(0xFFDA2C7C):
         const Color(0xFF121936),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Image.asset("assets/png/arrow_back.png").onTap(() {
                  finish(context);
                }),

                GestureDetector(
                  onTap: () {
                     MAEditAssetScreen(assetData: widget.assetData, assetID: widget.assetID, assetType: widget.assetType,).launch(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,

                    decoration:  BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      borderRadius:  BorderRadius.circular(60.0),
                        color: widget.assetType=="real_estate"?const Color(0xFFDBF0DE):
                        widget.assetType=="tangible_assets"?const Color(0xFFFBE8F1):
                        widget.assetType=="personal_assets"?const Color(0xFFE5F4FF):
                        widget.assetType=="financial_assets"?const Color(0xFFF6EEE3):
                        widget.assetType=="debts_and_liabilities"?const Color(0xFFFBE8F1):
                        const Color(0xFFE6E7EA),
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.edit_note, color: Colors.black, size: 28,),
                          10.width,
                          const Text('Edit Asset',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: -0.3858822937011719,
                            ),),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.assetData.assetName!,
                  style: TextStyle( fontFamily: 'Poppins',color: Colors.white, fontSize: getTextSize(textScale,
                      40),fontWeight: FontWeight.bold),),

                Text("${widget.assetData.assetAddress1!} ", style: const TextStyle(color: Colors.white,),),
                SizedBox(
                  height: customHeight * 0.2,
                ),
                GestureDetector(
                  onTap: (){
                    bottomsheet.showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>   const MARealEstateDetailsSheet()
                    );
                    //     .then((value) =>
                    //     Provider.of<Data>(context, listen: false).fetchHousingProperties(context)
                    // );
                  },
                  child: Row(
                    children: [
                      Text("Check Assets Full Details ", style: primaryTextStyle(color: Colors.white),),
                      const Icon(Icons.arrow_forward, color: Colors.white, size: 15,)
                    ],
                  ),
                )
              ],
            ),

             Text("Collaborators linked to this asset",style: boldTextStyle(color: Colors.white), ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: collaborators,
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
                            List<CollabModel> collabList = snapshot.data;
                            totalCollabs= collabList.length;
                            return SizedBox(
                              height:totalCollabs==0 ?80:140,
                              child: ListView.separated(
                                  padding: EdgeInsets.zero,

                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: collabList.length<3? collabList.length: 3,
                                  shrinkWrap: true,
                                  scrollDirection:Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    CollabModel mData = collabList[index];

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          //     _showBeneDetails(context, mData);
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(50.0),
                                              child: Image.network(
                                                mData.collabPicture!,
                                                width: 70,
                                              ),
                                            ),
                                            5.height,
                                            Text(
                                              "${mData.collabName!.split(' ')[0]}\n${mData.collabName!.split(' ')[1]}",
                                              textAlign: TextAlign.center, style: const TextStyle(color: Colors.white),),
                                          ],
                                        ),
                                      ),
                                    );
                                  }, separatorBuilder:
                                  (BuildContext context, int index) {
                                return  Container(

                                );
                              }
                              ),
                            );
                          }
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                bottomsheet.showCupertinoModalBottomSheet(
                                    expand: false,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                     CreateCollabScreen(assetType: widget.assetType,));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.black,
                                      Colors.black,
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                                child: const Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25,
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
                    ],
                  ),
                  totalCollabs==0? SizedBox(
                    height: customHeight * 0.2,
                  ):
                  const SizedBox(
                  )
                ],
              ),
            ),


          ],
        ).paddingOnly(top: 20, bottom: 0, left: 20, right: 20));
  }

  Widget listView() {
    return FutureBuilder(
        future: assetDocuments,
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
      List<dynamic> assetList = snapshot.data;
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
        return ListView.separated(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: assetList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DateTime dt = DateTime.parse(widget.assetData.assetDateAdded!);
            print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: GestureDetector(
                onTap: (){

                  if(assetList[index].toString().contains("pdf")){
                    Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) =>   PDFViewerFromUrl(
                            url: assetList[index].toString(),
                            pdfName: "Asset Document $index",
                          ),
                        ));

                  }
                  else if(assetList[index].toString().contains("jpg")||
                      assetList[index].toString().contains("png")){
                    openImagesPage(Navigator.of(context),
                      imgUrls: [assetList[index]!,assetList[index]],
                    );
                  }

                },

                child: ListTile(
                    leading: CircleAvatar(
                      child:Image.asset("assets/png/document.png"),
                    ),
                    title:  Text("Asset Document ${index+1}", style: TextStyle(fontWeight: FontWeight.w600),),
                    subtitle:  Text(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt)),
                    trailing: GestureDetector(
                      onTap: (){
                        print("Iseoluwa");
                        _show(context, assetList[index], index);
                      },
                        child: const Icon(Icons.more_horiz_outlined, color: Colors.black,))

                ),
              ),
            );}, separatorBuilder: (BuildContext context, int index) {
          return const Divider(thickness: 2,);
        },
        );
      }
    );
  }


  initiateDeleteDocument(documentID){
    loader.Loader.show(
        context, progressIndicator: const CupertinoActivityIndicator());
    var apiCall = RestDataSource();
    List<String> deletedIDList=[];
    deletedIDList.add(documentID);
    apiCall.deleteDocuments(deletedIDList,  widget.assetID).then((value) {
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
          msg: "Document has been deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        loader.Loader.hide();
       setState(() {
         Provider.of<Data>(context, listen: false).fetchAssetDocumentList(context, widget.assetID,  widget.assetType);
         assetDocuments = getAssetDocumentList();
       });
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
  }


}
class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key? key, required this.url, required this.pdfName}) : super(key: key);

  final String url;
  final String pdfName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(pdfName, style: const TextStyle(fontSize: 16),),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached PDF From Url'),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}

