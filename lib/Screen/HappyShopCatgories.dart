import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:engishop/Helper/HappyShopColor.dart';
import 'package:engishop/Helper/HappyShopString.dart';

class HappyShopCatogeryAll extends StatefulWidget {
  const HappyShopCatogeryAll({Key? key}) : super(key: key);

  @override
  _HappyShopCatogeryAllState createState() => _HappyShopCatogeryAllState();
}

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
        body: GridView.count(
            controller: controller,
            padding: const EdgeInsets.all(20),
            crossAxisCount: 4,
            shrinkWrap: true,
            childAspectRatio: .8,
            physics: const BouncingScrollPhysics(),
            children: List.generate(
              (offset < total) ? catList.length + 1 : catList.length,
              (index) {
                return (index == catList.length)
                    ? const Center(child: CircularProgressIndicator())
                    : catItem(index, context);
              },
            )));
  }

  Widget catItem(int index, BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: CachedNetworkImage(
                imageUrl: catList[index]['img'],
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              catList[index]['title'],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black),
            ),
          )
        ],
      ),
      onTap: () {},
    );
  }
}
