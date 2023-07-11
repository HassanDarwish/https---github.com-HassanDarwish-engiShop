import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:GiorgiaShop/Helper/HappyShopColor.dart';
import 'package:GiorgiaShop/Helper/HappyShopString.dart';
import 'package:GiorgiaShop/widget/HappyShopbtn.dart';

import 'HappyShopHome.dart';

class HappyShopPeofile extends StatefulWidget {
  const HappyShopPeofile({Key? key}) : super(key: key);

  @override
  _HappyShopPeofileState createState() => _HappyShopPeofileState();
}

class _HappyShopPeofileState extends State<HappyShopPeofile>
    with TickerProviderStateMixin {
  String? name, email, mobile, city, area, pincode, address, image;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? nameC, emailC, mobileC, pincodeC, addressC;
  bool isDateSelected = false;
  DateTime? birthDate;
  bool isSelected = false;
  final bool _isNetworkAvail = true;
  late Animation buttonSqueezeanimation;
  late AnimationController buttonController;

  @override
  void initState() {
    super.initState();
    image = "https://smartkit.wrteam.in/smartkit/images/profile2.png";
    mobileC = TextEditingController();
    nameC = TextEditingController();
    emailC = TextEditingController();
    pincodeC = TextEditingController();
    addressC = TextEditingController();

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
    mobileC?.dispose();
    nameC?.dispose();
    addressC!.dispose();
    pincodeC?.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController.forward();
    } on TickerCanceled {}
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      checkNetwork();
    }
  }

  Future<void> checkNetwork() async {
    if (_isNetworkAvail) {
    } else {
      Future.delayed(const Duration(seconds: 2)).then((_) async {
        await buttonController.reverse();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HappyShopHome()));
      });
    }
  }

  bool validateAndSave() {
    final form = _formkey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    }

    return false;
  }

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
      // brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 5,
    );
  }

  _showContent() {
    return ScreenTypeLayout(
      mobile: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: <Widget>[
                profileImage(),
                setUserName(),
                setEmail(),
                setMobileNo(),
                setAddress(),
                setPincode(),
                updateBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  profileImage() {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Stack(
          children: <Widget>[
            image != null && image != ""
                ? CircleAvatar(
                    radius: 50,
                    backgroundColor: primary,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: image!,
                          fit: BoxFit.fill,
                          width: 100,
                          height: 100,
                        )))
                : CircleAvatar(
                    radius: 50,
                    backgroundColor: primary,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: primary)),
                        child: const Icon(Icons.person, size: 100)),
                  ),
            Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      border: Border.all(color: primary)),
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: primary,
                      size: 15,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                )),
          ],
        ));
  }

  updateBtn() {
    return AppBtn(
      title: UPDATE_PROFILE_LBL,
      btnAnim: buttonSqueezeanimation,
      btnCntrl: buttonController,
      onBtnSelected: () {
        validateAndSubmit();
      },
    );
  }

  setUserName() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: nameC,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: darkgrey),
        onChanged: (v) => setState(() {
          name = v;
        }),
        onSaved: (String? value) {
          name = value;
        },
        decoration: InputDecoration(
          hintText: NAMEHINT_LBL,
          hintStyle: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: darkgrey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(right: 30.0, left: 30.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  setMobileNo() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: mobileC,
          readOnly: true,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: darkgrey),
          decoration: InputDecoration(
            hintText: MOBILEHINT_LBL,
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: darkgrey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(right: 30.0, left: 30.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  setEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: emailC,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: darkgrey),
          onChanged: (v) => setState(() {
            email = v;
          }),
          onSaved: (String? value) {
            email = value;
          },
          decoration: InputDecoration(
            hintText: EMAILHINT_LBL,
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: darkgrey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(right: 30.0, left: 30.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  setAddress() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: addressC,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: darkgrey),
                onChanged: (v) => setState(() {
                  address = v;
                }),
                onSaved: (String? value) {
                  address = value;
                },
                decoration: InputDecoration(
                  hintText: ADDRESS_LBL,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: darkgrey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(right: 30.0, left: 30.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: white),
                  color: white),
              child: IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () async {},
              ),
            )
          ],
        ));
  }

  setPincode() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: pincodeC,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: darkgrey),
          onChanged: (v) => setState(() {
            pincode = v;
          }),
          onSaved: (String? value) {
            pincode = value;
          },
          decoration: InputDecoration(
            hintText: PINCODEHINT_LBL,
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: darkgrey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(right: 30.0, left: 30.0),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool resul = await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HappyShopHome(),
          ),
        );
        resul ??= false;

        return resul;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: lightgrey,
        appBar: getAppBar(PROFILE, context),
        body: Center(
          child: _showContent(),
        ),
      ),
    );
  }
}
