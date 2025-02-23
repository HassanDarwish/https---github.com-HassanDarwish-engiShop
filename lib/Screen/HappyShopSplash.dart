import 'dart:async';

import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:GiorgiaShop/getIt/config/APIConfig.dart';
import 'package:GiorgiaShop/getIt/woocommecre/API_Woocommerce.dart';
import 'package:GiorgiaShop/Helper/SSLLoder.dart';
import 'HappyShopHome.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:firebase_core/firebase_core.dart';
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
      checkForUpdates(context);
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





  Future<void> checkForUpdates(BuildContext context) async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  try {
  await remoteConfig.fetchAndActivate();

  final minimumAppVersionString = remoteConfig.getString('minimum_app_version');
  print("Remote Config minimum_app_version: $minimumAppVersionString");
  if (minimumAppVersionString.isNotEmpty) {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  print("PackageInfo version: ${packageInfo.version}");
  final currentVersion = Version.parse(packageInfo.version);
  final minimumVersion = Version.parse(minimumAppVersionString);

  if (currentVersion < minimumVersion) {
  _showUpdateDialog(context);
  }
  }
  } catch (e) {
  print("Remote config error: $e");
  }
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Available'),
          content: const Text(
            'A new version of the app is available. Please update to continue.\n\n'
                'If you don\'t see an "Update" button, please tap "Open" and the Play Store will show the option to update.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Update'),
              onPressed: () async {
                final Uri appStoreUrl = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.giorgia.giorgiashop&pli=1'); // Replace with your app's URL
                if (await canLaunchUrl(appStoreUrl)) {
                  await launchUrl(appStoreUrl, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $appStoreUrl';
                }
              },
            ),
          ],
        );
      },
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
      SSLLoader SSL=SSLLoader();
      await SSL.ConfigSSLLoader();
      await SSL.WooSSLLoader();
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
