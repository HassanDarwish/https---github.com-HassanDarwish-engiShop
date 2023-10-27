import 'dart:math';

import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../pojo/products.dart';
import '../provider/woocommerceProvider.dart';
import 'HappyShopHomeTab.dart';
import 'HappyShopProductDetail.dart';

GetIt getIt = GetIt.instance;

class HappyShopStaggeredList extends StatefulWidget {
  int id = 0;
  String title = "";
  String? order;
  String? per_page;
  HappyShopStaggeredList({
    Key? key,
    required this.id,
    required this.title,
  }) : super(key: key);

  @override
  _HappyShopStaggeredListState createState() => _HappyShopStaggeredListState();
}

class _HappyShopStaggeredListState extends State<HappyShopStaggeredList>
    with TickerProviderStateMixin {
  final List _listUrl = [
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_a.png",
      'name': "Printed Men Round Neck Maroon T-Shirt",
      'descprice': "2500",
      'price': "3500",
      'rating': "4.5",
      'noOfRating': "90"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_a.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_4.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_d.png",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_5.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_6.png",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_b.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_7.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_8.png",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_9.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/brands_10.png",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_c.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man1.jpg",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man2.jpg",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man3.jpg",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man4.jpg",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man5.jpg",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man6.jpg",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/collections_d.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_a.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_b.png",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_c.png",
      'name': "Solid Men Round Neck Grey T-Shirt",
      'descprice': "1300",
      'price': "1400",
      'rating': "3.5",
      'noOfRating': "45"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/happyshop/man_d.png",
      'name': "Men Regular Fit Solid Casual Shirt",
      'descprice': "1700",
      'price': "2000",
      'rating': "4.5",
      'noOfRating': "150"
    },
  ];
  late products listProductByCategory;

  String? get order => null;

  late WoocommerceProvider woocommerceprovider;
  @override
  void initState() {
    super.initState();
    woocommerceprovider =
        Provider.of<WoocommerceProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((_) => woocommerceprovider.getProductByCategory("15"));
    // WidgetsBinding.instance.addPostFrameCallback((_) => woocommerceprovider.getProductBy_Category("15", "asc", "4"));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<product>> loadProducts(String? order, String? per_page) async {
    order == null
        ? listProductByCategory = await context
            .read<WoocommerceProvider>()
            .getProductByCategory(widget.id.toString())
        : listProductByCategory = await context
            .read<WoocommerceProvider>()
            .getProductBy_Category(widget.id.toString(), order, per_page!);

    return listProductByCategory.productList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              color: primary,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder<List<product>>(
          future: loadProducts(null, null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data?.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  raned = Random().nextInt(5);
                  raned.remainder(2) > 0 ? shrim = true : shrim = false;
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: StaggerdCard(
                          imgurl: snapshot.data?[index].img,
                          itemname: snapshot.data?[index].name,
                          descprice: Bidi.stripHtmlIfNeeded(
                              snapshot.data![index].description),
                          shortDescprice: Bidi.stripHtmlIfNeeded(
                              snapshot.data![index].short_description),
                          price: snapshot.data?[index].price,
                          itemid: snapshot.data?[index].id.toString(),
                          attributess: snapshot.data?[index].attributes,
                          shrim: shrim),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class StaggerdCard extends StatefulWidget {
  const StaggerdCard({
    Key? key,
    this.imgurl,
    this.itemid,
    this.itemname,
    this.price,
    this.descprice,
    this.shortDescprice,
    this.attributess,
    this.shrim,
  }) : super(key: key);
  final String? imgurl, itemid, itemname, price, descprice, shortDescprice;
  final bool? shrim;
  final List<attribute>? attributess;
  @override
  _StaggerdCardState createState() => _StaggerdCardState();
}

class _StaggerdCardState extends State<StaggerdCard> {
  final random = new Random();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.shrim!
          ? const BoxDecoration(
              boxShadow: [BoxShadow(color: happyshopcolor5, blurRadius: 10)],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            )
          : const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
      child: Card(
        elevation: 1.0,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 1000),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return HappyShopProductDetail(
                    itemid: widget.itemid,
                    imgurl: widget.imgurl!,
                    tag: Random().nextInt(1000).toString(),
                    title: widget.itemname!,
                    description: widget.descprice!,
                    shortdescription: widget.shortDescprice!,
                    price: widget.price!,
                    rating: random.nextInt(100).toString(), //"5",
                    review: "",
                    user_rating: "",
                    attributess: widget.attributess,
                  );
                },
                reverseTransitionDuration: const Duration(milliseconds: 800),
              ),
            );
          },
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                        borderRadius: widget.itemname != null
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5))
                            : BorderRadius.circular(5.0),
                        child: widget.shrim == true
                            ? Hero(
                                tag: Random().nextInt(1000).toString(),
                                child: Shimmer(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.imgurl!,
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                  ),
                                ),
                              )
                            : Hero(
                                tag: Random().nextInt(1000).toString(),
                                child: CachedNetworkImage(
                                  imageUrl: widget.imgurl!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              )),
                    /* we did removre rating and ad id
                    widget.rating != null
                        ? Card(
                            child: Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 10,
                                ),
                                Text(
                                  widget.rating!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(letterSpacing: 0.2),
                                ),
                              ],
                            ),
                          ))
                        : Container(),*/
                  ],
                ),
              ),
              widget.itemname != null
                  ? Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.itemname!,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      letterSpacing: 0.5),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              widget.price != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                                //" $CUR_CURRENCY ${widget.price!}",
                                " $ECUR_CURRENCY ${widget.price!}",
                                style: const TextStyle(color: primary)),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          widget.price != null
                              ? Flexible(
                                  child: Text(
                                    //"$CUR_CURRENCY${widget.descprice!}",
                                    widget.shortDescprice!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                            decoration: TextDecoration.none,
                                            fontSize: 12,
                                            letterSpacing: 1),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
