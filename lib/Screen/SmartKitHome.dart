import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:engishop/Helper/SmartKitColor.dart';

import 'package:engishop/widget/HappyShopMain.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Widget/SmartKtHomeTile.dart';
//import 'AppSplash.dart';
import 'SmartKitHomeLogo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late DateTime _currentBackPressTime;

  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<bool> _onWillPop() async {
    var now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > Duration(seconds: 2)) {
      _currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Double tap to exit app',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var devicewidth = MediaQuery.of(context).size.width;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _globalKey,
        // backgroundColor: Color(0xFFFFFFFF),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              HomeLogo(
                width: width,
              ),

              // Tab //
              Container(
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: purpal,
                  indicatorColor: purpal,
                  unselectedLabelColor: purpalOpacity22,
                  tabs: [
                    Tab(
                      child: SamrtKitTabText(
                        title: "Full Application",
                        indicatorwidth: 60,
                      ),
                    ),
                    Tab(
                      child: SamrtKitTabText(
                        title: "UI Screen ",
                        indicatorwidth: 60,
                      ),
                    ),
                    Tab(
                      child: SamrtKitTabText(
                        title: "Widget",
                        indicatorwidth: 60,
                      ),
                    ),
                    Tab(
                      child: SamrtKitTabText(
                        title: "Integration",
                        indicatorwidth: 60,
                      ),
                    ),
                  ],
                ),
              ),

              SamrtKitHomeTabView(tabController: _tabController),
            ],
          ),
        ),
      ),
    );
  }
}

class SamrtKitHomeTabView extends StatelessWidget {
  const SamrtKitHomeTabView({
    Key? key,
    required TabController tabController,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: [
          HomeGrid(), /*UIScreens(), WidgetRoute(), IntegrationRoute()*/
        ],
      ),
    );
  }
}

class HomeGrid extends StatelessWidget {
  const HomeGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List gridlistmobile = [
      {
        'isnew': true,
        'icon': 'assets/estudy.svg',
        'bg': eStudy1,
        'highlightColor': eStudy6,
        'iconbg': eStudy4,
        'iconbgshodw': eStudy5,
        'title': 'eStudy',
        'subtitle': 'Learning App UI',
        'subtitleGradient1': eStudy2,
        'subtitleGradient2': eStudy3,
        'screentext': '+ 15 screens',
        'route': HappyShopMain() //EStudyMain()
      },
      {
        'isnew': true,
        'icon': 'assets/foodmaster.svg',
        'bg': foodmaster1,
        'highlightColor': foodmaster6,
        'iconbg': foodmaster4,
        'iconbgshodw': foodmaster5,
        'title': 'FoodMaster',
        'subtitle': 'Food App UI',
        'subtitleGradient1': foodmaster2,
        'subtitleGradient2': foodmaster3,
        'screentext': '+18 screens',
        'route': HappyShopMain() //FoodMasterMain()
      },
      {
        'isnew': false,
        'icon': 'assets/grobag.svg',
        'bg': grobag1,
        'highlightColor': grobag6,
        'iconbg': grobag4,
        'iconbgshodw': grobag5,
        'title': 'GroBag',
        'subtitle': 'Grocery App UI',
        'subtitleGradient1': grobag2,
        'subtitleGradient2': grobag3,
        'screentext': '20+ screens',
        'route': HappyShopMain() //GrobagMain()
      },
      {
        'isnew': false,
        'icon': 'assets/news.svg',
        'bg': news1,
        'highlightColor': news2,
        'iconbg': news4,
        'iconbgshodw': news5,
        'title': 'News',
        'subtitle': 'News App UI',
        'subtitleGradient1': news2,
        'subtitleGradient2': news3,
        'screentext': '16+ screens',
        'route': HappyShopMain() //NewsApp()
      },
      {
        'isnew': false,
        'icon': 'assets/happyshop.svg',
        'bg': happyshopcolor1,
        'highlightColor': happyshopcolor6,
        'iconbg': happyshopcolor4,
        'iconbgshodw': happyshopcolor5,
        'title': 'HappyShop',
        'subtitle': 'eCommerce App UI',
        'subtitleGradient1': happyshopcolor2,
        'subtitleGradient2': happyshopcolor3,
        'screentext': '16+ screens',
        'route': HappyShopMain()
      },
      {
        'isnew': false,
        'icon': 'assets/cryptoking.svg',
        'bg': cryptocolor1,
        'highlightColor': cryptocolor6,
        'iconbg': cryptocolor4,
        'iconbgshodw': cryptocolor5,
        'title': 'CryptoTech',
        'subtitle': 'BitCoin App UI',
        'subtitleGradient1': cryptocolor2,
        'subtitleGradient2': cryptocolor3,
        'screentext': '12+ screens',
        'route': HappyShopMain() //CryptoTechMain()
      },
      {
        'isnew': false,
        'icon': 'assets/bookking.svg',
        'bg': bookKing1,
        'highlightColor': bookKing6,
        'iconbg': bookKing4,
        'iconbgshodw': bookKing5,
        'title': 'BookKing',
        'subtitle': 'Offline Books App UI',
        'subtitleGradient1': bookKing2,
        'subtitleGradient2': bookKing3,
        'screentext': '5+ screens',
        'route': HappyShopMain() //BookKingMain()
      },
      {
        'isnew': false,
        'icon': 'assets/smartkey.svg',
        'bg': smartkey1,
        'highlightColor': smartkey6,
        'iconbg': smartkey4,
        'iconbgshodw': smartkey5,
        'title': 'SmartKey',
        'subtitle': 'Quiz App UI',
        'subtitleGradient1': smartkey2,
        'subtitleGradient2': smartkey3,
        'screentext': '15+ screens',
        'route': HappyShopMain() //SmartKeyMain()
      },
      {
        'isnew': false,
        'icon': 'assets/lightvpn.svg',
        'bg': vpn11,
        'highlightColor': vpn66,
        'iconbg': vpn11,
        'iconbgshodw': vpn55,
        'title': 'LightVpn',
        'subtitle': 'Vpn App UI',
        'subtitleGradient1': vpn22,
        'subtitleGradient2': vpn33,
        'screentext': '6+ screens',
        'route': HappyShopMain() //VpnMain()
      },
      {
        'isnew': false,
        'icon': 'assets/MusicFlex.svg',
        'bg': music1,
        'highlightColor': music6,
        'iconbg': music1,
        'iconbgshodw': happyshopcolor5,
        'title': 'Music',
        'subtitle': 'Music App UI',
        'subtitleGradient1': music2,
        'subtitleGradient2': music3,
        'screentext': '+8 screens',
        'route': HappyShopMain() // MusicMain()
      },
      {
        'isnew': false,
        'icon': 'assets/MotiQuotes.svg',
        'bg': quotes1,
        'highlightColor': quotes6,
        'iconbg': quotes4,
        'iconbgshodw': quotes5,
        'title': 'Quotes',
        'subtitle': 'Quotes App UI',
        'subtitleGradient1': quotes2,
        'subtitleGradient2': quotes3,
        'screentext': '+6 screens',
        'route': HappyShopMain() //QuotesMain()
      },
      {
        'isnew': false,
        'icon': 'assets/WebApp.svg',
        'bg': webApp1,
        'highlightColor': webApp6,
        'iconbg': webApp4,
        'iconbgshodw': webApp5,
        'title': 'Web App',
        'subtitle': 'Web',
        'subtitleGradient1': webApp2,
        'subtitleGradient2': webApp3,
        'screentext': '+3 screens',
        'route': HappyShopMain() //WebAppMain()
      },
    ];
    final List gridlistdesktop = [
      {
        'isnew': true,
        'icon': 'assets/grobag.svg',
        'bg': grobag1,
        'highlightColor': grobag6,
        'iconbg': grobag4,
        'iconbgshodw': grobag5,
        'title': 'GroBag',
        'subtitle': 'Grocery App UI',
        'subtitleGradient1': grobag2,
        'subtitleGradient2': grobag3,
        'screentext': '20+ screens',
        'route': HappyShopMain() //GrobagMain()
      },
      {
        'isnew': false,
        'icon': 'assets/estudy.svg',
        'bg': eStudy1,
        'highlightColor': eStudy6,
        'iconbg': eStudy4,
        'iconbgshodw': eStudy5,
        'title': 'eStudy',
        'subtitle': 'Learning App UI',
        'subtitleGradient1': eStudy2,
        'subtitleGradient2': eStudy3,
        'screentext': '+ 15 screens',
        'route': HappyShopMain() //EStudyMain()
      },
      {
        'isnew': false,
        'icon': 'assets/foodmaster.svg',
        'bg': foodmaster1,
        'highlightColor': foodmaster6,
        'iconbg': foodmaster4,
        'iconbgshodw': foodmaster5,
        'title': 'FoodMaster',
        'subtitle': 'Food App UI',
        'subtitleGradient1': foodmaster2,
        'subtitleGradient2': foodmaster3,
        'screentext': '+18 screens',
        'route': HappyShopMain() //FoodMasterMain()
      },
      {
        'isnew': false,
        'icon': 'assets/news.svg',
        'bg': news1,
        'highlightColor': news2,
        'iconbg': news4,
        'iconbgshodw': news5,
        'title': 'News',
        'subtitle': 'News App UI',
        'subtitleGradient1': news2,
        'subtitleGradient2': news3,
        'screentext': '16+ screens',
        'route': HappyShopMain() //NewsApp()
      },
      {
        'isnew': false,
        'icon': 'assets/happyshop.svg',
        'bg': happyshopcolor1,
        'highlightColor': happyshopcolor6,
        'iconbg': happyshopcolor4,
        'iconbgshodw': happyshopcolor5,
        'title': 'HappyShop',
        'subtitle': 'eCommerce App UI',
        'subtitleGradient1': happyshopcolor2,
        'subtitleGradient2': happyshopcolor3,
        'screentext': '16+ screens',
        'route': HappyShopMain()
      },
      {
        'isnew': false,
        'icon': 'assets/smartkey.svg',
        'bg': smartkey1,
        'highlightColor': smartkey6,
        'iconbg': smartkey4,
        'iconbgshodw': smartkey5,
        'title': 'SmartKey',
        'subtitle': 'Quiz App UI',
        'subtitleGradient1': smartkey2,
        'subtitleGradient2': smartkey3,
        'screentext': '15+ screens',
        'route': HappyShopMain() //SmartKeyMain()
      },
      {
        'isnew': false,
        'icon': 'assets/bookking.svg',
        'bg': bookKing1,
        'highlightColor': bookKing6,
        'iconbg': bookKing4,
        'iconbgshodw': bookKing5,
        'title': 'BookKing',
        'subtitle': 'Offline Books App UI',
        'subtitleGradient1': bookKing2,
        'subtitleGradient2': bookKing3,
        'screentext': '5+ screens',
        'route': HappyShopMain() //BookKingMain()
      },
      {
        'isnew': false,
        'icon': 'assets/lightvpn.svg',
        'bg': vpn11,
        'highlightColor': vpn66,
        'iconbg': vpn11,
        'iconbgshodw': vpn55,
        'title': 'LightVpn',
        'subtitle': 'Vpn App UI',
        'subtitleGradient1': vpn22,
        'subtitleGradient2': vpn33,
        'screentext': '6+ screens',
        'route': HappyShopMain() //VpnMain()
      },
      {
        'isnew': false,
        'icon': 'assets/MusicFlex.svg',
        'bg': music1,
        'highlightColor': music6,
        'iconbg': music1,
        'iconbgshodw': happyshopcolor5,
        'title': 'Music',
        'subtitle': 'Music App UI',
        'subtitleGradient1': music2,
        'subtitleGradient2': music3,
        'screentext': '+8 screens',
        'route': HappyShopMain() //MusicMain()
      },
      {
        'isnew': false,
        'icon': 'assets/MotiQuotes.svg',
        'bg': quotes1,
        'highlightColor': quotes6,
        'iconbg': quotes4,
        'iconbgshodw': quotes5,
        'title': 'Quotes',
        'subtitle': 'Quotes App UI',
        'subtitleGradient1': quotes2,
        'subtitleGradient2': quotes3,
        'screentext': '+6 screens',
        'route': HappyShopMain() //QuotesMain()
      },
      {
        'isnew': false,
        'icon': 'assets/cryptoking.svg',
        'bg': cryptocolor1,
        'highlightColor': cryptocolor6,
        'iconbg': cryptocolor4,
        'iconbgshodw': cryptocolor5,
        'title': 'CryptoTech',
        'subtitle': 'BitCoin App UI',
        'subtitleGradient1': cryptocolor2,
        'subtitleGradient2': cryptocolor3,
        'screentext': '12+ screens',
        'route': HappyShopMain() //CryptoTechMain()
      },
    ];

    return ScreenTypeLayout(
      mobile: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(12, (index) {
            return Container(
              margin: new EdgeInsets.all(6.0),
              child: SmartKitHomeTile(
                isnew: gridlistmobile[index]['isnew'],
                bg: gridlistmobile[index]['bg'],
                highlightColor: gridlistmobile[index]['highlightColor'],
                iconbg: gridlistmobile[index]['iconbg'],
                iconbgshadow: gridlistmobile[index]['iconbgshodw'],
                subtitlebggradiant1: gridlistmobile[index]['subtitleGradient1'],
                subtitlebggradiant2: gridlistmobile[index]['subtitleGradient2'],
                iconpath: gridlistmobile[index]['icon'],
                title: gridlistmobile[index]['title'],
                subtitle: gridlistmobile[index]['subtitle'],
                screnstext: gridlistmobile[index]['screentext'],
                route: gridlistmobile[index]['route'],
              ),
            );
          }),
        ),
      ),
      tablet: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(11, (index) {
            return Container(
              margin: new EdgeInsets.all(6.0),
              child: SmartKitHomeTile(
                isnew: gridlistdesktop[index]['isnew'],
                bg: gridlistdesktop[index]['bg'],
                highlightColor: gridlistdesktop[index]['highlightColor'],
                iconbg: gridlistdesktop[index]['iconbg'],
                iconbgshadow: gridlistdesktop[index]['iconbgshodw'],
                subtitlebggradiant1: gridlistdesktop[index]
                    ['subtitleGradient1'],
                subtitlebggradiant2: gridlistdesktop[index]
                    ['subtitleGradient2'],
                iconpath: gridlistdesktop[index]['icon'],
                title: gridlistdesktop[index]['title'],
                subtitle: gridlistdesktop[index]['subtitle'],
                screnstext: gridlistdesktop[index]['screentext'],
                route: gridlistdesktop[index]['route'],
              ),
            );
          }),
        ),
      ),
      desktop: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        child: GridView.count(
          crossAxisCount: 4,
          children: List.generate(11, (index) {
            return Container(
              margin: new EdgeInsets.all(6.0),
              child: SmartKitHomeTile(
                isnew: gridlistdesktop[index]['isnew'],
                bg: gridlistdesktop[index]['bg'],
                highlightColor: gridlistdesktop[index]['highlightColor'],
                iconbg: gridlistdesktop[index]['iconbg'],
                iconbgshadow: gridlistdesktop[index]['iconbgshodw'],
                subtitlebggradiant1: gridlistdesktop[index]
                    ['subtitleGradient1'],
                subtitlebggradiant2: gridlistdesktop[index]
                    ['subtitleGradient2'],
                iconpath: gridlistdesktop[index]['icon'],
                title: gridlistdesktop[index]['title'],
                subtitle: gridlistdesktop[index]['subtitle'],
                screnstext: gridlistdesktop[index]['screentext'],
                route: gridlistdesktop[index]['route'],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class SamrtKitTabText extends StatelessWidget {
  final String? title;
  final double? indicatorwidth;

  const SamrtKitTabText({
    Key? key,
    this.title,
    this.indicatorwidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 12.0,
          ),
          Text(
            title!,
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }
}
