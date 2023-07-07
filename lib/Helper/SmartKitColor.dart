import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_builder/responsive_builder.dart';

// SmartKit Color //
final Color purpal = Color(0xff3d3270);
final Color purpalOpacity22 = purpal.withOpacity(0.22);

final Color smarKitcolor1 = Color(0xFFe59999);
final Color smarKitcolor2 = Color(0xFFFFFFFF);
final Color color1 = Color(0xFFFB2A59);
final Color color2 = Color(0xFF7E152D);
final Color color3 = Color(0xFF132735);
/*AppBarTheme appBarTheme() {
  return AppBarTheme(
    brightness: Brightness.light,
    elevation: 2.0,
    color: smarKitcolor2,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Color(0xFF020202),
        fontSize: 22.0,
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFF020202),
    ),
  );
}*/

List<Color> tilecolor = [
  Color(0xFFF5F9F9),
  Color(0xFFFEF4F4),
  Color(0xFFFDF9FB),
  Color(0xFFF6F5FB),
];
List<Color> tileiconbgcolor = [
  Color(0xFFCDE4E4),
  Color(0xFFFCE0DB),
  Color(0xFFFBD7ED),
  Color(0xFFE8E5F3),
];
List<Color> tiletextcolor = [
  Color(0xFF469695),
  Color(0xFFFD3627),
  Color(0xFFC93F8D),
  Color(0xFF3C326F),
];

// Grobag1 //

final Color grobag1 = Color(0xffF1FFF6);
final Color grobag2 = Color(0xff00B65F);
final Color grobag3 = Color(0xff005B30);
final Color grobag4 = Color(0xffF1FFF6);
final Color grobag5 = Color(0x3349DE7F);
final Color grobag6 = Color(0xFF9FF5CD);
final Color grobag7 = Colors.black;
final Color grobag8 = Color(0xFF777777);
Gradient grobaggradient = LinearGradient(
  begin: Alignment(1.0, 1.0),
  end: Alignment(-1.0, -1.0),
  colors: [grobag3, grobag2],
  stops: [0.1, 0.9],
);

// CryptoTech //

final Color cryptocolor1 = Color(0xfff4fdfe);
final Color cryptocolor2 = Color(0xff00e2d3);
final Color cryptocolor3 = Color(0xff00b3d5);
final Color cryptocolor4 = Color(0xfff4fdfe);
final Color cryptocolor5 = Color(0x3360efff);
final Color cryptocolor6 = Color(0xFFDBF4F6);
final Color cryptocolor7 = Colors.black;
final Color cryptocolor8 = Color(0xFF777777);

Gradient gradient = LinearGradient(
  colors: [
    cryptocolor3,
    cryptocolor2,
  ],
  stops: [0.1, 0.9],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

BoxShadow boxShadow = const BoxShadow(
  color: Colors.black12,
  offset: Offset(3, 3),
  blurRadius: 5,
);

BoxShadow transboxShadow = BoxShadow(
  color: Colors.white.withOpacity(0.0),
  offset: Offset(3, 3),
  blurRadius: 5,
);
BoxDecoration gradient_box = BoxDecoration(
  gradient: gradient,
  boxShadow: [
    boxShadow,
  ],
);

OutlineInputBorder outlineborderedittext = OutlineInputBorder(
  borderSide: BorderSide(width: 0.5, color: Colors.white),
  borderRadius: BorderRadius.circular(10.0),
);

Gradient appbargradient = LinearGradient(
    stops: [0, 1],
    begin: Alignment(-0.00, -1.00),
    end: Alignment(0.00, 1.00),
    colors: [cryptocolor2, cryptocolor3]);

BoxDecoration circulargradient_box = BoxDecoration(
  gradient: gradient,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    boxShadow,
  ],
);

BoxDecoration outlineboxtext = BoxDecoration(
  color: Colors.transparent,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(color: cryptocolor2, width: 0.5),
);

// BookKing //

final Color bookKing1 = Color(0xfff1f2ff);
final Color bookKing2 = Color(0xff789af9);
final Color bookKing3 = Color(0xff3b9ca9);
final Color bookKing4 = Color(0xfff1f2ff);
final Color bookKing5 = Color(0x33bcc1ff);
final Color bookKing6 = Color(0xFFD5D8FD);

Gradient bookKinggradient = LinearGradient(
  begin: Alignment(1.0, 1.0),
  end: Alignment(-1.0, -1.0),
  colors: [bookKing3, bookKing2],
  stops: [0.0, 1.0],
);

// // SmartKey //

final Color smartkey1 = Color(0xfff5fbf9);
final Color smartkey2 = Color(0xff69dea0);
final Color smartkey3 = Color(0xff3c9ea8);
final Color smartkey4 = Color(0xfff5fbf9);
final Color smartkey5 = Color(0x3379ffd2);
final Color smartkey6 = Color(0xFFD4FCEE);

Gradient smartkeygradient = LinearGradient(
  begin: Alignment(1.0, 1.0),
  end: Alignment(-1.0, -1.0),
  colors: [smartkey3, smartkey2],
  stops: [0.0, 1.0],
);

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xff3c9ea8), Color(0xff69dea0)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

// Music //
final Color music1 = Color(0xffFFEAF3);
final Color music2 = Color(0xffC40F8E);
final Color music3 = Color(0xffFB5293);
final Color music4 = Color(0xFFE99DBE);
final Color music5 = Color(0x33FFD9E8);
final Color music6 = Color(0xFFF8B1E3);

// Quotes //
final Color quotes1 = Color(0xffF8E9FF);
final Color quotes2 = Color(0xff6A0FC4);
final Color quotes3 = Color(0xffD998FA);
final Color quotes4 = Color(0xffF8E9FF);
final Color quotes5 = Color(0x33A4A7FF);
final Color quotes6 = Color(0xFFDBBFF8);

// WebApp //
final Color webApp1 = Color(0xffD8F1FF);
final Color webApp2 = Color(0xff1D6CBA);
final Color webApp3 = Color(0xff54C1FF);
final Color webApp4 = Color(0xffD8F1FF);
final Color webApp5 = Color(0x337BCFFE);
final Color webApp6 = Color(0xFFAFD0F1);

// eStudy //

final Color eStudy1 = Color(0xfff7f1ff);
final Color eStudy2 = Color(0xff838aea);
final Color eStudy3 = Color(0xff796fc1);
final Color eStudy4 = Color(0xfff7f1ff);
final Color eStudy5 = Color(0x33cca7ff);
final Color eStudy6 = Color(0xFFDFCCF8);

// FoodMaster //

final Color foodmaster1 = Color(0xfffef4f4);
final Color foodmaster2 = Color(0xffffcca6);
final Color foodmaster3 = Color(0xffff9b9c);
final Color foodmaster4 = Color(0xfffef4f4);
final Color foodmaster5 = Color(0x33ffa4a4);
final Color foodmaster6 = Color(0xFFFDDCDC);

// News //
final Color news1 = Color(0xfff1f2ff);
final Color news2 = Color(0xff7D8CEB);
final Color news3 = Color(0xff345EB4);
final Color news4 = Color(0xfff1f2ff);
final Color news5 = Color(0x33bcc1ff);
final Color news6 = Color(0xFFFDDCDC);

// VPN //
final Color vpn11 = Color(0xffFEFAF1);
final Color vpn22 = Color(0xffF7C331);
final Color vpn33 = Color(0xffF7882F);
final Color vpn44 = Color(0xfff7f1ff);
final Color vpn55 = Color(0x33FFA7A7);
final Color vpn66 = Color(0xFFFAE9BB);
final Color vpn77 = Color(0xFF777777);

Gradient vpntopgradient = LinearGradient(
  colors: [
    vpn22,
    vpn33,
  ],
  stops: [0.7, 0.3],
  /*stops: [
      0.2453960627317429, 1
    ],*/
  /* begin: Alignment.topLeft,
    end: Alignment.bottomRight,*/
  begin: Alignment(-0.91, -0.42),
  end: Alignment(0.91, 0.42),
);

BoxDecoration vpncirculargradient_box = BoxDecoration(
  gradient: vpngradient,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    boxShadow,
  ],
);

Gradient vpngradient = LinearGradient(
  colors: [
    vpn22,
    vpn33,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

BoxDecoration vpngradient_box = BoxDecoration(
  gradient: vpngradient,
  boxShadow: [
    boxShadow,
  ],
);

BoxDecoration vpntopradiusbox = BoxDecoration(
  gradient: vpngradient,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  boxShadow: [
    boxShadow,
  ],
);

Widget vpnSetBottomNavigation(
    int pos, BuildContext bcontext, bool fromotherpage) {
  bool ismain = false;
  if (pos == 0 || fromotherpage) ismain = true;

  return new BottomAppBar(
    color: vpn11,
    child: ScreenTypeLayout(
      desktop: Container(
        decoration: vpntopradiusbox,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    if (pos != 0) {
                      //Navigator.of(bcontext).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainActivity()), (Route<dynamic> route) => false);
                      Navigator.of(bcontext).pop();
                    }
                  },
                  icon: SvgPicture.network(pos == 0
                      ? 'https://smartkit.wrteam.in/smartkit/vpn/sel_home.svg'
                      : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_home.svg')),
              /*IconButton(
              onPressed: () {
                if (pos != 1) {
                  if (ismain)
                    Navigator.push(bcontext, MaterialPageRoute(builder: (context) => VpnSelectVpnDesktop()));
                  else
                    Navigator.pushReplacement(bcontext, MaterialPageRoute(builder: (context) => VpnSelectVpnDesktop()));
                }
              },
              icon: SvgPicture.network(pos == 1 ? 'https://smartkit.wrteam.in/smartkit/vpn/selected_location.svg' : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_location.svg')),*/
              /*IconButton(
              onPressed: () {
                if (pos != 3) {
                  if (ismain)
                    Navigator.push(bcontext, MaterialPageRoute(builder: (context) => VpnSubscriptionDetailDesktop()));
                  else
                    Navigator.pushReplacement(bcontext, MaterialPageRoute(builder: (context) => VpnSubscriptionDetailDesktop()));
                }
              },
              icon: SvgPicture.network(pos == 3 ? 'https://smartkit.wrteam.in/smartkit/vpn/sel_premium.svg' : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_premium.svg')),*/
            ]),
      ),
      mobile: Container(
        decoration: vpntopradiusbox,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    if (pos != 0) {
                      //Navigator.of(bcontext).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainActivity()), (Route<dynamic> route) => false);
                      Navigator.of(bcontext).pop();
                    }
                  },
                  icon: SvgPicture.network(pos == 0
                      ? 'https://smartkit.wrteam.in/smartkit/vpn/sel_home.svg'
                      : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_home.svg')),
              /*IconButton(
              onPressed: () {
                if (pos != 1) {
                  if (ismain)
                    Navigator.push(bcontext, MaterialPageRoute(builder: (context) => VpnSelectVpnMobile()));
                  else
                    Navigator.pushReplacement(bcontext, MaterialPageRoute(builder: (context) => VpnSelectVpnMobile()));
                }
              },
              icon: SvgPicture.network(pos == 1 ? 'https://smartkit.wrteam.in/smartkit/vpn/selected_location.svg' : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_location.svg')),
          IconButton(
              onPressed: () {
                if (pos != 3) {
                  if (ismain)
                    Navigator.push(bcontext, MaterialPageRoute(builder: (context) => VpnSubscriptionDetailMobile()));
                  else
                    Navigator.pushReplacement(bcontext, MaterialPageRoute(builder: (context) => VpnSubscriptionDetailMobile()));
                }
              },
              icon: SvgPicture.network(pos == 3 ? 'https://smartkit.wrteam.in/smartkit/vpn/sel_premium.svg' : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_premium.svg')),*/
            ]),
      ),
      tablet: Container(
        decoration: vpntopradiusbox,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    if (pos != 0) {
                      //Navigator.of(bcontext).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MainActivity()), (Route<dynamic> route) => false);
                      Navigator.of(bcontext).pop();
                    }
                  },
                  icon: SvgPicture.network(pos == 0
                      ? 'https://smartkit.wrteam.in/smartkit/vpn/sel_home.svg'
                      : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_home.svg')),
              /*IconButton(
              onPressed: () {
                if (pos != 1) {
                  if (ismain)
                    Navigator.push(bcontext, MaterialPageRoute(builder: (context) => VpnSelectVpnTablet()));
                  else
                    Navigator.pushReplacement(bcontext, MaterialPageRoute(builder: (context) => VpnSelectVpnTablet()));
                }
              },
              icon: SvgPicture.network(pos == 1 ? 'https://smartkit.wrteam.in/smartkit/vpn/selected_location.svg' : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_location.svg')),
          IconButton(
              onPressed: () {
                if (pos != 3) {
                  if (ismain)
                    Navigator.push(bcontext, MaterialPageRoute(builder: (context) => VpnSubscriptionDetailTablet()));
                  else
                    Navigator.pushReplacement(bcontext, MaterialPageRoute(builder: (context) => VpnSubscriptionDetailTablet()));
                }
              },
              icon: SvgPicture.network(pos == 3 ? 'https://smartkit.wrteam.in/smartkit/vpn/sel_premium.svg' : 'https://smartkit.wrteam.in/smartkit/vpn/unsel_premium.svg')),*/
            ]),
      ),
    ),
  );
}

Widget vpnSetAppbar(String bartitle) {
  return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0,
      flexibleSpace:
          Container(width: double.infinity, decoration: vpngradient_box),
      centerTitle: true,
      title: Text(bartitle, style: TextStyle(color: Colors.white)));
}

BoxDecoration vpncircularbox(Color color) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10),
    /* boxShadow: [
      boxShadow,
    ],*/
  );
}
