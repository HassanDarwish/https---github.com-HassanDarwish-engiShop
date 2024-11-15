import 'package:cached_network_image/cached_network_image.dart'; 
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:GiorgiaShop/Screen/SmartKitAppbar.dart';
final List<String> imgList = [
  'https://smartkit.wrteam.in/smartkit/images/1573810839.3215.jpeg',
  'https://smartkit.wrteam.in/smartkit/images/fitness2.jpg',
  'https://smartkit.wrteam.in/smartkit/images/google.jpg',
  'https://smartkit.wrteam.in/smartkit/images/instagram.jpg',
  'https://smartkit.wrteam.in/smartkit/images/Fitness-gym-wallpaper.jpg'
];

final Widget placeholder = Container(color: Colors.grey);

final List child = map<Widget>(
  imgList,
      (index, i) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          CachedNetworkImage(
            imageUrl: i,
            fit: BoxFit.fill,
            width: 1000.0,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                'No. $index image',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({super.key});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child as List<Widget>,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
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
          imgList,
              (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? const Color.fromRGBO(0, 0, 0, 0.9)
                      : const Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}

class Image_Slider extends StatelessWidget {
  CarouselSliderController buttonCarouselController = CarouselSliderController();

  Image_Slider({super.key});
  //late CustomLayoutOption customLayoutOption;
  @override
  Widget build(BuildContext context) {
    //Manually operated Carousel
    final CarouselSlider manualCarouselDemo = CarouselSlider(
      items: child as List<Widget>,
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
      ),
    );

    //Auto playing carousel
    final CarouselSlider autoPlayDemo = CarouselSlider(
      items: imgList.map(
            (url) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
    );

    //Button controlled carousel
    Widget buttonDemo() {
      final basicSlider = CarouselSlider(
        carouselController: buttonCarouselController,
        items: child as List<Widget>,
        options: CarouselOptions(
          autoPlay: false,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          aspectRatio: 2.0,
        ),
      );
      return Column(children: [
        basicSlider,
        Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                onPressed: () => buttonCarouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear),
                child: const Text('PREV', style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                onPressed: () => buttonCarouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear),
                child: const Text('NEXT', style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ]),
      ]);
    }

    //Pages covers entire carousel
    final CarouselSlider coverScreenExample = CarouselSlider(
      items: map<Widget>(
        imgList,
            (index, i) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(i), fit: BoxFit.cover),
            ),
          );
        },
      ),
      options: CarouselOptions(
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        autoPlay: false,
        enlargeCenterPage: false,
      ),
    );

    //User input pauses carousels automatic playback
    final CarouselSlider touchDetectionDemo = CarouselSlider(
      items: imgList.map(
            (url) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 0.9,
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: true,
        pauseAutoPlayOnTouch: true,
      ),
    );

    //Non-looping manual Carousel
    final CarouselSlider nonLoopingCarousel = CarouselSlider(
      items: child as List<Widget>,
      options: CarouselOptions(
        enableInfiniteScroll: false,
        autoPlay: false,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.0,
      ),
    );

    //Vertical carousel
    final CarouselSlider verticalScrollCarousel = CarouselSlider(
      items: imgList.map(
            (url) {
          return Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        scrollDirection: Axis.vertical,
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        pauseAutoPlayOnTouch: true,
      ),
    );

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: SmartKitAppbar(
            title: "Image Slider",
          )),
      body: ListView(children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              const Text(
                'Manual Carousel',
                style: TextStyle(fontSize: 16),
              ),
              manualCarouselDemo,
            ])),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              const Text('Auto Playing', style: TextStyle(fontSize: 16)),
              autoPlayDemo,
            ])),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              const Text('Button Controlled', style: TextStyle(fontSize: 16)),
              buttonDemo(),
            ])),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              const Text('Full Screen', style: TextStyle(fontSize: 16)),
              coverScreenExample,
            ])),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              Text('Slider With Indicator', style: TextStyle(fontSize: 16)),
              CarouselWithIndicator(),
            ])),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              const Text('Pause When Touched', style: TextStyle(fontSize: 16)),
              touchDetectionDemo,
            ])),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              const Text('No infinity scroll', style: TextStyle(fontSize: 16)),
              nonLoopingCarousel,
            ])),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Column(children: [
              const Text('Vertical scroll', style: TextStyle(fontSize: 16)),
              verticalScrollCarousel,
            ])),
      ]),
    );
  }
}