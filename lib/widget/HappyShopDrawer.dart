import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:GiorgiaShop/Screen/HappyShopSplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/binding.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_update/in_app_update.dart';

class HappyShopDrawer extends StatefulWidget {
  const HappyShopDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<HappyShopDrawer> createState() => _HappyShopDrawerState();
}

class _HappyShopDrawerState extends State<HappyShopDrawer> {

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {

    InAppUpdate.checkForUpdate().then((info) {

      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      _showMyDialog();
      //showSnack(e.toString());
    });
  }
 /* void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }*/

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Process'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You Are Updated already '),
              ],
            ),


          ),
          actions: <Widget>[

            TextButton(
              onPressed: () {
                Navigator.pop(context); //close Dialog
              },
              child: Text('Close'),
            ),
          ],
        );

      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
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
                    builder: (context) => const HappyShopSplash(), //HappyShopCart(),
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
          _getDivider(),
          HappyShopDrawerListTile(
            title: "Update",
            icon: Icons.account_box_rounded,
            route: () {
              checkForUpdate();
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
    return const Divider(
      color: Colors.grey,
      height: 1,
    );
  }

  call() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HappyShopSplash(),
      ),
    );
  }
}

class HappyShopDrawerListTile extends StatelessWidget {
  final IconData icon;
  final String? title, imgurl;
  final Function route;
  final bool img;

  const HappyShopDrawerListTile({
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
          style: const TextStyle(color: textcolor),
        ),
        trailing: const Icon(
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
      padding: const EdgeInsets.only(top: 24),
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
                const Text(App_title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'DancingScript',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
