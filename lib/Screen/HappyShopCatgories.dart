import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import '../getIt/woocommecre/APICustomWooCommerce.dart';
import '../getIt/woocommecre/API_Woocommerce.dart';
import 'package:flutter_wp_woocommerce/woocommerce.dart';
import '../main.dart';
import '../pojo/products.dart';


import 'HappyShopStaggeredList.dart';
import 'package:get_it/get_it.dart';

class HappyShopCatogeryAll extends StatefulWidget {
  const HappyShopCatogeryAll({Key? key}) : super(key: key);

  @override
  _HappyShopCatogeryAllState createState() => _HappyShopCatogeryAllState();
}
GetIt getIt = GetIt.instance;
class _HappyShopCatogeryAllState extends State<HappyShopCatogeryAll> {
  int offset = perPage;
  int total = 0;
  ScrollController controller = ScrollController();
  List tempList = [];

  List catList = [
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Electronic.png",
      'title': "Electronics"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Household.png",
      'title': "Household"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Vegetables.png",
      'title': "Vegetables"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/fashion.png",
      'title': "fashion"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Grocery.png",
      'title': "Grocery"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/phone2.jpg",
      'title': "Phone"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/Nikereak4.jpg",
      'title': "Shoes"
    },
    {
      'img': "https://smartkit.wrteam.in/smartkit/images/1573810839.322.jpeg",
      'title': "Bag"
    },
  ];
  late products listProductByCategory;

  Future<List<WooProductCategory>> listAllCategories =getIt<API_Woocommerce>().listAllCategories;

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
      backgroundColor: Colors.white,
      //brightness: Brightness.light,
      elevation: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(ALL_CAT, context),
        body: Container(
    child: FutureBuilder<List<WooProductCategory>>(
    future: listAllCategories,
    builder: (context, snapshot) {
    if (snapshot.hasData) {
      List<WooProductCategory>? WooProductCategorydata =
          snapshot.data;
    return GridView.builder(
    itemCount: snapshot.data!.length-1,
    padding: const EdgeInsets.only(top: 5),

    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 4,
    childAspectRatio: 0.8,

    ),
        physics: const BouncingScrollPhysics(),
    itemBuilder: (context, index) {
      WooProductCategory? category =
      WooProductCategorydata?[index];
    return catItem(category!, context);
    }
    );} else if (snapshot.hasError) {
      return Text("Server Can not be reached  please check connection"); //Text(snapshot.error.toString());
    } else {
    // Show a circular progress indicator while loading products
    return Center(
    child: CircularProgressIndicator(),
    );}



    }))



      /*GridView.count(
            controller: controller,
            padding: const EdgeInsets.all(20),
            crossAxisCount: 4,
            shrinkWrap: true,
            childAspectRatio: .8,
            physics: const BouncingScrollPhysics(),
            children: List.generate(
              (offset < total) ? listCategories.length + 1 : catList.length,
              (index) {
                return (index == catList.length)
                    ? const Center(child: CircularProgressIndicator())
                    : catItem(index, context);
              },
            ))*/
    );
  }

  Widget catItem(WooProductCategory category, BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: (category.image!.src!),
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                category.name!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black),
              ),
            ),
          )
        ],
      ),
      onTap: ()    {
        Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration:
              const Duration(seconds: 1),
              pageBuilder: (_, __, ___) =>
                  HappyShopStaggeredList(
                    id: category.id!,
                    title: category.name!,
                  )),
        );
      },
    );
  }
}
