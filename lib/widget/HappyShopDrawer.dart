import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:GiorgiaShop/Helper/cartEnums.dart';
import 'package:GiorgiaShop/Screen/HappyShopSplash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/binding.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:GiorgiaShop/Screen/HappyShopCart.dart';
import 'package:GiorgiaShop/Screen/HappyShopHome.dart';
import 'package:GiorgiaShop/Screen/HappyShopCheckout.dart';
import 'package:GiorgiaShop/Screen/HappyShopFavrite.dart';
import 'package:provider/provider.dart';
import 'package:GiorgiaShop/provider/Session.dart';
import 'package:GiorgiaShop/provider/woocommerceProvider.dart';

class HappyShopDrawer extends StatefulWidget {
    HappyShopDrawer(  {required this.scaffoldKey,
    Key? key,
  }) : super(key: key);
  late    SessionImplementation sessionImp ;
  final GlobalKey<ScaffoldState> scaffoldKey;
  late WoocommerceProvider CustWoocommerceProvider;
   bool isLoggedIn=false,haveAddress=false,register=false,isExist=false;
  @override
  State<HappyShopDrawer> createState() => _HappyShopDrawerState();
}

class _HappyShopDrawerState extends State<HappyShopDrawer> {

  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  @override
  void initState() {
    super.initState();
      widget.sessionImp = Provider.of<SessionImplementation>(context,listen: false);
    widget.CustWoocommerceProvider =
        Provider.of<WoocommerceProvider>(context, listen: false);
  }


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
    widget.sessionImp = Provider.of<SessionImplementation>(context,listen: true);

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
            HappyShopDrawerHeader(),
          HappyShopDrawerListTile(
              title: HOME_LBL,
              icon: Icons.home,
              route: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(HappyShopHome.routeName);
              }),
          _getDivider(),
          HappyShopDrawerListTile(
            title: CART,
            icon: Icons.add_shopping_cart,
            route: () {

              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushNamed(HappyShopCart.routeName);
            },
          ),
          // _getDivider(),
          // HappyShopDrawerListTile(
          //   img: true,
          //   imgurl:
          //       "http://jerma.net/Engi/icons/pro_trackorder.png",
          //   title: TRACK_ORDER,
          //   icon: Icons.bike_scooter,
          //   route: () {
          //     /*
          //     Navigator.of(context).pop();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             HappyShopSplash(), //HappyShopTreackOrder(
          //         // appbar: true,
          //         //),
          //       ),
          //     );*/
          //   },
          // ),
          // _getDivider(),
          // HappyShopDrawerListTile(
          //   img: true,
          //   imgurl: "http://jerma.net/Engi/icons/profile.png",
          //   title: PROFILE,
          //   icon: Icons.person,
          //   route: () {
          //     /*
          //     Navigator.of(context).pop();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => HappyShopSplash(), //HappyShopPeofile(),
          //       ),
          //     );*/
          //   },
          // ),
          // _getDivider(),
          // HappyShopDrawerListTile(
          //   img: true,
          //   imgurl: "http://jerma.net/Engi/icons/pro_od.png",
          //   title: ORDER_DETAIL,
          //   icon: Icons.content_paste_sharp,
          //   route: () {
          //     /*
          //     Navigator.of(context).pop();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             HappyShopSplash(), //HappyShopOrderDetails(),
          //       ),
          //     );*/
          //   },
          // ),
          //_getDivider(),
          // HappyShopDrawerListTile(
          //   img: true,
          //   imgurl:
          //       "http://jerma.net/Engi/icons/pro_notification.png",
          //   title: NOTIFICATION,
          //   icon: Icons.notification_important,
          //   route: () {
          //     /*
          //     Navigator.of(context).pop();
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>
          //             HappyShopSplash(), //HappyShopNotification(
          //         // appbar: true,
          //         //),
          //       ),
          //     );*/
          //   },
          // ),
          _getDivider(),
          Visibility(
            visible: widget.sessionImp.status == sessionEnums.login,
            child: HappyShopDrawerListTile(
              img: true,
              imgurl:
                  "http://jerma.net/Engi/icons/pro_favourite.png",
              title: FAVORITE,
              icon: Icons.favorite,
              route: () {


                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  HappyShopFavrite(scaffoldKey:widget.scaffoldKey,
                      appbar: false,
                     ),
                  ),
                );
              },
            ),
          ),
          _getDivider(),
          Visibility(
            visible: widget.sessionImp.status != sessionEnums.login,
            child: Consumer<SessionImplementation>(builder:(context ,sessionImp,child) {
              return HappyShopDrawerListTile(
              title: "LOGIN",
              icon: Icons.login,
              route: () async {
                login(context,sessionImp);

                /*
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HappyShopSplash(), //HappyShopLogin(),
                  ),
                );*/
              },
            );
  }),
          ),
          Visibility(
            visible: widget.sessionImp.status == sessionEnums.login,
            child: HappyShopDrawerListTile(
              title: "LOGOUT",
              icon: Icons.logout,
              route: () {
                logOut();
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
          ),
          _getDivider(),
          Visibility(
            visible: widget.sessionImp.status != sessionEnums.login,
            child: HappyShopDrawerListTile(
              title: "Sing Up",
              icon: Icons.person_add,
              route: () {
                register(context, widget.CustWoocommerceProvider);

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
          ),
          _getDivider(),
          HappyShopDrawerListTile(
            title: "Update",
            icon: Icons.download ,
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
        builder: (context) =>   HappyShopSplash(),
      ),
    );
  }

  Future login(context, SessionImplementation sessionImp) async {
    final user = await GoogleSignin.login();

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(duration: const Duration(seconds: 7),content: Text("SignIn Falied")));
    } else {
      widget.isExist=await sessionImp.initSession(user,  widget.CustWoocommerceProvider);
      if(widget.isExist==false) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: const Duration(seconds: 7),content: Text("Please Register..... ")));
        logOut();
        widget.register=true;
      }else{
        if(sessionImp.addressList.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(duration: const Duration(seconds: 7),content: Text("Please Add Address .....")));
          widget.haveAddress=false;
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(duration: const Duration(seconds: 5),content: Text("welcome Back .....")));
          widget.isExist=true;
          widget.haveAddress=true;
          widget.isLoggedIn=true;
          sessionImp.status=sessionEnums.login;
          setState(() {});
        }
      }
    }


    setState(() {

    });

    Navigator.pop(context);
  }


  Future logOut() async {
    widget.sessionImp.clear();
    // if(widget.isLoggedIn)
    await GoogleSignin.disconnect();
    widget.sessionImp.addressList.clear();
    widget.isExist=false;
    widget.haveAddress=false;

    setState(() {

    });
  }

  void register(BuildContext context, WoocommerceProvider custWoocommerceProvider)async {

    logOut();
    await registe_r(context,custWoocommerceProvider );
  }

  Future registe_r(context, WoocommerceProvider custWoocommerceProvider) async {
    // if(widget.isLoggedIn)
    await GoogleSignin.disconnect();

    final user = await GoogleSignin.login();
    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(duration: const Duration(seconds: 7),content: Text("Register Falied")));
    } else {

      showDialog(
        context: context,
        builder: (context) => AddressDialog(
          onSubmit: (address, city, state, phoneArea, country) async{
            bool isPhoneAreaValid = RegExp(r'^01\d{9}$').hasMatch(phoneArea);

            if (isPhoneAreaValid) {
            widget.isExist =
            await widget.sessionImp.register(user, custWoocommerceProvider,address, city, state, phoneArea, country);
            }else{
              callFaild('Invalid phone area. Please enter a valid number.',Colors.red);
              Navigator.of(context).pop();
             }
            if(widget.isExist) {
              setState(() {});
            }else{
              callFaild("Register Falid",Colors.red);
              await GoogleSignin.disconnect();
              Navigator.of(context).pop();
            }

          },
        ),
      );
    }
  }
  void callFaild(String message, MaterialColor backGroundColor) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(duration:const  Duration(seconds: 7,),backgroundColor:backGroundColor ,content: Text( message)));

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
            ? Image.network(
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
                Image.network(
                  'http://jerma.net/Engi/images/happyshopwhitelogo.png',
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
