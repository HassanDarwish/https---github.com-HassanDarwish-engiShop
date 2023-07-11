import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';

class HappyShopProductPreview extends StatefulWidget {
  const HappyShopProductPreview({
    Key? key,
  }) : super(key: key);

  @override
  _HappyShopProductPreviewState createState() =>
      _HappyShopProductPreviewState();
}

class _HappyShopProductPreviewState extends State<HappyShopProductPreview> {
  int curPos = 0;

  List sliderList = [
    "https://smartkit.wrteam.in/smartkit/images/fitness2.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle2.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
    "https://smartkit.wrteam.in/smartkit/images/goggle3.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
      tag: "",
      child: Stack(
        children: <Widget>[
          PageView.builder(
              itemCount: sliderList.length,
              controller: PageController(initialPage: 0),
              onPageChanged: (index) {
                setState(() {
                  curPos = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return PhotoView(
                    backgroundDecoration: const BoxDecoration(color: Colors.white),
                    initialScale: PhotoViewComputedScale.contained * 0.9,
                    minScale: PhotoViewComputedScale.contained * 0.9,
                    imageProvider:
                        CachedNetworkImageProvider(sliderList[index]));
              }),
          Padding(
            padding: const EdgeInsets.only(top: 34.0),
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: primary,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          Positioned(
              bottom: 10.0,
              left: 25.0,
              right: 25.0,
              child: SelectedPhoto(
                numberOfDots: sliderList.length,
                photoIndex: curPos,
              )),
        ],
      ),
    ));
  }
}

class SelectedPhoto extends StatelessWidget {
  final int? numberOfDots;
  final int? photoIndex;

  const SelectedPhoto({super.key, this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: primary.withOpacity(0.4),
              borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, spreadRadius: 0.0, blurRadius: 2.0)
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots!; i++) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}
