import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:engishop/Helper/SmartKitColor.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({
    Key? key,
    @required this.imgurl,
    @required this.titletext,
    @required this.subtext,
  }) : super(key: key);

  final String? imgurl, titletext, subtext;
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin {
  late AnimationController _animationController, animationController;
  bool dragFromLeft = false;

  double opacityLevel = 0.0;
  late Animation animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout(
      mobile: Center(
        child: Container(
          padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: SvgPicture.network(widget.imgurl!),
                  ),
                  SizedBox(
                    height: width / 18,
                  ),
                ],
              ),
              FadeTransition(
                opacity:
                    animationController.drive(CurveTween(curve: Curves.easeIn)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    widget.titletext!,
                    style: TextStyle(
                        color: Color(0xFF656565),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FadeTransition(
                opacity:
                    animationController.drive(CurveTween(curve: Curves.easeIn)),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.subtext!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color1,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      /*desktop: IntroDesktop(
        imgurl: widget.imgurl!,
        animationController: animationController,
        titletext: widget.titletext!,
        subtext: widget.subtext!,
        color1: color1,
      ),*/
    );
  }
}
