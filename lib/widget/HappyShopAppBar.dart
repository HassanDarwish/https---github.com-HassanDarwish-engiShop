import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:GiorgiaShop/Screen/HappyShopCart.dart';
import 'package:GiorgiaShop/Screen/HappyShopProfile.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:GiorgiaShop/provider/Cart.dart';

class HappyShopAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<ScaffoldState>  privatescaffoldKey;
  const HappyShopAppBar({
    Key? key,
    required this.scaffoldKey, required GlobalKey<ScaffoldState> this.privatescaffoldKey,
  }) : super(key: key);

  @override
  State<HappyShopAppBar> createState() => _HappyShopAppBarState();


}

GetIt getIt = GetIt.instance;
class _HappyShopAppBarState extends State<HappyShopAppBar> {




  @override
  Widget build(BuildContext context) {

    return AppBar(
      key: widget.privatescaffoldKey,
      leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            widget.scaffoldKey.currentState!.openDrawer();
          }),
      //bottom: ,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            App_title,
            style: TextStyle(
              color: AppTitleColor.withOpacity(0.6),
              fontFamily: 'DancingScript',
              fontSize: 28,
              fontWeight: FontWeight.bold,
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
                color: const Color(0xFF333333)
                    .withOpacity(0.5),//IconThemeColor.withOpacity(0.5),
                size: 40,
              ),
            ),
            (Provider.of<CartImplementation>(context).getCart().isNotEmpty &&
                Provider.of<CartImplementation>(context).getCart() != "0")
             ?Positioned(
                    top: 0.0,
                    right: 5.0,
                    bottom: 15,
                    child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child:
                            Consumer<CartImplementation>(builder:(context ,cart,child) {
                              return Text(
                                '${cart.CUR_CART_COUNTT}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color:
                                    Colors.white),
                              );
                            },)
                            ,
                          ),
                        )),
                  )
                 : Container()
          ]),
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>   HappyShopCart(),
                ));
          },
        ),
        const SizedBox(
          width: 10.0,
        ),
        /*InkWell(
          child: Icon(
            Icons.account_circle,
            color: IconThemeColor.withOpacity(0.5),
            size: 36,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HappyShopPeofile(),
                ));
          },
        ),*/
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
