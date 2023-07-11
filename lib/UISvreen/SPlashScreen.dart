import 'package:flutter/material.dart';

import '../Helper/HappyShopColor.dart';
import '../Helper/HappyShopString.dart';
import 'package:GiorgiaShop/Screen/HappyShopSplash.dart';

class SPlashScreen extends StatefulWidget {
  final String titlee;

  const SPlashScreen({Key? key, required this.titlee}) : super(key: key);

  @override
  State<SPlashScreen> createState() => _SPlashScreenState();
}

class _SPlashScreenState extends State<SPlashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HappyShopSplash(),
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
    );
  }
}
