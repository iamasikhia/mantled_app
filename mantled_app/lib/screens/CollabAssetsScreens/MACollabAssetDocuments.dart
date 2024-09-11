

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_preview/image_preview.dart';
import 'package:intl/intl.dart';
import 'package:mantled_app/model/AssetDocumentModel.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/AssetScreens/MAAssetHomeScreen.dart';
import 'package:mantled_app/screens/CollabAssetsScreens/MACollabAssetHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MACreateCollaboratorScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAInitializeAssetScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class MACollabAssetDocuments extends StatefulWidget {
  static String tag = '/MACollabAssetDocuments';

  final String assetID;
  final String assetName;
  final String assetDateAdded;

  const MACollabAssetDocuments({
    Key? key, required this.assetID, required this.assetDateAdded, required this.assetName,
  }) : super(key: key);

  @override
  MACollabAssetDocumentsState createState() => MACollabAssetDocumentsState();
}

class MACollabAssetDocumentsState extends State<MACollabAssetDocuments>
    with SingleTickerProviderStateMixin {
  String? otpPin;




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
  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }



  var beneficiaryNames=["Gideon Runsewe", "Pelumi Jegede", "Dele Martins", "Asikhia Iseoluwa" ];
  var colors=[0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D,
    0xFF700BE9,0xFFA06A41,0xFF0496FF, 0xFFFD6031, 0xFF00BF3D, 0xFF700BE9,0xFFA06A41];


  TabController? tabController;

  late Future assetDocuments;
  late Future collaborators;

  @override
  void initState() {
    super.initState();

    Provider.of<Data>(context, listen: false).fetchAssetDocumentList(context, widget.assetID, widget.assetName);
    assetDocuments = getAssetDocumentList();

  }

  Future getAssetDocumentList() async {
    await Provider.of<Data>(context, listen: false).fetchAssetDocumentList(context, widget.assetID, widget.assetName);
    var c = Provider.of<Data>(context, listen: false).assetDocuments;
    return c;
  }




  @override
  Widget build(BuildContext context) {
    double customHeight = MediaQuery.of(context).size.height * 0.1;
    DateTime dt = DateTime.parse(widget.assetDateAdded);
    print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
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

                    Text(widget.assetName,
                      style: primaryTextStyle(color:Colors.black, size: 23,weight: FontWeight.w500 ),),
                    10.height,
                    Text('Last updated ${DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt)}',
                      style: secondaryTextStyle( size: 13,weight: FontWeight.w500 ),),


                    SizedBox(
                      height:  customHeight*0.2,
                    ),
                    Row(
                      children: [
                        Text('UPLOADED DOCUMENTS',
                          style: primaryTextStyle(size: 15,weight: FontWeight.w500 ),),
                        // Text('-5 DOCS',
                        //   style: secondaryTextStyle(size: 15,weight: FontWeight.w500 ),),
                      ],
                    ),

                  ],
                ),
              ),

              SizedBox(
                width: context.width()*0.8,
                height: context.height()*0.9,
                child:   FutureBuilder(
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
                    List<AssetDocumentModel> assetList = snapshot.data;
                    if(assetList.isEmpty){
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "No Documents Here",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.only(top: 0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: assetList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime dt = DateTime.parse(assetList[index].assetDateAdded!);
                        print(DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt));
                         return GestureDetector(
                                    onTap: () {},
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: GestureDetector(
                                        onTap: () {
                                          print(assetList[index].assetUrl!);
                                          if (assetList[index]
                                              .assetUrl!
                                              .contains("pdf")) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute<dynamic>(
                                                  builder: (_) =>
                                                      PDFViewerFromUrl(
                                                    url: assetList[index]
                                                        .assetUrl!,
                                                    pdfName: assetList[index]
                                                        .assetName!,
                                                  ),
                                                ));
                                          } else if (assetList[index]
                                                  .assetUrl!
                                                  .contains("jpg") ||
                                              assetList[index]
                                                  .assetUrl!
                                                  .contains("png")) {
                                            openImagesPage(
                                              Navigator.of(context),
                                              imgUrls: [
                                                assetList[index].assetUrl!,
                                                assetList[index].assetUrl!
                                              ],
                                            );
                                          }
                                        },
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            child: Image.asset(
                                                "assets/png/document.png"),
                                          ),
                                          title:
                                              Text(assetList[index].assetName!),
                                          subtitle: Text(
                                              DateFormat("EEE, d MMM yyyy HH:mm:ss").format(dt)),
                                        ),
                                      ),
                                    ),


                         );},  separatorBuilder:
                        (BuildContext context, int index) {
                      return const Divider(
                        thickness: 2,
                      );
                    },);
                  }
              )
              ),

            ],
          ),
        ),
      ),
    );
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
        title:  Text(pdfName, style: TextStyle(fontSize: 16),),
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


