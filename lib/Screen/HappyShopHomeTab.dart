import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Helper/HappyShopString.dart';
import 'package:engishop/Screen/HappyShopCatgories.dart';
import 'package:engishop/Screen/HappyShopProductDetail.dart';
//import 'package:engi_shop/HappyShop/desktop/hometabdesktop.dart';
import 'package:engishop/Screen/SmartKitHome.dart';
import 'package:engishop/Screen/Image_Slider.dart';

import 'HappyShopStaggeredList.dart';

List sectList = [
  {
    'section': "Offers on men's Fashion",
    'style': "default",
    'productList': [
      {
        'tag': "1",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_a.png",
        'name': "Printed Men Round Neck Maroon T-Shirt",
        'descprice': "2500",
        'price': "3500",
        'rating': "4.5",
        'noOfRating': "90"
      },
      {
        'tag': "2",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_b.png",
        'name': "Printed Men Round Neck Yellow, Black T-Shirt",
        'descprice': "1000",
        'price': "1200",
        'rating': "2.5",
        'noOfRating': "50"
      },
      {
        'tag': "3",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_c.png",
        'name': "Solid Men Round Neck Grey T-Shirt",
        'descprice': "1300",
        'price': "1400",
        'rating': "3.5",
        'noOfRating': "45"
      },
      {
        'tag': "4",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_d.png",
        'name': "Men Regular Fit Solid Casual Shirt",
        'descprice': "1700",
        'price': "2000",
        'rating': "4.5",
        'noOfRating': "150"
      },
      {
        'tag': "1",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_a.png",
        'name': "Printed Men Round Neck Maroon T-Shirt",
        'descprice': "2500",
        'price': "3500",
        'rating': "4.5",
        'noOfRating': "90"
      },
      {
        'tag': "2",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_b.png",
        'name': "Printed Men Round Neck Yellow, Black T-Shirt",
        'descprice': "1000",
        'price': "1200",
        'rating': "2.5",
        'noOfRating': "50"
      },
      {
        'tag': "3",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_c.png",
        'name': "Solid Men Round Neck Grey T-Shirt",
        'descprice': "1300",
        'price': "1400",
        'rating': "3.5",
        'noOfRating': "45"
      },
      {
        'tag': "4",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_d.png",
        'name': "Men Regular Fit Solid Casual Shirt",
        'descprice': "1700",
        'price': "2000",
        'rating': "4.5",
        'noOfRating': "150"
      },
    ]
  },
  {
    'section': "Walk in Style",
    'style': "style_1",
    'productList': [
      {
        'tag': "5",
        'img':
            "https://smartkit.wrteam.in/smartkit/happyshop/collections_a.png",
        'name': "Nike",
        'descprice': "2500",
        'price': "3500",
        'rating': "4.5",
        'noOfRating': "90"
      },
      {
        'tag': "6",
        'img':
            "https://smartkit.wrteam.in/smartkit/happyshop/collections_b.png",
        'name': "Bag",
        'descprice': "1000",
        'price': "1200",
        'rating': "2.5",
        'noOfRating': "50"
      },
      {
        'tag': "7",
        'img':
            "https://smartkit.wrteam.in/smartkit/happyshop/collections_c.png",
        'name': "Puma Shoes",
        'descprice': "1300",
        'price': "1400",
        'rating': "3.5",
        'noOfRating': "45"
      },
      {
        'tag': "8",
        'img':
            "https://smartkit.wrteam.in/smartkit/happyshop/collections_d.png",
        'name': "NIkeShoes",
        'descprice': "1700",
        'price': "2000",
        'rating': "4.5",
        'noOfRating': "150"
      },
    ]
  },
  {
    'section': "Women's Fashion",
    'style': "style_2",
    'productList': [
      {
        'tag': "9",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_a.png",
        'name': "Casual Roll-up Sleeve Solid Women Top",
        'descprice': "2500",
        'price': "3500",
        'rating': "4.5",
        'noOfRating': "90"
      },
      {
        'tag': "10",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_b.png",
        'name': "Casual Sleeveless Solid Women Top",
        'descprice': "1000",
        'price': "1200",
        'rating': "2.5",
        'noOfRating': "50"
      },
      {
        'tag': "11",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_c.png",
        'name': "Casual 3/4 Sleeve Solid Women Maroon Top",
        'descprice': "1300",
        'price': "1400",
        'rating': "3.5",
        'noOfRating': "45"
      },
      {
        'tag': "12",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_d.png",
        'name': "Casual Petal Sleeve Solid Women Yellow Top",
        'descprice': "1700",
        'price': "2000",
        'rating': "4.5",
        'noOfRating': "150"
      },
    ]
  },
  {
    'section': "Top Brands",
    'style': "style_3",
    'productList': [
      {
        'tag': "13",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_1.png",
        'name': "Nike",
      },
      {
        'tag': "14",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_2.png",
        'name': "Reebok",
      },
      {
        'tag': "15",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_3.png",
        'name': "Tommy Hilfiger",
      },
      {
        'tag': "16",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_4.png",
        'name': "Levi's",
      },
      {
        'tag': "17",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_5.png",
        'name': "U.S.Polo",
      },
      {
        'tag': "18",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_6.png",
        'name': "Fila",
      },
      {
        'tag': "19",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_7.png",
        'name': "Vans",
      },
      {
        'tag': "20",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_8.png",
        'name': "Polo",
      },
      {
        'tag': "21",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_9.png",
        'name': "Calvin Klein",
      },
      {
        'tag': "22",
        'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_10.png",
        'name': "Superdry",
      },
    ]
  },
];

// List sectList = [
//   {
//     'section': "Offers on men's Fashion",
//     'style': "default",
//     'productList': [
//       {'tag': "1", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_a.png", 'name': "Printed Men Round Neck Maroon T-Shirt", 'descprice': "2500", 'price': "3500", 'rating': "4.5", 'noOfRating': "90"},
//       {'tag': "2", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_b.png", 'name': "Printed Men Round Neck Yellow, Black T-Shirt", 'descprice': "1000", 'price': "1200", 'rating': "2.5", 'noOfRating': "50"},
//       {'tag': "3", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_c.png", 'name': "Solid Men Round Neck Grey T-Shirt", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
//       {'tag': "4", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_d.png", 'name': "Men Regular Fit Solid Casual Shirt", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
//     ]
//   },
//   {
//     'section': "Walk in Style",
//     'style': "style_1",
//     'productList': [
//       {'tag': "5", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_a.png", 'name': "Nike", 'descprice': "2500", 'price': "3500", 'rating': "4.5", 'noOfRating': "90"},
//       {'tag': "6", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_b.png", 'name': "Bag", 'descprice': "1000", 'price': "1200", 'rating': "2.5", 'noOfRating': "50"},
//       {'tag': "7", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_c.png", 'name': "Puma Shoes", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
//       {'tag': "8", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_d.png", 'name': "NIkeShoes", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
//     ]
//   },
//   {
//     'section': "Women's Fashion",
//     'style': "style_2",
//     'productList': [
//       {'tag': "9", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_a.png", 'name': "Casual Roll-up Sleeve Solid Women Top", 'descprice': "2500", 'price': "3500", 'rating': "4.5", 'noOfRating': "90"},
//       {'tag': "10", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_b.png", 'name': "Casual Sleeveless Solid Women Top", 'descprice': "1000", 'price': "1200", 'rating': "2.5", 'noOfRating': "50"},
//       {'tag': "11", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_c.png", 'name': "Casual 3/4 Sleeve Solid Women Maroon Top", 'descprice': "1300", 'price': "1400", 'rating': "3.5", 'noOfRating': "45"},
//       {'tag': "12", 'img': "https://smartkit.wrteam.in/smartkit/happyshop/woman_d.png", 'name': "Casual Petal Sleeve Solid Women Yellow Top", 'descprice': "1700", 'price': "2000", 'rating': "4.5", 'noOfRating': "150"},
//     ]
//   },
//   {
//     'section': "Top Brands",
//     'style': "style_3",
//     'productList': [
//       {
//         'tag': "13",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_1.png",
//         'name': "Nike",
//       },
//       {
//         'tag': "14",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_2.png",
//         'name': "Reebok",
//       },
//       {
//         'tag': "15",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_3.png",
//         'name': "Tommy Hilfiger",
//       },
//       {
//         'tag': "16",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_4.png",
//         'name': "Levi's",
//       },
//       {
//         'tag': "17",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_5.png",
//         'name': "U.S.Polo",
//       },
//       {
//         'tag': "18",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_6.png",
//         'name': "Fila",
//       },
//       {
//         'tag': "19",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_7.png",
//         'name': "Vans",
//       },
//       {
//         'tag': "20",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_8.png",
//         'name': "Polo",
//       },
//       {
//         'tag': "21",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_9.png",
//         'name': "Calvin Klein",
//       },
//       {
//         'tag': "22",
//         'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_10.png",
//         'name': "Superdry",
//       },
//     ]
//   },
// ];

class HappyShopHpmeTab extends StatefulWidget {
  HappyShopHpmeTab({Key? key}) : super(key: key);

  @override
  _HappyShopHpmeTabState createState() => _HappyShopHpmeTabState();
}

class _HappyShopHpmeTabState extends State<HappyShopHpmeTab>
    with TickerProviderStateMixin {
  List catList = [
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/cat_1.png",
      'title': "Men's"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/cat_2.png",
      'title': "women's"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/cat_3.png",
      'title': "Man's Shoes"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/cat_4.png",
      'title': "Eyewear"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/cat_5.png",
      'title': "women's Shoes"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/cat_6.png",
      'title': "Bag's"
    },
  ];

  final _controller = PageController();

  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  @override
  void initState() {
    super.initState();
    buttonController = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    WidgetsBinding.instance?.addPostFrameCallback((_) => _animateSlider());
  }

  @override
  void dispose() {
    buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? result = await Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (Route<dynamic> route) => false);
        if (result == null) {
          result = false;
        }
        return result;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        bottom: 0,
                        top: kToolbarHeight * 1.4,
                        right: 0,
                        left: 0),
                    child: CarouselWithIndicator()),
                Column(
                  children: [
                    // category //
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            category,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                seeAll,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HappyShopCatogeryAll()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: catList.length < 10 ? catList.length : 10,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: new ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: new CachedNetworkImage(
                                        imageUrl: catList[index]['img'],
                                        height: 50.0,
                                        width: 50.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      catList[index]['title'],
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    width: 50,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration: Duration(seconds: 1),
                                    pageBuilder: (_, __, ___) =>
                                        HappyShopStaggeredList()),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    // Most popular //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: _getHeading("Most popular"),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ScreenTypeLayout(
                        mobile: Container(
                          child: GridView.count(
                              padding: EdgeInsets.only(top: 5),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 0.7,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                4,
                                (index) {
                                  return ItemCard(
                                    tag: "${index}2",
                                    imagurl: sectList[0]['productList'][index]
                                        ['img'],
                                    itemname: sectList[0]['productList'][index]
                                        ['name'],
                                    descprice: sectList[0]['productList'][index]
                                        ['descprice'],
                                    price: sectList[0]['productList'][index]
                                        ['price'],
                                    rating: sectList[0]['productList'][index]
                                        ['rating'],
                                    shadow: false,
                                  );
                                },
                              )),
                        ),
                        /*  desktop: MostpopularGridDesktop(
                          widget: GridView.count(
                              padding: EdgeInsets.only(top: 5),
                              crossAxisCount: 4,
                              shrinkWrap: true,
                              childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.width,
                              // mainAxisSpacing: 10.0,
                              // crossAxisSpacing: 10.0,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                8,
                                (index) {
                                  return ItemCard(
                                    tag: "${index}2",
                                    imagurl: sectList[0]['productList'][index]['img'],
                                    itemname: sectList[0]['productList'][index]['name'],
                                    descprice: sectList[0]['productList'][index]['descprice'],
                                    price: sectList[0]['productList'][index]['price'],
                                    rating: sectList[0]['productList'][index]['rating'],
                                    shadow: false,
                                  );
                                },
                              )),
                        ),*/
                      ),
                    ),

                    // New arrival for men's //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: _getHeading("Top Brands"),
                    ),

                    Container(
                      height: MediaQuery.of(context).size.width / 3.4,
                      child: ListView.builder(
                        itemCount: sectList[3]['productList'].length,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.only(
                                left: index == 0 ? 15.0 : 5.0,
                                right: index == 9 ? 15.0 : 0.0),
                            elevation: 0.0,
                            child: InkWell(
                              child: Container(
                                height: MediaQuery.of(context).size.width / 3.5,
                                width: MediaQuery.of(context).size.width / 4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.overlay),
                                      image: CachedNetworkImageProvider(
                                        sectList[3]['productList'][index]
                                            ['img'],
                                      ),
                                      fit: BoxFit.fill,
                                    )),
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    sectList[3]['productList'][index]['name'],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'bold',
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1)),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 1),
                                      pageBuilder: (_, __, ___) =>
                                          HappyShopStaggeredList()),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    // Women's Fashion //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: _getHeading("Women's Fashion"),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ScreenTypeLayout(
                        mobile: Container(
                          child: GridView.count(
                              padding: EdgeInsets.only(top: 5),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 0.7,
                              physics: NeverScrollableScrollPhysics(),
                              children: List.generate(
                                4,
                                (index) {
                                  return ItemCard(
                                    tag: "${index}1",
                                    imagurl: sectList[2]['productList'][index]
                                        ['img'],
                                    itemname: sectList[2]['productList'][index]
                                        ['name'],
                                    descprice: sectList[2]['productList'][index]
                                        ['descprice'],
                                    price: sectList[2]['productList'][index]
                                        ['price'],
                                    rating: sectList[2]['productList'][index]
                                        ['rating'],
                                    shadow: false,
                                  );
                                },
                              )),
                        ),
                        /* desktop: WomenFashionDesktop(
                          widget: GridView.count(
                            padding: EdgeInsets.only(top: 5),
                            crossAxisCount: 4,
                            shrinkWrap: true,
                            childAspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.width,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(
                              4,
                              (index) {
                                return ItemCard(
                                  tag: "${index}1",
                                  imagurl: sectList[2]['productList'][index]['img'],
                                  itemname: sectList[2]['productList'][index]['name'],
                                  descprice: sectList[2]['productList'][index]['descprice'],
                                  price: sectList[2]['productList'][index]['price'],
                                  rating: sectList[2]['productList'][index]['rating'],
                                  shadow: false,
                                );
                              },
                            ),
                          ),
                        ),*/
                      ),
                    ),

                    // Collections //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: _getHeading("Collections"),
                    ),
                    ScreenTypeLayout(
                      mobile: Container(
                        height: MediaQuery.of(context).size.width / 2,
                        child: ListView.builder(
                          itemCount: sectList[1]['productList'].length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? 15.0 : 5.0,
                                  right: index == 3 ? 15.0 : 0.0),
                              elevation: 0.0,
                              child: InkWell(
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 3,
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          sectList[1]['productList'][index]
                                              ['img'],
                                        ),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HappyShopStaggeredList(),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   PageRouteBuilder(transitionDuration: Duration(seconds: 1), pageBuilder: (_, __, ___) => HappyShopStaggeredList()),
                                  // );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      /*  desktop: CollectionsGridDektop(
                        widget: ListView.builder(
                          itemCount: sectList[1]['productList'].length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.only(left: index == 0 ? 15.0 : 5.0, right: index == 3 ? 15.0 : 0.0),
                              elevation: 0.0,
                              child: InkWell(
                                child: Container(
                                  height: MediaQuery.of(context).size.width / 3,
                                  width: MediaQuery.of(context).size.width / 4.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          sectList[1]['productList'][index]['img'],
                                        ),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HappyShopStaggeredList(),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),*/
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getHeading(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.headline6),
              InkWell(
                child: Text(
                  seeAll,
                  style: Theme.of(context).textTheme.caption,
                ),
                splashColor: primary.withOpacity(0.2),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(seconds: 1),
                        pageBuilder: (_, __, ___) => HappyShopStaggeredList()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 30)).then((_) {
      if (mounted) {
        int nextPage = _controller.hasClients
            ? (_controller.page?.round())! + 1
            : _controller.initialPage;

        if (nextPage == homeSliderList.length) {
          nextPage = 0;
        }
        if (_controller.hasClients)
          _controller
              .animateToPage(nextPage,
                  duration: Duration(seconds: 1), curve: Curves.easeIn)
              .then((_) => _animateSlider());
      }
    });
  }

  List<T> map<T>(List homeSliderList, Function handler) {
    List<T> result = [];
    for (var i = 0; i < homeSliderList.length; i++) {
      result.add(handler(i, homeSliderList[i]));
    }

    return result;
  }
}

class ItemCardSmall extends StatelessWidget {
  const ItemCardSmall({
    Key? key,
    this.imagurl,
    this.rating,
    this.itemname,
    this.descprice,
    this.price,
    this.shadow,
  }) : super(key: key);
  final String? imagurl, rating, itemname, descprice, price;
  final bool? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: happyshopcolor5, blurRadius: 10)],
      ),
      child: Card(
        elevation: 0.0,
        child: InkWell(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: CachedNetworkImage(
                            imageUrl: imagurl!,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(1.5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 10,
                              ),
                              Text(
                                rating!,
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    ?.copyWith(letterSpacing: 0.2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    itemname!,
                    style: Theme.of(context).textTheme.overline?.copyWith(
                        color: Colors.black,
                        fontSize: 16.0,
                        letterSpacing: 0.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(CUR_CURRENCY + "" + descprice!,
                                style: Theme.of(context)
                                    .textTheme
                                    .overline
                                    ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        letterSpacing: 1),
                                textAlign: TextAlign.left),
                            Text(
                              CUR_CURRENCY + " " + price!,
                              style: TextStyle(color: primary),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: primary,
                            ),
                          ),
                          onTap: () {})
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key? key,
    this.imagurl,
    this.rating,
    this.itemname,
    this.descprice,
    this.price,
    this.shadow,
    this.tag,
  }) : super(key: key);

  final String? imagurl, rating, itemname, descprice, price, tag;
  final bool? shadow;

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 100,
      decoration: widget.shadow!
          ? BoxDecoration(
              boxShadow: [BoxShadow(color: happyshopcolor5, blurRadius: 10)],
            )
          : null,
      child: Card(
        elevation: 0.2,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      child: Hero(
                          tag: widget.tag!,
                          child:
                              //  Image.network(
                              //   widget.imagurl,

                              //   fit: BoxFit.fill,
                              //   width: double.infinity,
                              //   //   // width: double.infinity,)
                              CachedNetworkImage(
                            imageUrl: widget.imagurl!,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          )
                          // ),
                          ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(1.5),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 10,
                            ),
                            Text(
                              widget.rating!,
                              style: Theme.of(context)
                                  .textTheme
                                  .overline
                                  ?.copyWith(letterSpacing: 0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 60,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.itemname!,
                        style: Theme.of(context).textTheme.overline?.copyWith(
                            color: Colors.black,
                            fontSize: 16.0,
                            letterSpacing: 0.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(" " + CUR_CURRENCY + " " + widget.price!,
                        style: TextStyle(color: primary)),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      CUR_CURRENCY + "" + widget.descprice!,
                      style: Theme.of(context).textTheme.overline?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          letterSpacing: 1),
                    ),
                  ],
                ),
              )
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return HappyShopProductDetail(
                    imgurl: widget.imagurl!,
                    tag: widget.tag!,
                  );
                },
                reverseTransitionDuration: Duration(milliseconds: 800),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: false,
          viewportFraction: 1.0,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          homeSliderList,
          (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? primary
                      : Color.fromRGBO(0, 0, 0, 0.1)),
            );
          },
        ),
      ),
    ]);
  }
}

final List<Widget> child = map<Widget>(
  homeSliderList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          CachedNetworkImage(
            imageUrl: i,
            fit: BoxFit.fill,
            width: 1000.0,
            height: double.infinity,
          ),
        ]),
      ),
    );
  },
).toList();

List homeSliderList = [
  "https://smartkit.wrteam.in/smartkit/happyshop/slider_a.png",
  "https://smartkit.wrteam.in/smartkit/happyshop/slider_b.png",
  "https://smartkit.wrteam.in/smartkit/happyshop/slider_c.png",
  "https://smartkit.wrteam.in/smartkit/happyshop/slider_d.png",
  "https://smartkit.wrteam.in/smartkit/happyshop/slider_e.png",
  "https://smartkit.wrteam.in/smartkit/happyshop/slider_f.png",
  "https://smartkit.wrteam.in/smartkit/happyshop/slider_g.png",
];
