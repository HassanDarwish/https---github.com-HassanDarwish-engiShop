import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Helper/HappyShopString.dart';

import 'HappyShopCheckout.dart';
import 'HappyShopHome.dart';
import 'HappyShopProductDetail.dart';

class HappyShopCart extends StatefulWidget {
  HappyShopCart({Key? key}) : super(key: key);

  @override
  _HappyShopCartState createState() => _HappyShopCartState();
}

class _HappyShopCartState extends State<HappyShopCart>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  List cartList = [
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
      'name': "Nike",
      'descprice': "2500",
      'price': "3500",
      'rating': "4.5",
      'noOfRating': "90",
      'qty': "1",
      'totle': '2500'
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/1573810839.322.jpeg",
      'name': "Bag",
      'descprice': "1000",
      'price': "1200",
      'rating': "2.5",
      'noOfRating': "50",
      'qty': "1",
      'totle': '1000'
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak3.jpg",
      'name': "Puma Shoes",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45",
      'qty': "1",
      'totle': '1300'
    },
    {
      'img':
          "https://smartkit.wrteam.in/smartkit/images/Plus-Size-52-Classic-Black-Men-s-Footwear-Comfortable-Ultra-Light-Shoes-Men-Shoes-No-Yeezie.jpg_640x640.jpg",
      'name': "NIkeShoes",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150",
      'qty': "1",
      'totle': '1700'
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg",
      'name': "Bag",
      'descprice': "2000",
      'price': "2200",
      'rating': "2.5",
      'noOfRating': "10",
      'qty': "1",
      'totle': '2000'
    },
  ];
  @override
  void initState() {
    super.initState();
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = new Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(new CurvedAnimation(
      parent: buttonController,
      curve: new Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  getAppBar(String title, BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: primary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: primary,
        ),
      ),
      //brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 5,
    );
  }

  _showContent() {
    return cartList.length == 0
        ? cartEmpty()
        : ScreenTypeLayout(
            mobile: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return listItem(index);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 28, bottom: 8.0, left: 35, right: 35),
                  child: Row(
                    children: <Widget>[
                      Text(
                        ORIGINAL_PRICE,
                      ),
                      Spacer(),
                      Text(CUR_CURRENCY + "8500")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        DELIVERY_CHARGE,
                      ),
                      Spacer(),
                      Text(CUR_CURRENCY + "150")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Text(
                        TAXPER + "(18%)",
                      ),
                      Spacer(),
                      Text(CUR_CURRENCY + "1530")
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 35, right: 35),
                  child: Row(
                    children: <Widget>[
                      Text(
                        TOTAL_PRICE,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        CUR_CURRENCY + "10180",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HappyShopCheckout(),
                      ),
                    );
                  },
                  child: Container(
                    height: 55,
                    decoration: back(),
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      PROCEED_CHECKOUT,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
            desktop: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: cartList.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return listItem(index);
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 28, bottom: 8.0, left: 35, right: 35),
                          child: Row(
                            children: <Widget>[
                              Text(
                                ORIGINAL_PRICE,
                              ),
                              Spacer(),
                              Text(CUR_CURRENCY + "8500")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35, right: 35, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                DELIVERY_CHARGE,
                              ),
                              Spacer(),
                              Text(CUR_CURRENCY + "150")
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 35, right: 35, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                TAXPER + "(18%)",
                              ),
                              Spacer(),
                              Text(CUR_CURRENCY + "1530")
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, left: 35, right: 35),
                          child: Row(
                            children: <Widget>[
                              Text(
                                TOTAL_PRICE,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                CUR_CURRENCY + "10180",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.white,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HappyShopCheckout(),
                              ),
                            );
                          },
                          child: Container(
                            height: 55,
                            decoration: back(),
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              PROCEED_CHECKOUT,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.white),
                            )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget listItem(int index) {
    return Card(
      elevation: 0.1,
      child: InkWell(
        child: Row(
          children: <Widget>[
            Hero(
                tag: "$index${cartList[index]}",
                child: CachedNetworkImage(
                  imageUrl: cartList[index]['img'],
                  height: 90.0,
                  width: 90.0,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              cartList[index]['name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 8),
                            child: Icon(
                              Icons.close,
                              size: 13,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              cartList.removeAt(index);
                            });
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Text(
                            " " + cartList[index]['rating'],
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Text(
                            " (" + cartList[index]['noOfRating'] + ")",
                            style: Theme.of(context).textTheme.overline,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          cartList[index]['price'],
                          style: Theme.of(context).textTheme.overline?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              letterSpacing: 0.7),
                        ),
                        Text(
                          cartList[index]['descprice'],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: 8, top: 8, bottom: 8),
                                child: Icon(
                                  Icons.remove,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              onTap: () {},
                            ),
                            Text(
                              cartList[index]['qty'],
                              style: Theme.of(context).textTheme.caption,
                            ),
                            InkWell(
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.add,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                              onTap: () {},
                            )
                          ],
                        ),
                        Spacer(),
                        Text(cartList[index]['totle'],
                            style: Theme.of(context).textTheme.headline6)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        splashColor: primary.withOpacity(0.2),
        onTap: () async {
          await Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              pageBuilder: (_, __, ___) => HappyShopProductDetail(
                imgurl: cartList[index]['img'],
                tag: "${cartList[index]}1",
              ),
            ),
          );
        },
      ),
    );
  }

  cartEmpty() {
    return Center(
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          noCartImage(context),
          noCartText(context),
          noCartDec(context),
          shopNow()
        ]),
      ),
    );
  }

  noCartImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://smartkit.wrteam.in/smartkit/images/empty_cart.png',
      fit: BoxFit.contain,
    );
  }

  noCartText(BuildContext context) {
    return Container(
        child: Text(NO_CART,
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(color: primary, fontWeight: FontWeight.normal)));
  }

  noCartDec(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: Text(CART_DESC,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: lightblack,
                fontWeight: FontWeight.normal,
              )),
    );
  }

  shopNow() {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: CupertinoButton(
        child: Container(
            width: deviceWidth * 0.7,
            height: 45,
            alignment: FractionalOffset.center,
            decoration: new BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryLight2, primaryLight3],
                  stops: [0, 1]),
              borderRadius: new BorderRadius.all(const Radius.circular(50.0)),
            ),
            child: Text(SHOP_NOW,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: white, fontWeight: FontWeight.normal))),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HappyShopHome()),
              ModalRoute.withName('/'));
        },
      ),
    );
  }

  back() {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryLight2, primaryLight3],
          stops: [0, 1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(CART, context),
      body: Stack(
        children: <Widget>[
          _showContent(),
        ],
      ),
    );
  }
}
