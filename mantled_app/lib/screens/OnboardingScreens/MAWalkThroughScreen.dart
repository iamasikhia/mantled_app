import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:mantled_app/screens/OnboardingScreens/MASignInScreen.dart';
import 'package:mantled_app/utils/MATextStyles.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as bottomsheet;
import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/utils/NBImages.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MAWalkthroughScreen extends StatefulWidget {
  static String tag = '/MAWalkthroughScreen';

  const MAWalkthroughScreen({Key? key}) : super(key: key);

  @override
  MAWalkthroughScreenState createState() => MAWalkthroughScreenState();
}

class MAWalkthroughScreenState extends State<MAWalkthroughScreen> {
  List<String> mPages = <String>[brainstorming1, financialdata1, onlinetransactions1];
List<String> headings=<String>[heading1, heading2, heading3];
  List<String> subHeadings=<String>[subheading1, subheading2, subheading3];
  int position = 0;

  PageController? pageController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    pageController = PageController(initialPage: position, viewportFraction:1);
  }

  var colors=[0xFFF6EEE3,0xFFE5F4FF,0xFFFFFFFF];

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double customHeight= MediaQuery.of(context).size.height*0.1;
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Scaffold(

      backgroundColor: Colors.black.withOpacity(0.1),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: context.height(),
              width: context.width(),
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withOpacity(0.4)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: context.height() * 0.78,
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: mPages.length,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: 500.milliseconds,
                          height: index == position ? context.height() * 0.5 : context.height() * 0.45,

                          child: Column(
                            children: [
                              // Image.asset(
                              //   mPages[index],
                              //   fit: BoxFit.contain,
                              //   width: context.width(),
                              //   height: context.height() * 0.27,
                              // ).cornerRadiusWithClipRRect(16),
                              Container(
                                color: Color(colors[index]),
                                width: context.width(),
                                child:index==2?   Padding(
                                  padding:  EdgeInsets.only(top:context.height() * 0.07,),

                                  child: Image.asset(
                                    mPages[index],
                                    width: context.width(),
                                    height: context.height() * 0.41,
                                  ).cornerRadiusWithClipRRect(0),
                                ):
                                Padding(
                                  padding:  EdgeInsets.only(top:context.height() * 0.07,),
                                  child: Image.asset(
                                    mPages[index],
                                    width: context.width(),
                                    height: context.height() * 0.41,
                                  ).cornerRadiusWithClipRRect(0),
                                ),
                              ),
                              SizedBox(
                                height:  customHeight*0.3,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:30.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(child: Text(headings[index],  style: CustomTextStyle.semiBoldCustomTextStyle(context, 22, Colors.black),textAlign: TextAlign.center, )),
                                    SizedBox(
                                      height:  customHeight*0.1,
                                    ),
                                    Center(child: Text(subHeadings[index],
                                      style: CustomTextStyle.secondaryCustomStyle(context, 16),textAlign: TextAlign.center,))

                                  ],

                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      onPageChanged: (value) {
                        setState(() {
                          position = value;
                        });
                      },
                    ),
                  ),

                  AppButton(

                    text: position < 2 ? 'Skip' : 'Get Started',
                    width:  position ==2? context.width()*0.8:null,
                    height: position ==2? 65:null ,
                    elevation: 0,
                    shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: MAButtonColor,
                    textStyle: boldTextStyle(color: white),
                    onTap: () {
                      setState(() {
                        if (position < 2) {
                          pageController!.nextPage(duration: const Duration(microseconds: 300), curve: Curves.linear);
                        } else if (position == 2) {
                          const MASignInScreen().launch(context);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: context.height()*0.05,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DotIndicator(pageController: pageController!, pages: mPages, indicatorColor: MAButtonColor),


              ],
            ),
          ),
        ],
      ).withHeight(context.height()),
    );
  }
}
