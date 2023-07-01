import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:engishop/Helper/SmartKitColor.dart';
//import 'package:engi_shop/SmartkitScreen/Widget/theme.dart';

class HomeLogo extends StatelessWidget {
  const HomeLogo({
    Key? key,
    required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(color: smarKitcolor2, boxShadow: [
          BoxShadow(
            color: Colors.grey[350]!,
            offset: Offset(0.0, 1.5),
            blurRadius: 1.0,
          ),
        ]),
        height: 70.0,
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:
                    // Consumer<ThemeNotifier>(
                    //   builder: (context, notifier, child) => notifier.darkTheme != true
                    //       ?
                    SvgPicture.network(
                  'https://smartkit.wrteam.in/smartkit/images/homelogo.svg',
                  height: width / 7.5,
                )
                // : SvgPicture.network(
                //     'https://smartkit.wrteam.in/smartkit/images/homelogo.svg',
                //     height: width / 7.5,
                //     color: Colors.white,
                //   ),
                // ),
                ),
            // Consumer<ThemeNotifier>(
            //   builder: (context, notifier, child) => Switch(
            //     activeColor: Theme.of(context).primaryColor,
            //     onChanged: (val) {
            //       notifier.toggleTheme();
            //       print("=====");
            //       // var _darkTheme = _prefs.getBool(key) ?? true;
            //       print('_DARKTHEME: ${notifier.darkTheme}');
            //     },
            //     value: notifier.darkTheme,
            //   ),
            // ),
          ],
        ),
      ),
      tablet: Container(
          alignment: Alignment.centerLeft,
          // margin: EdgeInsets.only(top: 24),
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), boxShadow: [
            BoxShadow(
              color: Colors.grey[350]!,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.0,
            ),
          ]),
          // height: 100.0,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              // 'https://smartkit.wrteam.in/smartkit/images/homelogo.svg',
              'assets/homelogo.svg',
              height: width / 14,
            ),
          )),
      desktop: Container(
          alignment: Alignment.centerLeft,
          // margin: EdgeInsets.only(top: 24),
          decoration: BoxDecoration(color: Color(0xFFFFFFFF), boxShadow: [
            BoxShadow(
              color: Colors.grey[350]!,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.0,
            ),
          ]),
          // height: 100.0,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset(
              // 'https://smartkit.wrteam.in/smartkit/images/homelogo.svg',
              'assets/homelogo.svg',
              height: width / 14,
            ),
          )),
    );
  }
}
