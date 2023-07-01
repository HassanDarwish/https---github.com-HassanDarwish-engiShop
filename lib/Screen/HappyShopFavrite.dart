import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Helper/HappyShopString.dart';

import 'HappyShopHome.dart';
import 'HappyShopProductDetail.dart';

class HappyShopFavrite extends StatefulWidget {
  final bool? appbar;
  HappyShopFavrite({Key? key, this.appbar}) : super(key: key);

  @override
  _HappyShopFavriteState createState() => _HappyShopFavriteState();
}

class _HappyShopFavriteState extends State<HappyShopFavrite>
    with TickerProviderStateMixin {
  ScrollController controller = new ScrollController();
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

  _showContent() {
    return favList.length == 0
        ? Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: Center(child: Text(msg)),
          )
        : ScreenTypeLayout(
            mobile: ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: favList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                print(
                    "load more****$offset***$total***${favList.length}***$isLoadingmore**$index");
                return listItem(index);
              },
            ),
            desktop: GridView.count(
              padding: EdgeInsets.only(top: 5),
              crossAxisCount: 4,
              shrinkWrap: true,
              childAspectRatio: 4,
              physics: NeverScrollableScrollPhysics(),
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
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 12,
                          ),
                          Text(
                            " " + favList[index]['rating'],
                            style: Theme.of(context).textTheme.overline,
                          ),
                          Text(
                            " (" + favList[index]['noOfRating'] + ")",
                            style: Theme.of(context).textTheme.overline,
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
                              favList[index]['cartCount'],
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
                        Row(
                          children: <Widget>[
                            Text(
                              favList[index]['descprice'],
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      letterSpacing: 0.7),
                            ),
                            Text(favList[index]['price'],
                                style: Theme.of(context).textTheme.headline6),
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
        splashColor: primary.withOpacity(0.2),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 1),
                pageBuilder: (_, __, ___) => HappyShopProductDetail(
                      imgurl: favList[index]['img'],
                      tag: "${favList[index]}1",
                    )),
          );
        },
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
            builder: (context) => HappyShopHome(),
          ),
        );
        if (result == null) {
          result = false;
        }
        return result;
      },
      child: Scaffold(
        appBar: widget.appbar == true
            ? AppBar(
                title: Text(
                  "Favrite",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : PreferredSize(preferredSize: Size.fromHeight(0), child: AppBar()),
        body: Stack(
          children: <Widget>[
            _showContent(),
          ],
        ),
      ),
    );
  }
}
