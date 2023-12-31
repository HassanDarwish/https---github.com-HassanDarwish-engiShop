import 'package:flutter/material.dart';
import 'package:engishop/Helper/HappyShopString.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Screen/HappyShopCart.dart';
import 'package:engishop/Screen/HappyShopProfile.dart';

class HappyShopAppBar extends StatefulWidget {
  const HappyShopAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HappyShopAppBar> createState() => _HappyShopAppBarState();
}

class _HappyShopAppBarState extends State<HappyShopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            print("Leading clicked");
          }),
      //bottom: ,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            App_title,
            style: TextStyle(
              color: AppTitleColor.withOpacity(0.6),
              fontFamily: 'Open sans',
            ),
          )
        ],
      ),
      centerTitle: true,
      // brightness: Brightness.light,
      iconTheme: IconThemeData(color: IconThemeColor.withOpacity(0.5)),
      actions: <Widget>[
        InkWell(
          child: Stack(children: <Widget>[
            Center(
              child: Icon(
                Icons.shopping_cart_rounded,
                color: IconThemeColor.withOpacity(0.5),
                size: 26,
              ),
            ),
            (CUR_CART_COUNT != null &&
                    CUR_CART_COUNT.isNotEmpty &&
                    CUR_CART_COUNT != "0")
                ? Positioned(
                    top: 0.0,
                    right: 5.0,
                    bottom: 15,
                    child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              CUR_CART_COUNT,
                              style: const TextStyle(fontSize: 8),
                            ),
                          ),
                        )),
                  )
                : Container()
          ]),
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopCart(),
                ));
          },
        ),
        const SizedBox(
          width: 10.0,
        ),
        InkWell(
          child: Icon(
            Icons.account_circle,
            color: IconThemeColor.withOpacity(0.5),
            size: 26,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HappyShopPeofile(),
                ));
          },
        ),
        const SizedBox(
          width: 10.0,
        ),
      ],
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          // gradient: happyshopgradient
        ),
      ),
      elevation: 2.0,
    );
  }
}
