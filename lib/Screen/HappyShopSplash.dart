import 'dart:async';

import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import '../getIt/config/APIConfig.dart';

import '../getIt/woocommecre/API_Woocommerce.dart';
import 'HappyShopHome.dart';
GetIt getIt = GetIt.instance;

class HappyShopSplash extends StatefulWidget {

    HappyShopSplash({
    Key? key,
  }) : super(key: key);

  @override
  State<HappyShopSplash> createState() => _HappyShopSplashState();
}

class _HappyShopSplashState extends State<HappyShopSplash> {
  // GetIt getIt = GetIt.instance;
  @override
  void initState()   {
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
            builder: (context) => MyHomePage(title: 'Giorgia Shop'),
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
                      'http://jerma.net/Engi/images/happyshopwhitelogo.svg',
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
                          fontFamily: 'DancingScript',
                          fontWeight: FontWeight.w700,
                          fontSize: 28),
                    )
                  ],
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: 'http://jerma.net/Engi/images/doodle.png',
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
    var duration = const Duration(milliseconds: 400);
    if(true==await getIt<API_Config>().isInternet()) {
      await getIt<API_Config>().getConfig();
      await getIt<API_Woocommerce>().getCategoriesByCount(8);
      await getIt<API_Woocommerce>().getCategories();

    return Timer(duration, navigationPage);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection'),
        ),
      );
    }
  }

  Future<void> navigationPage() async {

    Navigator.of(context)
        .pushNamed(HappyShopHome.routeName);

    /* Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HappyShopHome(), //HappyShopLogin(),
        )); */
  }
}
