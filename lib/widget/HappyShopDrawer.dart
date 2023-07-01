import 'package:flutter/material.dart';
import 'package:engishop/Helper/HappyShopString.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:engishop/Screen/HappyShopSplash.dart';
import 'package:flutter/src/scheduler/binding.dart';

class HappyShopDrawer extends StatefulWidget {
  const HappyShopDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<HappyShopDrawer> createState() => _HappyShopDrawerState();
}

class _HappyShopDrawerState extends State<HappyShopDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          const HappyShopDrawerHeader(),
          HappyShopDrawerListTile(
              title: HOME_LBL,
              icon: Icons.home,
              route: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HappyShopSplash(), //HappyShopCart(),
                  ),
                );
              }),
          _getDivider(),
          HappyShopDrawerListTile(
            title: CART,
            icon: Icons.add_shopping_cart,
            route: () {
              /*
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopSplash(), //HappyShopCart(),
                ),
              );*/
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            img: true,
            imgurl:
                "https://smartkit.wrteam.in/smartkit/happyshop/pro_trackorder.svg",
            title: TRACK_ORDER,
            icon: Icons.bike_scooter,
            route: () {
              /*
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HappyShopSplash(), //HappyShopTreackOrder(
                  // appbar: true,
                  //),
                ),
              );*/
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            img: true,
            imgurl: "https://smartkit.wrteam.in/smartkit/happyshop/profile.svg",
            title: PROFILE,
            icon: Icons.person,
            route: () {
              /*
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopSplash(), //HappyShopPeofile(),
                ),
              );*/
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            img: true,
            imgurl: "https://smartkit.wrteam.in/smartkit/happyshop/pro_od.svg",
            title: ORDER_DETAIL,
            icon: Icons.content_paste_sharp,
            route: () {
              /*
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HappyShopSplash(), //HappyShopOrderDetails(),
                ),
              );*/
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            img: true,
            imgurl:
                "https://smartkit.wrteam.in/smartkit/happyshop/pro_notification.svg",
            title: NOTIFICATION,
            icon: Icons.notification_important,
            route: () {
              /*
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HappyShopSplash(), //HappyShopNotification(
                  // appbar: true,
                  //),
                ),
              );*/
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            img: true,
            imgurl:
                "https://smartkit.wrteam.in/smartkit/happyshop/pro_favourite.svg",
            title: FAVORITE,
            icon: Icons.favorite,
            route: () {
              /*
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopSplash(), //HappyShopFavrite(
                  // appbar: true,
                  //),
                ),
              );*/
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            title: "LOGIN",
            icon: Icons.login,
            route: () {
              /*
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopSplash(), //HappyShopLogin(),
                ),
              );*/
            },
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            title: "SingUp",
            icon: Icons.account_box_rounded,
            route: () {
              /*s
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopSplash(), //HappyShopSingUp(),
                ),
              );*/
            },
          ),
        ],
      ),
    );
  }

  _getDivider() {
    return Divider(
      color: Colors.grey,
      height: 1,
    );
  }

  call() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HappyShopSplash(),
      ),
    );
  }
}

class HappyShopDrawerListTile extends StatelessWidget {
  final IconData icon;
  final String? title, imgurl;
  final Function route;
  final bool img;

  HappyShopDrawerListTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
    this.img = false,
    this.imgurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: img == true
            ? SvgPicture.network(
                imgurl!,
                width: 28.0,
                color: happyshopcolor2,
              )
            : Icon(
                icon,
                color: happyshopcolor2,
              ),
        title: Text(
          title!,
          style: TextStyle(color: textcolor),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: happyshopcolor2,
        ),
        onTap: () {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            route();
          });
        });
  }
}

class HappyShopDrawerHeader extends StatelessWidget {
  const HappyShopDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: happyshopgradient),
      padding: EdgeInsets.only(top: 24),
      child: InkWell(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            // margin: EdgeInsets.all(35),
            child: Row(
              children: [
                SvgPicture.network(
                  'https://smartkit.wrteam.in/smartkit/images/happyshopwhitelogo.svg',
                  width: 60.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 26,
                ),
                const Text(
                  App_title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Open sans',
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
