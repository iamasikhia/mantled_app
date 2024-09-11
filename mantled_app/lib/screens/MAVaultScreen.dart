// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
// // import 'package:mantled_app/component/HLFinancialComponent.dart';
// // import 'package:mantled_app/component/HLHousingPropComponent.dart';
// // import 'package:mantled_app/component/HLIntangibleAssetsComponent.dart';
// // import 'package:mantled_app/component/HLPersonalAssetsComponent.dart';
// import 'package:mantled_app/model/allpropetiesModel.dart';
// import 'package:mantled_app/networking/rest_data.dart';
// // import 'package:mantled_app/screen/HLAddDebtScreen.dart';
// // import 'package:mantled_app/screen/HLAddFinancialAssetsScreen.dart';
// // import 'package:mantled_app/screen/HLAddHousingPropertyScreen.dart';
// // import 'package:mantled_app/screen/HLAddIntangibleAssetsScreen.dart';
// // import 'package:mantled_app/screen/HLAddPersonalEffectsScreen.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
// import 'package:nb_utils/nb_utils.dart';
// // import 'package:mantled_app/component/NBAllNewsComponent.dart';
// // import 'package:mantled_app/component/NBNewsComponent.dart';
// import 'package:mantled_app/model/NBModel.dart';
// import 'package:pie_chart/pie_chart.dart';
// // import 'package:mantled_app/screen/MAProfileScreen.dart';
// import 'package:mantled_app/utils/NBColors.dart';
// import 'package:mantled_app/utils/NBDataProviders.dart';
// import 'package:mantled_app/utils/NBImages.dart';
// import 'package:badges/badges.dart';
//
// class HLSafeguardScreen extends StatefulWidget {
//   static String tag = '/HLSafeguardScreen';
//
//   const HLSafeguardScreen({Key? key}) : super(key: key);
//
//   @override
//   HLSafeguardScreenState createState() => HLSafeguardScreenState();
// }
//
// class HLSafeguardScreenState extends State<HLSafeguardScreen>
//     with SingleTickerProviderStateMixin {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//   List<NBNewsDetailsModel> mNewsList = nbGetNewsDetails();
//   List<NBNewsDetailsModel> mTechNewsList = [],
//       mFashionNewsList = [],
//       mSportsNewsList = [],
//       mScienceNewsList = [];
//
//   TabController? tabController;
//   List<HousePropertyList> financialPropertyList = [];
//   List<HousePropertyList> housePropertyList = [];
//   List<HousePropertyList> intangiblePropertyList = [];
//   List<HousePropertyList> personalPropertyList = [];
//   @override
//   void initState() {
//     super.initState();
//     init();
//   }
//
//   void _show(BuildContext ctx) {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           side: const BorderSide(color: Colors.white70, width: 1),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         isScrollControlled: true,
//         elevation: 5,
//         context: ctx,
//         builder: (ctx) => Padding(
//           padding: EdgeInsets.only(
//               top: 15,
//               left: 15,
//               right: 15,
//               bottom: MediaQuery.of(ctx).viewInsets.bottom + 15),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(),
//                   Center(
//                       child: Text(
//                         "Save Your Assets",
//                         style: boldTextStyle(size: 20),
//                       )),
//                   GestureDetector(
//                       onTap: () {
//                         finish(context);
//                       },
//                       child: const Icon(
//                         Icons.highlight_remove_sharp,
//                         size: 29,
//                         color: Colors.grey,
//                       ))
//                 ],
//               ),
//               25.height,
//               Center(
//                   child: Image.asset(
//                     "assets/organize.png",
//                     fit: BoxFit.cover,
//                   )),
//               10.height,
//               GestureDetector(
//                 onTap: () {
//                   // bottomsheet.showCupertinoModalBottomSheet(
//                   //     expand: false,
//                   //     context: context,
//                   //     backgroundColor: Colors.transparent,
//                   //     builder: (context) =>
//                   //     const HLAddFinancialAssetsScreen());
//
//                 },
//                 child: ListTile(
//                   title: Text(
//                     "Financial Assets",
//                     style: boldTextStyle(),
//                   ),
//                   subtitle: const Text("Brief explanation of the above"),
//                   leading: Image.asset(
//                     "assets/moneys.png",
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios_sharp),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // bottomsheet.showCupertinoModalBottomSheet(
//                   //     expand: false,
//                   //     context: context,
//                   //     backgroundColor: Colors.transparent,
//                   //     builder: (context) =>
//                   //     const HLAddPersonalEffectsScreen());
//                 },
//                 child: ListTile(
//                   title: Text(
//                     "Personal Effects",
//                     style: boldTextStyle(),
//                   ),
//                   subtitle: const Text("Brief explanation of the above"),
//                   leading: Image.asset(
//                     "assets/glass.png",
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios_sharp),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // bottomsheet.showCupertinoModalBottomSheet(
//                   //     expand: false,
//                   //     context: context,
//                   //     backgroundColor: Colors.transparent,
//                   //     builder: (context) =>
//                   //     const HLAddHousingPropertyScreen());
//                 },
//                 child: ListTile(
//                   title: Text(
//                     "House Property",
//                     style: boldTextStyle(),
//                   ),
//                   subtitle: const Text("Brief explanation of the above"),
//                   leading: Image.asset(
//                     "assets/building-3.png",
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios_sharp),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // bottomsheet.showCupertinoModalBottomSheet(
//                   //     expand: false,
//                   //     context: context,
//                   //     backgroundColor: Colors.transparent,
//                   //     builder: (context) =>
//                   //     const HLAddIntangibleAssetsScreen());
//                 },
//                 child: ListTile(
//                   title: Text(
//                     "Personal Memoirs",
//                     style: boldTextStyle(),
//                   ),
//                   subtitle: const Text("Brief explanation of the above"),
//                   leading: Image.asset(
//                     "assets/receipt-2.png",
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios_sharp),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // bottomsheet.showCupertinoModalBottomSheet(
//                   //     expand: false,
//                   //     context: context,
//                   //     backgroundColor: Colors.transparent,
//                   //     builder: (context) => const HLAddDebtScreen());
//                 },
//                 child: ListTile(
//                   title: Text(
//                     "Debts & Liabilities",
//                     style: boldTextStyle(),
//                   ),
//                   subtitle: const Text("Brief explanation of the above"),
//                   leading: Image.asset(
//                     "assets/money-forbidden.png",
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios_sharp),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
//
//   Future<void> init() async {
//     tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//
//   @override
//   void dispose() {
//     tabController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return NestedScrollView(
//       key: _scaffoldKey,
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         return <Widget>[
//           SliverAppBar(
//             expandedHeight: MediaQuery.of(context).size.height * 0.24,
//             bottom: TabBar(
//               controller: tabController,
//               tabs: const [
//                 Tab(text: 'HOUSE PROPERTY'),
//                 Tab(text: 'PERSONAL ASSETS'),
//                 Tab(text: 'INTANGIBLE ASSETS'),
//                 Tab(text: 'FINANCIAL ASSETS'),
//               ],
//               labelStyle: boldTextStyle(color: const Color(0xff084887)),
//               labelColor: black,
//               unselectedLabelStyle: primaryTextStyle(),
//               unselectedLabelColor: grey,
//               isScrollable: true,
//               indicatorColor: const Color(0xff084887),
//               indicatorWeight: 3,
//               indicatorSize: TabBarIndicatorSize.tab,
//             ),
//             floating: true,
//             forceElevated: innerBoxIsScrolled,
//             pinned: true,
//             automaticallyImplyLeading: false,
//             titleSpacing: 0,
//             backgroundColor: Colors.white,
//             actionsIconTheme: const IconThemeData(opacity: 0.0),
//             title: Column(
//               children: [
//                 10.height,
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('My Vault', style: boldTextStyle(size: 20))
//                           .paddingOnly(left: 0, right: 16, bottom: 8),
//                       GestureDetector(
//                         onTap: (){
//                           _show(context);
//                         },
//                         child: Wrap(
//                           children: [
//                             Text('ADD',
//                                 style: boldTextStyle(
//                                   size: 18,
//                                   color: Colors.red,
//                                 )),
//                             const Icon(
//                               Icons.add_circle,
//                               color: Colors.red,
//                               size: 20,
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             flexibleSpace: FlexibleSpaceBar(
//               background: Container(
//
//                 decoration: boxDecorationWithRoundedCorners(
//                   borderRadius: BorderRadius.circular(1),
//                   border: Border.all(color: grey.withOpacity(0.2), width: 2),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: <Widget>[
//
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
//                       padding: const EdgeInsets.only(top: 35,),
//                       child: AppTextField(
//                           textFieldType: TextFieldType.NAME,
//                           textAlignVertical: TextAlignVertical.center,
//                           decoration: InputDecoration(
//                             contentPadding: const EdgeInsets.only(
//                                 left: 16, right: 13, top: 25, bottom: 25),
//                             filled: true,
//                             suffixIcon: const Icon(Icons.search),
//                             fillColor: Colors.grey.withOpacity(0.1),
//                             hintText: "Search Everything",
//                             hintStyle: secondaryTextStyle(),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                               borderSide: BorderSide(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   width: 2),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                               borderSide: BorderSide(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   width: 2),
//                             ),
//                           )),
//                     ),
//                   ],
//                 )
//               ),
//             ),
//           )
//
//         ];
//       },
//       body: TabBarView(
//         controller: tabController,
//         children: const [
//           HLHousingPropComponent(),
//           HLPersonalAssetsComponent(),
//           HLIntangibleAssetsComponent(),
//           HLFinancialComponent()
//         ],
//       ),
//     );
//   }
// }
