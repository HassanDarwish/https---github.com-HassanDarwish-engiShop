import 'dart:io';
import 'package:GiorgiaShop/pojo/Woo/WooProductCategory.dart';
import 'package:GiorgiaShop/provider/Session.dart';
import 'package:GiorgiaShop/provider/woocommerceProvider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'Helper/HappyShopColor.dart';
import 'Helper/HappyShopString.dart';
import 'Helper/MyHttpOverrides.dart';
import 'Screen/HappyShopCart.dart';
import 'Screen/HappyShopCatgories.dart';
import 'Screen/HappyShopCheckout.dart';
import 'Screen/HappyShopHome.dart';
import 'Screen/HappyShopSplash.dart';
import 'getIt/config/APIConfig.dart';
import 'getIt/woocommecre/APICustomWooCommerce.dart';
import 'getIt/woocommecre/API_Woocommerce.dart';
import 'provider/Cart.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

GetIt getIt = GetIt.instance;

loadRepository() async {
  getIt.registerSingleton<API_Config>(API_Config_Implementation(),
      signalsReady: true);
  getIt.isReady<API_Config>().then((_) => getIt<API_Config>());

  getIt.registerSingleton<API_Woocommerce>(API_Woocommerce_Implementation(),
      signalsReady: true);
  getIt.isReady<API_Woocommerce>().then((_) => getIt<API_Woocommerce>());

  getIt.registerSingleton<APICustomWooCommerce>(
      APICustomWooCommerce_Implementation(),
      signalsReady: true);
  getIt.isReady<APICustomWooCommerce>().then((_) =>
      getIt<APICustomWooCommerce>());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  HttpOverrides.global = MyHttpOverrides();
  await loadRepository();
  await _initFirebaseRemoteConfig();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartImplementation>(
          create: (context) => CartImplementation(config: getIt<API_Config>()),
        ),
        ChangeNotifierProvider<SessionImplementation>(
          create: (context) => SessionImplementation(),
        ),
        ChangeNotifierProvider<WoocommerceProvider>(
          create: (context) =>
              WoocommerceProvider(api_Woocommerce: getIt<API_Woocommerce>(),
                  api_CustomWoocommerce: getIt<APICustomWooCommerce>()),
        ),
      ],
      child: MaterialApp(
        home: HappyShopSplash(),
        title: App_title,
        theme: ThemeData(
          primarySwatch: primary_app,
          textTheme: const TextTheme(
              titleLarge: TextStyle(
                color: primary,
                fontWeight: FontWeight.w600,
              )),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: primary,
          ),
          fontFamily: 'Open sans',
        ),
        routes: {
          HappyShopHome.routeName: (context) => HappyShopHome(),
          HappyShopCatogeryAll.routeName: (context) => HappyShopCatogeryAll(),
          HappyShopCart.routeName: (context) => HappyShopCart(),
          HappyShopCheckout.routeName: (context) => HappyShopCheckout(),
        },
      ),
    ),
  );
}

Future<void> _initFirebaseRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: Duration.zero,
  ));
  await remoteConfig.fetchAndActivate();
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      home: HappyShopSplash(),
      title: App_title,
      theme: ThemeData(
        primarySwatch: primary_app,
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
            )),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primary,
        ),
        fontFamily: 'Open sans',
      ),
      routes: {
        HappyShopHome.routeName: (context) => HappyShopHome(),
        HappyShopCatogeryAll.routeName: (context) =>
        const HappyShopCatogeryAll(),
        HappyShopCart.routeName: (context) => HappyShopCart(),
        HappyShopCheckout.routeName: (context) => HappyShopCheckout(),
      },
    );
  }
}


// ... rest of your MyHomePage class ...