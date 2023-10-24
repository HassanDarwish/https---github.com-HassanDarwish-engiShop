import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';

import 'HappyShopHome.dart';
import 'HappyShopProductDetail.dart';

class HappyShopFavrite extends StatefulWidget {
  final bool? appbar;
  const HappyShopFavrite({Key? key, this.appbar}) : super(key: key);

  @override
  _HappyShopFavriteState createState() => _HappyShopFavriteState();
}

class _HappyShopFavriteState extends State<HappyShopFavrite>
    with TickerProviderStateMixin {
  ScrollController controller = ScrollController();
  List tempList = [];
  String msg = noFav;
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;
  int offset = 0;
  int total = 0;
  bool isLoadingmore = true;
  List favList = [
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
      'name': "Nike",
      'cartCount': "1",
      'descprice': "2500",
      'price': "3500",
      'rating': "4.5",
      'noOfRating': "90"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/1573810839.322.jpeg",
      'name': "Bag",
      'cartCount': "1",
      'descprice': "1000",
      'price': "1200",
      'rating': "2.5",
      'noOfRating': "50"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak3.jpg",
      'name': "Puma Shoes",
      'cartCount': "1",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img':
          "https://smartkit.wrteam.in/smartkit/images/Plus-Size-52-Classic-Black-Men-s-Footwear-Comfortable-Ultra-Light-Shoes-Men-Shoes-No-Yeezie.jpg_640x640.jpg",
      'name': "NIkeShoes",
      'cartCount': "1",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg",
      'name': "Bag",
      'cartCount': "1",
      'descprice': "",
      'price': "2200",
      'rating': "2.5",
      'noOfRating': "10"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
      'name': "Nike",
      'cartCount': "1",
      'descprice': "2500",
      'price': "3500",
      'rating': "4.5",
      'noOfRating': "90"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/1573810839.322.jpeg",
      'name': "Bag",
      'cartCount': "1",
      'descprice': "1000",
      'price': "1200",
      'rating': "2.5",
      'noOfRating': "50"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak3.jpg",
      'name': "Puma Shoes",
      'cartCount': "1",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img':
          "https://smartkit.wrteam.in/smartkit/images/Plus-Size-52-Classic-Black-Men-s-Footwear-Comfortable-Ultra-Light-Shoes-Men-Shoes-No-Yeezie.jpg_640x640.jpg",
      'name': "NIkeShoes",
      'cartCount': "1",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg",
      'name': "Bag",
      'cartCount': "1",
      'descprice': "",
      'price': "2200",
      'rating': "2.5",
      'noOfRating': "10"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
      'name': "Nike",
      'cartCount': "1",
      'descprice': "2500",
      'price': "3500",
      'rating': "4.5",
      'noOfRating': "90"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/1573810839.322.jpeg",
      'name': "Bag",
      'cartCount': "1",
      'descprice': "1000",
      'price': "1200",
      'rating': "2.5",
      'noOfRating': "50"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak3.jpg",
      'name': "Puma Shoes",
      'cartCount': "1",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img':
          "https://smartkit.wrteam.in/smartkit/images/Plus-Size-52-Classic-Black-Men-s-Footwear-Comfortable-Ultra-Light-Shoes-Men-Shoes-No-Yeezie.jpg_640x640.jpg",
      'name': "NIkeShoes",
      'cartCount': "1",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg",
      'name': "Bag",
      'cartCount': "1",
      'descprice': "",
      'price': "2200",
      'rating': "2.5",
      'noOfRating': "10"
    },
  ];

  @override
  void initState() {
    super.initState();

    offset = 0;
    total = 0;

    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

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

  _showContent() {
    return favList.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: Center(child: Text(msg)),
          )
        : ScreenTypeLayout(
            mobile: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: favList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                 return listItem(index);
              },
            ),
            desktop: GridView.count(
              padding: const EdgeInsets.only(top: 5),
              crossAxisCount: 4,
              shrinkWrap: true,
              childAspectRatio: 4,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                15,
                (index) {
                  return listItem(index);
                },
              ),
            ),
          );
  }

  Widget listItem(int index) {
    return Card(
      elevation: 0.1,
      shadowColor: happyshopcolor5,
      child: InkWell(
        splashColor: primary.withOpacity(0.2),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(seconds: 1),
                pageBuilder: (_, __, ___) => HappyShopProductDetail(
                      id:"widget.id",
                      imgurl: favList[index]['img'],
                      tag: "${favList[index]}1",
                    )),
          );
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
                tag: "$index${favList[index]}",
                child: CachedNetworkImage(
                  imageUrl: favList[index]['img'],
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
                              favList[index]['name'],
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
                              favList.removeAt(index);
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
                            " " + favList[index]['rating'],
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            "${" (" + favList[index]['noOfRating']})",
                            style: Theme.of(context).textTheme.labelSmall,
                          )
                        ],
                      ),
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
                                  size: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {},
                            ),
                            Text(
                              favList[index]['cartCount'],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            InkWell(
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5))),
                                child: const Icon(
                                  Icons.add,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              onTap: () {},
                            )
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: <Widget>[
                            Text(
                              favList[index]['descprice'],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      letterSpacing: 0.7),
                            ),
                            Text(favList[index]['price'],
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        )
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? result = await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HappyShopHome(),
          ),
        );
        result ??= false;
        return result;
      },
      child: Scaffold(
        appBar: widget.appbar == true
            ? AppBar(
                title: const Text(
                  "Favrite",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : PreferredSize(preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: Stack(
          children: <Widget>[
            _showContent(),
          ],
        ),
      ),
    );
  }
}
