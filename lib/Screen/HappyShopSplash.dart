import 'dart:async';

import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:GiorgiaShop/getIt/config/APIConfig.dart';
import 'package:GiorgiaShop/getIt/woocommecre/API_Woocommerce.dart';
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
  void initState() {
    super.initState();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    // Replace this delay with the code to be executed during refresh.
    // and return a Future when code finishes execution.
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    // Reload the data.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Push the replacement route after the widget tree is complete.
      startTime(1000);
    });
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
          body: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: deviceWidth + 100,
                      height: deviceHeight + 100,
                      decoration: back(),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              width: 150.0,
                              fit: BoxFit.fill,
                              image: AssetImage('images/appstore.png'),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
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
                      width: deviceWidth + 100,
                      height: deviceHeight + 100,
                    ),
                  ],
                ),
              ))),
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

  startTime(int timeInMilli) async {
    var duration = Duration(milliseconds: timeInMilli);
    if (true == await getIt<API_Config>().isInternet()) {
      await getIt<API_Config>().getConfig();
      await getIt<API_Woocommerce>().getCategoriesByCount(8);
      await getIt<API_Woocommerce>().getCategories();

      //navigationPage();
      return Timer(duration, await navigationPage);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection'),
        ),
      );
    }
  }

  Future<void> navigationPage() async {
    /*Navigator.of(context)
        .pushNamed(HappyShopHome.routeName);*/

    Navigator.of(context).pushReplacementNamed(HappyShopHome.routeName);
    /*  Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>   HappyShopHome(), //HappyShopLogin(),
        ));
*/
  }
}
