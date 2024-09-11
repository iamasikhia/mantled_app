import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:mantled_app/model/allpropetiesModel.dart';

import 'package:nb_utils/nb_utils.dart';

import 'package:flutter_overlay_loader/flutter_overlay_loader.dart' as loader;


class MAOthersAssetDetailsSheet extends StatefulWidget {
  final HousePropertyList? mData;
  const MAOthersAssetDetailsSheet( {Key? key,  this.mData}) : super(key: key);

  @override
  MAOthersAssetDetailsSheetState createState() => MAOthersAssetDetailsSheetState();
}

class MAOthersAssetDetailsSheetState extends State<MAOthersAssetDetailsSheet>
    with SingleTickerProviderStateMixin {
  TextEditingController entityOwnedController = TextEditingController();
  TextEditingController valueAmountController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    return NestedScrollView(
        key: _scaffoldKey,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: context.height() * 0.12,
              bottom: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(text: 'ITEM DETAILS'),
                  Tab(text: 'BENEFICIARY INFO'),
                ],
                labelStyle: boldTextStyle(color: const Color(0xff084887)),
                labelColor: black,
                unselectedLabelStyle: primaryTextStyle(),
                unselectedLabelColor: grey,
                isScrollable: true,
                indicatorColor: const Color(0xff084887),
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              floating: true,
              forceElevated: innerBoxIsScrolled,
              pinned: true,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              actionsIconTheme: const IconThemeData(opacity: 0.0),
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Center(
                        child: Text(
                          "Property Details",
                          style: boldTextStyle(size: 19),
                        )),
                    GestureDetector(
                        onTap: () {
                          finish(context);
                        },
                        child: const Icon(Icons.highlight_remove_sharp,
                            size: 29, color: Color(0xff7F7F84)))
                  ],
                ),
              ),

            ),

          ];
        },

        body: TabBarView(
          controller: tabController,
          children: [
            Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Document Name',
                                style: secondaryTextStyle(size: 16)),
                          ),
                          Expanded(
                            child: Text("My new Document",
                              style: boldTextStyle(size: 19) ,textAlign: TextAlign.right,),
                          ),
                        ],
                      ),

                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Document Type',
                              style: secondaryTextStyle(size: 16)),
                          Text("C of O Document",
                              style: boldTextStyle(size: 19)),
                        ],
                      ),
                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Property Address',
                                style: secondaryTextStyle(size: 16)),
                          ),
                          Expanded(
                            child: Text("20a Beckley Avenue, Millenium Estate",
                              style: boldTextStyle(size: 20, ), textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date Added',
                              style: secondaryTextStyle(size: 16)),
                          // Text(DateFormat.yMd().add_jm().format(DateTime.parse(widget.mData!.createdDate!)),
                          //     style: boldTextStyle(size: 19)),
                          Text("20th Oct, 2023",
                              style: boldTextStyle(size: 19)),
                        ],
                      ),
                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,
                    ],
                  ),
                ),
              ),
            ),
            Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name',
                              style: secondaryTextStyle(size: 16)),
                          Text("Asikhia Priscilla",
                              style: boldTextStyle(size: 19)),
                        ],
                      ),

                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,
                      /* Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Relationship',
                              style: secondaryTextStyle(size: 16)),
                          Text("Relative",
                              style: boldTextStyle(size: 19)),
                        ],
                      ),
                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone Number',
                              style: secondaryTextStyle(size: 16)),
                          Text("08068097620",
                              style: boldTextStyle(size: 19)),
                        ],
                      ),
                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Email',
                                style: secondaryTextStyle(size: 16)),
                          ),
                          Expanded(
                            child: Text("priscillaasikhia@gmail.com",
                              style: boldTextStyle(size: 19) ,textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text('Address',
                                style: secondaryTextStyle(size: 16)),
                          ),
                          Expanded(
                            child: Text("567 Adekunle Adebola Afun, Omole",
                              style: boldTextStyle(size: 20, ), textAlign: TextAlign.right,),
                          ),
                        ],
                      ),

                      15.height,
                      const Divider(height: 3,thickness: 2,),
                      15.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date Added',
                              style: secondaryTextStyle(size: 16)),
                          // Text(DateFormat.yMd().add_jm().format(DateTime.parse(widget.mData!.createdDate!)),
                          //     style: boldTextStyle(size: 19)),
                          Text("20th Oct, 2023",
                              style: boldTextStyle(size: 19)),
                        ],
                      ),
                      15.height,
                      const Divider(height: 3,thickness: 2,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
  // initializeDeleteAsset() {
  //   loader.Loader.show(context,progressIndicator:const CupertinoActivityIndicator());
  //   var apiCall = RestDataSource();
  //   apiCall.deleteAssets(widget.mData!.id!, "house").then((value) {
  //     loader.Loader.hide();
  //     Fluttertoast.showToast(
  //       msg: "Successfully Deleted",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //     finish(context);
  //   }).catchError((err) {
  //     loader.Loader.hide();
  //     Fluttertoast.showToast(
  //       msg: err,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //     print('Request not Sent');
  //   });
  // }
}
