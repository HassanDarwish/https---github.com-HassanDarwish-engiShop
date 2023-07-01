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

class HappyShopSplash extends StatefulWidget {
  const HappyShopSplash({
    Key? key,
  }) : super(key: key);

  @override
  State<HappyShopSplash> createState() => _HappyShopSplashState();
}

class _HappyShopSplashState extends State<HappyShopSplash> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        /* bool result = await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Engi Shop'),
          ),
        );
        if (result == null) result = false;*/

        //return result;
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: back(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.network(
                      'https://smartkit.wrteam.in/smartkit/images/happyshopwhitelogo.svg',
                      width: 150.0,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      App_title,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'open sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 28),
                    )
                  ],
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: 'https://smartkit.wrteam.in/smartkit/images/doodle.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ],
        ),
      ),
    );
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

  startTime() async {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HappyShopLogin(),
        ));
  }
}
