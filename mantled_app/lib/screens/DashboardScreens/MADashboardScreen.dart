import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mantled_app/providers.dart';
import 'package:mantled_app/screens/DashboardScreens/MACollabScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAEnterPinScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAHomeScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MAVaultScreen.dart';
// import 'package:mantled_app/screen/HLAddDebtScreen.dart';
// import 'package:mantled_app/screen/HLAddFinancialAssetsScreen.dart';
// import 'package:mantled_app/screen/HLAddHousingPropertyScreen.dart';
// import 'package:mantled_app/screen/HLAddIntangibleAssetsScreen.dart';
// import 'package:mantled_app/screen/HLAddPersonalEffectsScreen.dart';
import 'package:mantled_app/screens/MAHomeScreen.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:mantled_app/screens/MAVaultScreen.dart';
import 'package:mantled_app/screens/DashboardScreens/MASettingScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mantled_app/utils/NBColors.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../SettingsScreens/MASettingsScreen.dart';
import 'EnterPinScreenWidgets/theme.dart';

class MADashboardScreen extends StatefulWidget {
  static String tag = '/MADashboardScreen';
  final String? fullName;
  final String? photo;
  const MADashboardScreen({Key? key, this.fullName, this.photo}) : super(key: key);

  @override
  MADashboardScreenState createState() => MADashboardScreenState();
}

class MADashboardScreenState extends State<MADashboardScreen> {
  List<String?> governmentList = [
    "Goverment ID",
    "Married",
    "Single",
    "Divorced",
    "Widow",
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  int _selectedIndex = 0;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Center(
                          child: Text(
                        "Save Your Assets",
                        style: boldTextStyle(size: 20),
                      )),
                      GestureDetector(
                          onTap: () {
                            finish(context);
                          },
                          child: const Icon(
                            Icons.highlight_remove_sharp,
                            size: 29,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  25.height,
                  Center(
                      child: Image.asset(
                    "assets/organize.png",
                    fit: BoxFit.cover,
                  )),
                  10.height,
                  GestureDetector(
                    onTap: () {
                      // bottomsheet.showCupertinoModalBottomSheet(
                      //     expand: false,
                      //     context: context,
                      //     backgroundColor: Colors.transparent,
                      //     builder: (context) =>
                      //     const HLAddFinancialAssetsScreen());
                    },
                    child: ListTile(
                      title: Text(
                        "Financial Assets",
                        style: boldTextStyle(),
                      ),
                      subtitle: const Text("Brief explanation of the above"),
                      leading: Image.asset(
                        "assets/moneys.png",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // bottomsheet.showCupertinoModalBottomSheet(
                      //     expand: false,
                      //     context: context,
                      //     backgroundColor: Colors.transparent,
                      //     builder: (context) =>
                      //     const HLAddPersonalEffectsScreen());
                    },
                    child: ListTile(
                      title: Text(
                        "Personal Effects",
                        style: boldTextStyle(),
                      ),
                      subtitle: const Text("Brief explanation of the above"),
                      leading: Image.asset(
                        "assets/glass.png",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // bottomsheet.showCupertinoModalBottomSheet(
                      //     expand: false,
                      //     context: context,
                      //     backgroundColor: Colors.transparent,
                      //     builder: (context) =>
                      //         const HLAddHousingPropertyScreen());
                    },
                    child: ListTile(
                      title: Text(
                        "House Property",
                        style: boldTextStyle(),
                      ),
                      subtitle: const Text("Brief explanation of the above"),
                      leading: Image.asset(
                        "assets/building-3.png",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // bottomsheet.showCupertinoModalBottomSheet(
                      //     expand: false,
                      //     context: context,
                      //     backgroundColor: Colors.transparent,
                      //     builder: (context) =>
                      //     const HLAddIntangibleAssetsScreen());
                    },
                    child: ListTile(
                      title: Text(
                        "Personal Memoirs",
                        style: boldTextStyle(),
                      ),
                      subtitle: const Text("Brief explanation of the above"),
                      leading: Image.asset(
                        "assets/receipt-2.png",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
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
                    child: ListTile(
                      title: Text(
                        "Debts & Liabilities",
                        style: boldTextStyle(),
                      ),
                      subtitle: const Text("Brief explanation of the above"),
                      leading: Image.asset(
                        "assets/money-forbidden.png",
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_sharp),
                    ),
                  ),
                ],
              ),
            ));
  }

  int position = 0;

  PageController? pageController;

  @override
  void initState() {
    super.initState();
    print("The details are showing in homescreen");
    print(widget.photo);
    init();
    Provider.of<Data>(context, listen: false).fetchProfileDetails(context);
  }

  Future<void> init() async {
    pageController = PageController(initialPage: position, viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true; // return false if you want to disable device back button click
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            MAHomeScreen(fullName: widget.fullName, photo: widget.photo),
            const MACollabScreen(),
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                MAEnterPinScreen(
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.circle,
                    borderRadius: BorderRadius.circular(20),
                    activeFillColor: Colors.black,
                  ),
                  onChanged: (v) {
                    if (kDebugMode) {
                      print(v);
                    }
                  },
                  onCompleted: (v) {
                    position++;
                    pageController!.nextPage(
                        duration: const Duration(microseconds: 300),
                        curve: Curves.linear);
                  },
                  maxLength: 4,
                  onSpecialKeyTap: () {
                    print("Iseoluwadara");
                  },
                  specialKey: const SizedBox(),
                  useFingerprint: true,
                ),
                const MAVaultScreen()
              ],

            ),
            const MASettingsScreen()
            //const NBSettingScreen(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: context.width()*0.23,
          child: SizedBox(
            child: SafeArea(
              child: BottomNavigationBar(
                backgroundColor: context.cardColor,
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                selectedItemColor: NBPrimaryColor,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: false,
                elevation: 0.0,
                showUnselectedLabels: false,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Column(
                      children: [
                        Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: _selectedIndex == 0
                                ? const Icon(
                                    Icons.home_filled,
                                    size: 23,
                                  )
                                : const Icon(
                                    Icons.home_filled,
                                    color: Colors.black45,
                                    size: 23,
                                  )),
                        2.height,
                        _selectedIndex == 0
                            ? const Text(
                                "Home",
                                style: TextStyle(color: NBPrimaryColor),
                              )
                            : const Text(
                                "Home",
                                style: TextStyle(color: grey),
                              )
                      ],
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: _selectedIndex == 1
                                  ? const Icon(
                                      Icons.person,
                                      size: 23,
                                    )
                                  : const Icon(
                                Icons.person,
                                      color: Colors.black45,
                                      size: 23,
                                    )),
                          2.height,
                          _selectedIndex == 1
                              ? const Text(
                                  "Collabs",
                                  style: TextStyle(color: NBPrimaryColor),
                                )
                              : const Text(
                                  "Collabs",
                                  style: TextStyle(color: grey),
                                )
                        ],
                      ),
                      label: 'Wallet'),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: _selectedIndex == 2
                                  ? const Icon(
                                      Icons.shield,
                                      color: NBPrimaryColor,
                                      size: 23,
                                    )
                                  : const Icon(
                                      Icons.shield,
                                      color: Colors.black45,
                                      size: 23,
                                    )),
                          2.height,
                          _selectedIndex == 2
                              ? const Text(
                                  "Vault",
                                  style: TextStyle(color: NBPrimaryColor),
                                )
                              : const Text(
                                  "Vault",
                                  style: TextStyle(color: grey),
                                )
                        ],
                      ),
                      label: 'Wallet'),
                  BottomNavigationBarItem(
                      icon: Column(
                        children: [
                          Container(
                              width: 30,
                              height: 30,
                              alignment: Alignment.center,
                              child: _selectedIndex == 3
                                  ? const Icon(
                                Icons.settings,
                                      color: NBPrimaryColor,
                                      size: 23,
                                    )
                                  : const Icon(
                                      Icons.settings,
                                      color: Colors.black45,
                                      size: 23,
                                    )),
                          _selectedIndex == 3
                              ? const Text(
                                  "Settings",
                                  style: TextStyle(color: NBPrimaryColor),
                                )
                              : const Text(
                                  "Settings",
                                  style: TextStyle(color: grey),
                                )
                        ],
                      ),
                      label: 'Statistics'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
