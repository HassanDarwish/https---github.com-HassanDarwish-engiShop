import 'package:flutter/material.dart';
//import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopColor.dart';

import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Screen/HappyShopSplash.dart';

class HappyShopMain extends StatelessWidget {
  const HappyShopMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Happy Shop",
      theme: ThemeData(
          primarySwatch: primary_app,
          textSelectionTheme: const TextSelectionThemeData(cursorColor: primary),
          fontFamily: 'Open sans',
          textTheme: const TextTheme(
              titleLarge: TextStyle(
            color: primary,
            fontWeight: FontWeight.w600,
          ))),
      debugShowCheckedModeBanner: false,
      //home: HappyShopHome(),
      home: const HappyShopSplash(),
    );
  }
}
