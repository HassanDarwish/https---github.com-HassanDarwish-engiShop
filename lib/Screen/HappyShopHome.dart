import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Screen/HappyShopFavrite.dart';
import 'package:GiorgiaShop/Screen/HappyShopHomeTab.dart';
import 'package:GiorgiaShop/Screen/HappyShopNotification.dart';
import 'package:GiorgiaShop/Screen/HappyShopTrackOrder.dart';
import 'package:GiorgiaShop/widget/HappyShopAppBar.dart';
import 'package:GiorgiaShop/widget/HappyShopDrawer.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class HappyShopHome extends StatefulWidget {
  const HappyShopHome({Key? key}) : super(key: key);

  @override
  _HappyShopHomeState createState() => _HappyShopHomeState();
}

class _HappyShopHomeState extends State<HappyShopHome> {
  List<Widget>? happyShopBottomeTab;
  int _curSelected = 0;

  @override
  void initState() {
    super.initState();
    _curSelected = 0;
    happyShopBottomeTab = [
      const HappyShopHpmeTab(),
      const HappyShopFavrite(
        appbar: false,
      ),
      const HappyShopNotification(
        appbar: false,
      ),
      const HappyShopTreackOrder(
        appbar: false,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(
        onWillPop: () async {
          /* bool result = await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Giorgia Shop'),
          ),
        );
        if (result == null) result = false;*/

          //return result;
          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(56),
            child: HappyShopAppBar(scaffoldKey: scaffoldKey),
          ),
          drawer: const HappyShopDrawer(),
          backgroundColor: Colors.white10,
          extendBodyBehindAppBar: true,
          bottomNavigationBar: getBottomBar(),
          body: happyShopBottomeTab![_curSelected],
        ));
  }

  getBottomBar() {
    return BottomAppBar(
      child: Container(
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
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
                          color: const Color(0x31333333).withOpacity(0.5),
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
                        return const Icon(
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
                          color: const Color(0x31333333).withOpacity(0.5),
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
                        return const Icon(
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
                          color: const Color(0x31333333).withOpacity(0.5),
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
                        return const Icon(
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
                          color: const Color(0x31333333).withOpacity(0.5),
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
                        return const Icon(
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
}
