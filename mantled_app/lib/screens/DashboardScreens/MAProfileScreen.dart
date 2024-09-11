import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:nb_utils/nb_utils.dart';
// import 'package:mantled_app/component/NBAudioNewsComponent.dart';
// import 'package:mantled_app/component/NBNewsComponent.dart';
import 'package:mantled_app/model/NBModel.dart';
// import 'package:mantled_app/screen/NBFollowingScreen.dart';
import 'package:mantled_app/utils/NBColors.dart';
import 'package:mantled_app/utils/NBDataProviders.dart';
import 'package:mantled_app/utils/NBImages.dart';

class NBProfileScreen extends StatefulWidget {
  static String tag = '/NBProfileScreen';

  @override
  NBProfileScreenState createState() => NBProfileScreenState();
}

class NBProfileScreenState extends State<NBProfileScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;

  List<NBNewsDetailsModel> newsList = nbGetNewsDetails();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    tabController = TabController(length: 3, vsync: this);
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
    return Scaffold(
      body: NestedScrollView(
        physics: const ScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 330,
              backgroundColor: white,
              title: Text(
                'Profile',
                style: boldTextStyle(size: 20, color: black),
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage(NBProfileImage),
                        radius: 50,
                      ),
                      8.height,
                      Text('Robert Fox', style: boldTextStyle(size: 20)),
                      16.height,
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('17', style: boldTextStyle(color: NBPrimaryColor)),
                              Text('Article', style: boldTextStyle()),
                            ],
                          ).expand(),
                          Column(
                            children: [
                              Text('412', style: boldTextStyle(color: NBPrimaryColor)),
                              Text('Followers', style: boldTextStyle()),
                            ],
                          ).onTap(() {
                           // NBFollowingScreen().launch(context);
                          }).expand(),
                          Column(
                            children: [
                              Text('120', style: boldTextStyle(color: NBPrimaryColor)),
                              Text('Following', style: boldTextStyle()),
                            ],
                          ).onTap(() {
                           // NBFollowingScreen(isFollowing: true).launch(context);
                          }).expand(),
                        ],
                      ),
                      16.height,
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(text: 'All Article'),
                  Tab(text: 'Article'),
                  Tab(text: 'Audio Article'),
                ],
                labelStyle: boldTextStyle(),
                labelColor: black,
                unselectedLabelStyle: primaryTextStyle(),
                unselectedLabelColor: grey,
                isScrollable: true,
                indicatorWeight: 3,
                indicatorColor: NBPrimaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: const [
           // NBNewsComponent(list: newsList),
          //  NBNewsComponent(list: newsList),
          //  NBAudioNewsComponent(list: newsList),
          ],
        ),
      ),
    );
  }
}
