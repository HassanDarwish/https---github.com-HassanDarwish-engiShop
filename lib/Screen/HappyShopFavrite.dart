import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:GiorgiaShop/pojo/favorit/Favorit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:GiorgiaShop/provider/Session.dart';
import 'package:GiorgiaShop/provider/woocommerceProvider.dart';
import 'package:GiorgiaShop/pojo/products.dart';
import 'HappyShopHome.dart';
import 'HappyShopProductDetail.dart';
import 'package:provider/provider.dart';

class HappyShopFavrite extends StatefulWidget  {
  final bool? appbar;
  final GlobalKey<ScaffoldState> scaffoldKey ;
    HappyShopFavrite({Key? key, this.appbar, required this.scaffoldKey}) : super(key: key);
  late    SessionImplementation sessionImp ;
  late WoocommerceProvider CustWoocommerceProvider;
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
  List<Favorit> favList = List.empty(growable: true);


  void refresh(String itemid) {
   setState(() {

   });
    // notifyListeners();
  }
  @override
  void initState() {
    super.initState();
    widget.CustWoocommerceProvider =
        Provider.of<WoocommerceProvider>(context, listen: false);
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
  List<Favorit> loadProducts(){
    return  widget.sessionImp.favoritList; ;
  }
  void onSubmit(String itemid) {
    widget.sessionImp.favoritList.removeWhere((element) => element.id==itemid);
    setState(() {
    });
    //notifyListeners();
  }
  cartEmpty() {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1.1,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            noCartImage(context),
            noCartText(context),
            noCartDec(context),
            shopNow()
          ]),
        ),
      ),
    );
  }
  noCartText(BuildContext context) {
    return Container(
        child: Text(NO_FavoritList,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: primary, fontWeight: FontWeight.normal)));
  }
  noCartDec(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
      child: Text(Favorit_DESC,
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
            child: Text(Login_DESC,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: white, fontWeight: FontWeight.normal))),
        onPressed: () {

          widget.scaffoldKey.currentState?.openDrawer();
          /*Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>   HappyShopHome()),
              ModalRoute.withName('/'));*/
        },
      ),
    );
  }

  noCartImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'http://jerma.net/Engi/icons/empty_cart.png',
      fit: BoxFit.contain,
    );
  }

  _showContent() {
    return widget.sessionImp.favoritList.isEmpty
        ? SingleChildScrollView(
      child: cartEmpty(),
    )

        : Consumer<SessionImplementation>(builder:(context ,sessionImp,child) {
      return GridView.builder(
        itemCount: sessionImp.favoritList.length - 1,
        padding: const EdgeInsets.only(top: 5),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,

        ),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return StaggerdCard(
            imgurl: sessionImp.favoritList[index].image_url,
            itemname: sessionImp.favoritList[index].post_title,
            descprice: Bidi.stripHtmlIfNeeded(
                sessionImp.favoritList[index].post_content),
            shortDescprice: Bidi.stripHtmlIfNeeded(
                sessionImp.favoritList[index].post_excerpt),
            price: sessionImp.favoritList[index].price,
            itemid: sessionImp.favoritList[index].id.toString(),
            attributess: sessionImp.favoritList[index].attributes,
            shrim: false,
            onSubmit: onSubmit,
          );
        }
    );
          },);





  }

  Widget listItem(int index) {
    double star_rate=double.parse(Random().nextDouble().toStringAsFixed(1));
    if(star_rate<5)
      star_rate=star_rate+4;
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
                      itemid:widget.sessionImp.favoritList[index].id.toString(),
                      imgurl: widget.sessionImp.favoritList[index].image_url,
                      tag: Random().nextInt(100000).toString(),
                      title: widget.sessionImp.favoritList[index].post_title,
                      shortdescription: widget.sessionImp.favoritList[index].post_excerpt,
                      description:widget.sessionImp.favoritList[index].post_content ,
                      attributess: [],
                      price:widget.sessionImp.favoritList[index].price ,
                      rating:star_rate.toString() ,
                      review: "",
                      user_rating: "",

                    )),
          );
        },
        child: SingleChildScrollView (
          child: Row(

            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                  tag: Random().nextInt(100000).toString(),
                  child: CachedNetworkImage(
                    imageUrl: widget.sessionImp.favoritList[index].image_url,
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
                                widget.sessionImp.favoritList[index].post_title,
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
                                widget.sessionImp.favoritList.removeAt(index);
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
                              " " + star_rate.toString(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text("",
                              //"${" (" + favList[index]['noOfRating']})",
                              style: Theme.of(context).textTheme.labelSmall,
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !bool.parse(widget.sessionImp.favoritList[index].has_attributes),
                        child: Row(
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
                                  onTap: () {
                                    //navigation
                                  },
                                ),
                                Text("",
                                  //favList[index]['cartCount'],
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
                                  onTap: () {
                                    //navigation
                                  },
                                )
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: <Widget>[
                                Text(
                                  widget.sessionImp.favoritList[index].post_excerpt,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          decoration: TextDecoration.lineThrough,
                                          letterSpacing: 0.7),
                                ),
                                Text(widget.sessionImp.favoritList[index].price,
                                    //favList[index]['price'],
                                    style: Theme.of(context).textTheme.titleLarge),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    GlobalKey<RefreshIndicatorState>();
    widget.sessionImp = Provider.of<SessionImplementation>(context,listen: true);

    if(widget.sessionImp.favoritList.isNotEmpty)
      favList=widget.sessionImp.favoritList;

     Future<void> _refresh() async {
       await Future<void>.delayed(const Duration(milliseconds: 1500));
       setState(() {});
    }
    return WillPopScope(
      onWillPop: () async {
        bool? result = await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>   HappyShopHome(),
          ),
        );
        result ??= false;
        return result;
      },
      child: Scaffold(
        appBar: widget.appbar == true
            ? AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pushNamed(HappyShopHome.routeName),
                ),
                title: const Text(
                  "Favrite",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : PreferredSize(preferredSize: const Size.fromHeight(0), child: AppBar()),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                _showContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StaggerdCard extends StatefulWidget {
   void Function( String itemid) onSubmit;
  StaggerdCard({
    Key? key,
    this.imgurl,
    required this.itemid,
    this.itemname,
    this.price,
    this.descprice,
    this.shortDescprice,
    this.attributess,
    this.shrim,
    required this.onSubmit,
  }) : super(key: key) {

  }
  final String? imgurl, itemname, price, descprice, shortDescprice;
  String itemid;
  HappyShopFavrite? HappyShop_Favrite;
  final bool? shrim;

  late    SessionImplementation sessionImp ;
  late WoocommerceProvider CustWoocommerceProvider;

  final List<attribute>? attributess;
  @override
  _StaggerdCardState createState() => _StaggerdCardState();
}
class _StaggerdCardState extends State<StaggerdCard> {

  void initState() {
    super.initState();


  }
  final random = new Random();
  @override
  Widget build(BuildContext context) {
    widget.sessionImp =
        Provider.of<SessionImplementation>(context, listen: false);
    widget.CustWoocommerceProvider =
        Provider.of<WoocommerceProvider>(context, listen: false);
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
          child: Stack(
            children: [Column(
              children: [
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.only(
                        left: 8.0, right: 8, bottom: 8),
                    child: Icon(
                      Icons.close,
                      size: 21,
                    ),
                  ),
                  onTap: ()async {
                    bool result=await widget.CustWoocommerceProvider.deleteFromFavorite(widget.sessionImp,widget.sessionImp.userID,widget.itemid);
                    //widget.HappyShop_Favrite?.refresh(widget.itemid);
                    widget.onSubmit(widget.itemid);
                    setState(() {

                    });

                  },
                ),
                SizedBox(
                  width: 10,
                ),
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
            )],
          ),
        ),
      ),
    );
  }
}