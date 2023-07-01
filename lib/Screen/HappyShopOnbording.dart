import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:engishop/Helper/HappyShopString.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Screen/HappyShopLogin.dart';
import 'package:engishop/Screen/HappyShopOnbording.dart';
import 'package:engishop/main.dart';
import 'dart:async';
import 'package:engishop/widget/HappyShopAppBar.dart';
import 'package:engishop/widget/HappyShopDrawer.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:like_button/like_button.dart';
import 'package:engishop/widget/IntroPage.dart';
import 'package:engishop/Helper/SmartKitColor.dart';
import 'package:engishop/Screen/HappyShopSplash.dart';

class HappyShopOnbording extends StatefulWidget {
  const HappyShopOnbording({
    Key? key,
  }) : super(key: key);

  @override
  State<HappyShopOnbording> createState() => _HappyShopOnbordingState();
}

class _HappyShopOnbordingState extends State<HappyShopOnbording>
    with TickerProviderStateMixin {
  /***********************************************************/
  late AnimationController _animationController, animationController;
  bool dragFromLeft = false;

  late PageController _pageController;
  int currentIndex = 0;

  double opacityLevel = 0.0;
  late Animation animation;
  /***********************************************************/
  int _curSelected = 0;
  late List<Widget> happyShopBottomeTab;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
    setState(() {});
    super.initState();
    _curSelected = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  List<Widget> indicators = [];
  void onAddButtonTapped(int index) {
    // use this to animate to the page
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 1000), curve: Curves.elasticInOut);

    // or this to jump to it without animating
    _pageController.jumpToPage(index);
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 6,
        width: isActive ? 15 : 5,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // gradient:
          // LinearGradient(begin: Alignment.centerLeft,
          // end: Alignment.centerRight, colors: [color1, color1]),
          color: isActive ? color1 : color2,
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ResponsiveApp(builder: (context) {
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(56),
                child: HappyShopAppBar(),
              ),
              drawer: HappyShopDrawer(),
              bottomNavigationBar: getBottomBar(),
              body: Stack(
                children: [
                  PageView(
                    onPageChanged: (int page) {
                      setState(() {
                        currentIndex = page;
                      });
                    },
                    controller: _pageController,
                    children: <Widget>[
                      IntroPage(
                        // imgurl: "https://smartkit.wrteam.in/smartkit/happyshop/intro-1.svg",
                        imgurl:
                            "https://smartkit.wrteam.in/smartkit/happyshop/intro-1.svg",
                        titletext: "Choose \nYour Products",
                        subtext:
                            "Discover New Spring Collection \nEveryday with Happyshop",
                      ),
                      IntroPage(
                        // imgurl: "https://smartkit.wrteam.in/smartkit/happyshop/intro-2.svg",
                        imgurl:
                            "https://smartkit.wrteam.in/smartkit/happyshop/intro-2.svg",
                        titletext: "Easy Payment \nMethod",
                        subtext:
                            "We connect you to your favourite online brands \nso let's browse it with Happyshop",
                      ),
                      IntroPage(
                        // imgurl: "https://smartkit.wrteam.in/smartkit/happyshop/intro-3.svg",
                        imgurl:
                            "https://smartkit.wrteam.in/smartkit/happyshop/intro-3.svg",
                        titletext: "Get Your Delivery \nat Home",
                        subtext:
                            "We offers best comfort product \nfor you and your family",
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 15.0,
                    left: MediaQuery.of(context).size.width / 8,
                    right: MediaQuery.of(context).size.width / 8,
                    child: InkWell(
                      onTap: () {
                        if (currentIndex == 0) {
                          setState(() {
                            indicators.add(_indicator(true));

                            currentIndex = 1;
                            onAddButtonTapped(currentIndex);
                          });
                        } else if (currentIndex == 1) {
                          setState(() {
                            indicators.add(_indicator(true));
                            currentIndex = 2;
                            onAddButtonTapped(currentIndex);
                          });
                        } else if (currentIndex == 2) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HappyShopLogin()),
                          );
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            currentIndex == 0
                                ? "Next"
                                : currentIndex == 1
                                    ? "Next"
                                    : "Start Now",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [happyshopcolor3, happyshopcolor2])),
                      ),
                    ),
                  )
                ],
              )));
    });
  }

  getBottomBar() {
    return BottomAppBar(
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: _curSelected,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    label: 'Home',
                    icon: LikeButton(
                      size: 24.0,
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 0);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.home_outlined,
                          size: 24,
                          color: Color(0x31333333).withOpacity(0.5),
                        );
                      },
                    ),
                    activeIcon: LikeButton(
                      size: 24.0,
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 0);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.home_sharp,
                          size: 24,
                          color: happyshopcolor2,
                        );
                      },
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Favorite',
                    icon: LikeButton(
                      size: 24.0,
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 1);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite_border,
                          size: 24,
                          color: Color(0x31333333).withOpacity(0.5),
                        );
                      },
                    ),
                    activeIcon: LikeButton(
                      size: 24.0,
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 1);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          size: 24,
                          color: happyshopcolor2,
                        );
                      },
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Notifications',
                    icon: LikeButton(
                      size: 24.0,
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 2);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.notifications_none,
                          size: 24,
                          color: Color(0x31333333).withOpacity(0.5),
                        );
                      },
                    ),
                    activeIcon: LikeButton(
                      size: 24.0,
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 2);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.notifications,
                          size: 24,
                          color: happyshopcolor2,
                        );
                      },
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: 'Track Order',
                    icon: LikeButton(
                      size: 24.0,
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 3);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.directions_bike_outlined,
                          size: 24,
                          color: Color(0x31333333).withOpacity(0.5),
                        );
                      },
                    ),
                    activeIcon: LikeButton(
                      onTap: (bool isLiked) {
                        return onNavigationTap(isLiked, 3);
                      },
                      circleColor: CircleColor(
                          start: primary, end: primary.withOpacity(0.1)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: primary,
                        dotSecondaryColor: primary.withOpacity(0.1),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.directions_bike,
                          size: 24,
                          color: happyshopcolor2,
                        );
                      },
                    ),
                  ),
                ],
              ))),
    );
  }

  Future<bool> onNavigationTap(bool isLiked, int index) async {
    setState(() {
      _curSelected = index;
    });
    return !isLiked;
  }

  back() {
    return const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryLight2, primaryLight3],
          stops: [0, 1]),
    );
  }
}
