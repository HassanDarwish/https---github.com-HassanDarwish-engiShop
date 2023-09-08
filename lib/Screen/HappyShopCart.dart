import 'dart:math';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';

import 'package:GiorgiaShop/pojo/products.dart';
import 'package:GiorgiaShop/provider/Cart.dart';
import 'HappyShopCheckout.dart';
import 'HappyShopHome.dart';
import 'HappyShopProductDetail.dart';
import 'package:GiorgiaShop/getIt/config/APIConfig.dart';
import 'package:get_it/get_it.dart';
GetIt getIt = GetIt.instance;
class HappyShopCart extends StatefulWidget {
  static const routeName = '/HappyShopCart';
  late final provider;
    HappyShopCart({Key? key}) : super(key: key);

  @override
  _HappyShopCartState createState() => _HappyShopCartState();
}

class _HappyShopCartState extends State<HappyShopCart>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
  // Initialize the provider
      widget.provider = Provider.of<CartImplementation>(context, listen: false);

    buttonSqueezeanimation = Tween(
      begin: deviceWidth * 0.7,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController,
      curve: const Interval(
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

  Future<void> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  getAppBar(String title, BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: primary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: primary,
        ),
      ),
      //brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 5,
    );
  }

  _showContent(List<product> products) {
    return products.isEmpty
        ? cartEmpty()
        : ScreenTypeLayout(
            mobile: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    physics: const BouncingScrollPhysics(),
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
                      const Text(
                        ORIGINAL_PRICE,
                      ),
                      const Spacer(),
                      Text("${ECUR_CURRENCY}"+widget.provider.cartTotalPrice)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      const Text(
                        DELIVERY_CHARGE,
                      ),
                      const Spacer(),
                      Text("${ECUR_CURRENCY} "+getIt<API_Config>().config.deliveryFees)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 35, right: 35, top: 8, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      for (var tax in  getIt<API_Config>().config.tax)
                        Text(
                        "$TAXPER(${tax.toString()} %) ",
                      ),
                      const Spacer(),
                      Text("${ECUR_CURRENCY}"+widget.provider.totalTax)
                    ],
                  ),
                ),
                const Divider(
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
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        "${ECUR_CURRENCY}"+widget.provider.cartFinalPrice,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
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
                        builder: (context) =>   HappyShopCheckout(),
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
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),

          );
  }
  Widget listItem(int index) {
    return Card(
      elevation: 0.1,
      child: InkWell(
        splashColor: primary.withOpacity(0.2),
        onTap: () async {
          await Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (_, __, ___) => HappyShopProductDetail(
                id: widget.provider.products.elementAt(index).id.toString(),
                imgurl:widget.provider.products.elementAt(index).img,
                description: widget.provider.products.elementAt(index).description,
                price: widget.provider.products.elementAt(index).price,
                rating: widget.provider.products.elementAt(index).rating,
                shortdescription: widget.provider.products.elementAt(index).short_description,
                title: widget.provider.products.elementAt(index).name,
                review: widget.provider.products.elementAt(index).review,
                user_rating:widget.provider.products.elementAt(index).user_rating ,
                tag: widget.provider.products.elementAt(index).id.toString(),
                attributess: widget.provider.products.elementAt(index).attributes,
              ),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Hero(
                tag:widget.provider.products.elementAt(index).id.toString(),
                child: CachedNetworkImage(
                  imageUrl: widget.provider.products.elementAt(index).img,
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
                              widget.provider.products.elementAt(index).name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        InkWell(
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 8),
                            child: Icon(
                              Icons.close,
                              size: 13,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              widget.provider.remove_from_itemMap(1,widget.provider.products.elementAt(index).id,index,widget.provider.products.elementAt(index).price);

                            });
                          },
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Text(
                              Random().nextInt(100).toString(),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                              Random().nextInt(100).toString(),
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          widget.provider.products.elementAt(index).price,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              letterSpacing: 0.7),
                        ),
                        Expanded(
                          child: Text(
                              widget.provider.products.elementAt(index).short_description
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 8, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5))),
                                child: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {
                              widget.provider.remove_from_itemMap(0,widget.provider.products.elementAt(index).id,index,widget.provider.products.elementAt(index).price);
                              },
                            ),
                              Text(
                                  widget.provider.itemMap[widget.provider
                                      .products
                                      .elementAt(index)
                                      .id].toString(),
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium,
                                )


                             ,

                            InkWell(
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5))),
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {

                                widget.provider.addToCart(
                                    1, widget.provider.products.elementAt(index).short_description, widget.provider.products.elementAt(index).description, widget.provider.products.elementAt(index).price, widget.provider.products.elementAt(index).name, widget.provider.products.elementAt(index).id
                                    , widget.provider.products.elementAt(index).img, widget.provider.products.elementAt(index).tag,1,widget.provider.products.elementAt(index).attributes,
                                      widget.provider.products.elementAt(index).SelectedAttribute);


                              },
                            )
                          ],
                        ),
                        const Spacer(),
                        Text( 'Total Price is '+ widget.provider.itemTotalPriceMap[widget.provider
                            .products
                            .elementAt(index)
                            .id].toString() ,
                            style: TextStyle(color: primaryLight,fontSize: 16))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
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
                .headlineSmall
                ?.copyWith(color: primary, fontWeight: FontWeight.normal)));
  }

  noCartDec(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: Text(CART_DESC,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [primaryLight2, primaryLight3],
                  stops: [0, 1]),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Text(SHOP_NOW,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: white, fontWeight: FontWeight.normal))),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HappyShopHome()),
              ModalRoute.withName('/'));
        },
      ),
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



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: getAppBar(CART, context),
      body: Stack(
        children: <Widget>[
      Consumer<CartImplementation>(builder:(context ,cart,child) {
           return _showContent(widget.provider.products);
          })
        ],
      ),
    );
  }
}
