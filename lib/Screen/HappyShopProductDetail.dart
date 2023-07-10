import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Helper/HappyShopString.dart';
//import 'package:engi_shop/HappyShop/desktop/detailproductdesktop.dart';

import 'HappyShopCart.dart';
import 'HappyShopProductPriview.dart';

class HappyShopProductDetail extends StatefulWidget {
  const HappyShopProductDetail({
    Key? key,
    this.imgurl,
    this.tag,
  }) : super(key: key);
  final String? imgurl, tag;
  @override
  _HappyShopProductDetailState createState() => _HappyShopProductDetailState();
}

class _HappyShopProductDetailState extends State<HappyShopProductDetail>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late ChoiceChip choiceChip;
  int _selVarient = 0, _oldSelVarient = 0;

  int offset = 0;
  int total = 0;
  bool isLoadingmore = true;
  ScrollController controller = ScrollController();

  bool _isCommentEnable = false;
  final TextEditingController _commentC = TextEditingController();
  double initialRate = 0;
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  List sliderList = [
    "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
  ];
  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

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

  List reviewList = [
    {""}
  ];

  @override
  void dispose() {
    //SystemChrome.setEnabledSystemUIOverlays(
    //  [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    buttonController.dispose();
    super.dispose();
  }

  _showContent() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            controller: controller,
            child: ScreenTypeLayout(
              mobile: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    splashColor: primary.withOpacity(0.2),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(seconds: 1),
                            pageBuilder: (_, __, ___) =>
                                const HappyShopProductPreview(),
                          ));
                    },
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Hero(
                            tag: widget.tag!,
                            child: CachedNetworkImage(
                              imageUrl: widget.imgurl!,
                              // fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: const Color(0xFF333333).withOpacity(0.5),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.favorite,
                                            color: const Color(0xFF333333)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        onTap: () {}),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: Stack(children: <Widget>[
                                        Center(
                                          child: Icon(
                                            Icons.shopping_cart_rounded,
                                            color: const Color(0xFF333333)
                                                .withOpacity(0.5),
                                            size: 26,
                                          ),
                                        ),
                                        (CUR_CART_COUNT.isNotEmpty &&
                                                CUR_CART_COUNT != "0")
                                            ? Positioned(
                                                top: 0.0,
                                                right: 5.0,
                                                bottom: 15,
                                                child: Container(
                                                    decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.red),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(4),
                                                        child: Text(
                                                          CUR_CART_COUNT,
                                                          style: const TextStyle(
                                                              fontSize: 8,
                                                              color:
                                                                  Colors.white),
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
                                              builder: (context) =>
                                                  const HappyShopCart(),
                                            ));
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  // _slider(),
                  const SizedBox(
                    height: 5.0,
                  ),
                  _rate(),
                  _price(),
                  _offPrice(),
                  _title(),
                  _desc(),
                  _selectVarientTitle(),
                  _getVarient(_selVarient),
                  _otherDetailsTitle(),
                  _madeIn(),
                  _cancleable(),
                  _ratingReview(),
                  _review(),
                  _rating(),
                  _writeReview()
                ],
              ),
              // desktop: ProductDetailsDesktop(
              //   imgurl: widget.imgurl,
              //   tag: widget.tag,
              //   listwidget: [
              //     _price(),
              //     _offPrice(),
              //     _title(),
              //     _desc(),
              //   ],
              // ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HappyShopCart(),
              ),
            );
          },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: happyshopgradient,
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Center(
                child: Text(
              "Add to Cart",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  _madeIn() {
    String madeIn = "India";
    return madeIn != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              trailing: Text(madeIn),
              dense: true,
              title: Text(
                'Made In',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          )
        : Container();
  }

  _rate() {
    return Row(
      children: [
        const Card(
          margin: EdgeInsets.only(left: 20.0, bottom: 5),
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 15,
                ),
                Text(" " "4.5")
              ],
            ),
          ),
        ),
        Text(
          " 150 Ratings",
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }

  _price() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Text("$CUR_CURRENCY 1200",
          style: Theme.of(context).textTheme.titleLarge),
    );
  }

  _offPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Text(
            "$CUR_CURRENCY 1100",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: TextDecoration.lineThrough,
                ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4.0)),
            child: Text("8.4" "% off",
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: primary, letterSpacing: 0.5)),
          ),
        ],
      ),
    );
  }

  _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Text(
        "Nike Shoes",
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Colors.black),
      ),
    );
  }

  _desc() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy"),
    );
  }

  _selectVarientTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        selectVarient,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: primary),
      ),
    );
  }

  _getVarient(int pos) {
    List<String> attrName = ["Size"];
    List<String> attrValue = ["7", "8"];

    return InkWell(
        onTap: _chooseVarient,
        child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: attrName.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                title: Text(
                  "${attrName[index]} : ${attrValue[index]}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: const Icon(Icons.keyboard_arrow_right),
              );
            }));
  }

  void _chooseVarient() {
    bool available = true;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    selectVarient,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Divider(),
                _title(),
                _price(),
                _offPrice(),
                Column(
                  children: [
                    const Text(
                      "Variant",
                      textAlign: TextAlign.left,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Center(
                              child: ChoiceChip(
                                key: const ValueKey<String>(
                                  "1",
                                ),
                                selected: false,
                                label: const Text("1",
                                    style: TextStyle(color: Colors.white)),
                                backgroundColor: primary.withOpacity(0.45),
                                selectedColor: primary,
                                disabledColor: primary.withOpacity(0.5),
                                onSelected: (bool selected) {
                                  setState(() {
                                    selected = false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ChoiceChip(
                              key: const ValueKey<String>(
                                "2",
                              ),
                              selected: true,
                              label: const Text("1",
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: primary.withOpacity(0.45),
                              selectedColor: primary,
                              disabledColor: primary.withOpacity(0.5),
                              onSelected: (bool selected) {
                                selected = false;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(right: 18.0, bottom: 8),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                      ),
                      onPressed: available ? applyVarient : null,
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
        });
  }

  applyVarient() {
    Navigator.of(context).pop();
    setState(() {
      _selVarient = _oldSelVarient;
    });
  }

  _otherDetailsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Text(
        'Other Details',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: primary),
      ),
    );
  }

  _cancleable() {
    String cancleable = "1";
    if (cancleable == "1") {
      cancleable = "Yes";
    } else {
      cancleable = "No";
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        trailing: Text(cancleable),
        dense: true,
        title: Text(
          'Cancleable',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }

  _ratingReview() {
    return
        // ("true" == "true" || reviewList.length > 0)
        //     ?
        Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Text(
        'Ratings & Reviews',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: primary),
      ),
    );
    // : Container();
  }

  _rating() {
    return Center(
      child: RatingBar.builder(
        initialRating: initialRate,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 32,
        itemPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {},
      ),
    );
  }

  _writeReview() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _commentC,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onChanged: (String val) {
              if (_commentC.text.trim().isNotEmpty) {
                setState(() {
                  _isCommentEnable = true;
                });
              } else {
                setState(() {
                  _isCommentEnable = false;
                });
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              prefixIcon: const Icon(Icons.rate_review, color: primary),
              hintText: 'Write your review..',
              hintStyle: TextStyle(color: primary.withOpacity(0.5)),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: IconButton(
              icon: Icon(
                Icons.send,
                color: _isCommentEnable ? primary : Colors.transparent,
              ),
              onPressed: () => _isCommentEnable == true),
        )
      ],
    );
  }

  _review() {
    List reviewList = [
      {
        'rating': "12",
        'username': "Mac",
        'date': "18/02/2021",
        'comment': "tetstetsttetstttetsttet"
      }
    ];
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: reviewList.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    color: primary,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 15,
                          ),
                          Text(
                            " " + reviewList[index]['rating'],
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text("  " + reviewList[index]['username']),
                  const Spacer(),
                  Text(reviewList[index]['date'])
                ],
              ),
              reviewList[index]['comment'] != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(reviewList[index]['comment'] ?? ''))
                  : Container(),
            ],
          );
        });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(0),
        //   child: AppBar(elevation: 0, brightness: Brightness.light, backgroundColor: Colors.white.withOpacity(0.8)),
        // ),
        body: Stack(
          children: <Widget>[
            _showContent(),
          ],
        ));
  }
}
