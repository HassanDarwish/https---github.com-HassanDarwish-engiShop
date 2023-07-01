import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:smartkit/FullApp/HappyShop/Helper/HappyShopColor.dart';

import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Screen/HappyShopHome.dart';
import 'package:engishop/Screen/HappyShopSplash.dart';

class HappyShopMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Happy Shop",
      theme: ThemeData(
          primarySwatch: primary_app,
          textSelectionTheme: TextSelectionThemeData(cursorColor: primary),
          fontFamily: 'Open sans',
          textTheme: TextTheme(
              headline6: TextStyle(
            color: primary,
            fontWeight: FontWeight.w600,
          ))),
      debugShowCheckedModeBanner: false,
      //home: HappyShopHome(),
      home: HappyShopSplash(),
    );
  }
}
