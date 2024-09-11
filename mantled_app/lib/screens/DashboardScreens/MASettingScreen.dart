// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
// import 'package:mantled_app/constants/constants.dart';
// import 'package:mantled_app/model/profileDetails.dart';
// import 'package:mantled_app/providers.dart';
// // import 'package:mantled_app/screens/OnboardingScreens/NBEditProfileScreen.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
// import 'package:nb_utils/nb_utils.dart';
// // import 'package:mantled_app/utils/AppWidget.dart';
// import 'package:mantled_app/model/NBModel.dart';
// import 'package:mantled_app/utils/NBDataProviders.dart';
// import 'package:mantled_app/utils/NBImages.dart';
// import 'package:mantled_app/utils/NBWidgets.dart';
// import 'package:provider/provider.dart';
//
// class NBSettingScreen extends StatefulWidget {
//   static String tag = '/NBSettingScreen';
//
//   const NBSettingScreen({Key? key}) : super(key: key);
//
//   @override
//   NBSettingScreenState createState() => NBSettingScreenState();
// }
//
// class NBSettingScreenState extends State<NBSettingScreen> {
//   List<NBSettingsItemModel> mSettingList = nbGetSettingItems();
//   NBLanguageItemModel? result = NBLanguageItemModel(NBEnglishFlag, 'English');
//   String? fullName;
//   String? email;
//   late Future  profileDetails;
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<Data>(context, listen: false).fetchProfileDetails(context);
//     profileDetails= getData();
//   }
//
//   Future getData() async {
//     await Provider.of<Data>(context, listen: false).fetchProfileDetails(context);
//     var c =   Provider.of<Data>(context, listen: false).profileDetails;
//     return c;
//   }
//   @override
//   void setState(fn) {
//     if (mounted) super.setState(fn);
//   }
//
//   gotoNext(int index) async {
//     result = await mSettingList[index].widget.launch(context);
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Settings', style: boldTextStyle(color: black, size: 20)),
//             Text('LOG OUT', style: boldTextStyle(color: Colors.red, size: 15)).onTap(() {
//               // const HLSignupScreen().launch(context);
//             }),
//           ],
//         ),
//         backgroundColor: white,
//       )
//       ,
//       body: Column(
//         children: [
//           15.height,
//           FutureBuilder(
//               future: profileDetails,
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.data == null) {
//                   return const Center(
//                     child: CupertinoActivityIndicator(),
//                   );
//                 }
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                     child: CupertinoActivityIndicator(),
//                   );
//                 }
//                 else if (!snapshot.hasData) {
//                   return Column(
//                     children: const [
//                       Text(
//                         "No data",
//                         style: TextStyle(
//                           backgroundColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   );
//                 }
//                 if (snapshot.hasData) {
//                   if (snapshot.data != null) {
//                     ProfileDetails profileDetails = snapshot.data ;
//                     return GestureDetector(
//                       onTap: () {
//                         bottomsheet.showCupertinoModalBottomSheet(
//                           expand: false,
//                           context: context,
//                           backgroundColor: Colors.transparent,
//                           builder: (context) => NBEditProfileScreen(
//                             profileDetails:profileDetails
//                           ),
//                         );
//                       },
//                       child: ListTile(
//                         title: Text(
//                           profileDetails.fullName!,
//                           style: boldTextStyle(),
//                         ),
//                         subtitle: Text(profileDetails.email!),
//                         leading: profileDetails.profilePic!=null ?Image.network(
//                          profileDetails.profilePic.toString(),
//                         ):Image.asset(
//                           "assets/isers.png",
//                         ),
//                         trailing: const Icon(Icons.navigate_next).paddingAll(8),
//                       ),
//                     );
//                   }
//                   else {
//                     return const CupertinoActivityIndicator();
//                   }
//                 }
//                 else {
//                   return const CupertinoActivityIndicator();
//                 }
//               }
//
//           ),
//           SizedBox(
//             height: context.height() * 0.5,
//             child: ListView.separated(
//               padding: const EdgeInsets.all(16),
//               separatorBuilder: (_, index) {
//                 return const Divider();
//               },
//               itemCount: mSettingList.length,
//               itemBuilder: (_, index) {
//                 return Row(
//                   children: [
//                     Text('${mSettingList[index].title}',
//                             style: primaryTextStyle(color: black))
//                         .expand(),
//                     Row(
//                       children: [
//                         const Icon(Icons.navigate_next).paddingAll(8),
//                       ],
//                     ),
//                   ],
//                 ).onTap(() {
//                   if(index==4){
//
//                   }
//                   bottomsheet.showCupertinoModalBottomSheet(
//                         expand: false,
//                         context: context,
//                         backgroundColor: Colors.transparent,
//                         builder: (context) =>   mSettingList[index].widget!
//                     );
//
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
